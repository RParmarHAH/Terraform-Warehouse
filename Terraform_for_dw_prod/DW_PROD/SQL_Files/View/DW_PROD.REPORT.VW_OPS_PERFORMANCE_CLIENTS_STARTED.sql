create or replace view DW_PROD.REPORT.VW_OPS_PERFORMANCE_CLIENTS_STARTED(
	PERIOD_BEGIN_DATE,
	CLIENT_KEY,
	REVENUE_CATEGORY,
	REVENUE_SUBCATEGORY_CODE,
	REVENUE_SUBCATEGORY_NAME,
	FIRST_SERVICE_DATE,
	FIRST_BRANCH_KEY,
	FIRST_SUPERVISOR_KEY
) as
WITH NEW_CLIENTS AS (
	SELECT DISTINCT MIN(CLIENTS.PERIOD_BEGIN_DATE) OVER(PARTITION BY CLIENTS.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY) AS PERIOD_BEGIN_DATE,
		CLIENTS.CLIENT_KEY,
		CONTRACTS.REVENUE_CATEGORY,
		CONTRACTS.REVENUE_SUBCATEGORY_CODE,
		CONTRACTS.REVENUE_SUBCATEGORY_NAME,
		MIN(MIN(CLIENTS.FIRST_SERVICE_DATE)) OVER(PARTITION BY CLIENTS.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY) AS FIRST_SERVICE_DATE,
		FIRST_VALUE(CLIENTS.FIRST_BRANCH_KEY) OVER(PARTITION BY CLIENTS.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY ORDER BY MIN(CLIENTS.FIRST_SERVICE_DATE), SUM(CLIENTS.HOURS_SERVED) DESC) AS FIRST_BRANCH_KEY,
		FIRST_VALUE(CLIENTS.FIRST_SUPERVISOR_KEY) OVER(PARTITION BY CLIENTS.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY ORDER BY MIN(CLIENTS.FIRST_SERVICE_DATE), SUM(CLIENTS.HOURS_SERVED) DESC) AS FIRST_SUPERVISOR_KEY
	FROM REPORT.CLIENTS_STARTED CLIENTS
	JOIN REPORT.VW_DASHBOARD_CONTRACTS CONTRACTS
		ON CONTRACTS.CONTRACT_KEY = CLIENTS.CONTRACT_KEY
	WHERE CONTRACTS.INCLUDE_FOR_OPS_PERF_CLIENTS=1
	GROUP BY CLIENTS.PERIOD_BEGIN_DATE,
		CLIENTS.CLIENT_KEY,
		CONTRACTS.REVENUE_CATEGORY,
		CONTRACTS.REVENUE_SUBCATEGORY_NAME,
		CONTRACTS.REVENUE_SUBCATEGORY_CODE,
		CLIENTS.FIRST_BRANCH_KEY,
		CLIENTS.FIRST_SUPERVISOR_KEY
), CLIENTS_STARTED_BY_CATEGORY AS (
	SELECT CLIENTS.*
	FROM NEW_CLIENTS CLIENTS
	JOIN REPORT.VW_OPS_PERFORMANCE_DIM_DATE DATES
		ON DATES.PERIOD_BEGIN_DATE = CLIENTS.PERIOD_BEGIN_DATE
    WHERE 
 DATES.PERIOD_BEGIN_DATE BETWEEN DATE_TRUNC(MONTH, DATEADD(MONTH, -14, CURRENT_DATE())) AND DATE_TRUNC(MONTH, DATEADD(MONTH, -1, CURRENT_DATE()))
)
	SELECT PERIOD_BEGIN_DATE,
		CLIENT_KEY,
		REVENUE_CATEGORY,
        REVENUE_SUBCATEGORY_CODE,
		REVENUE_SUBCATEGORY_NAME,
		FIRST_SERVICE_DATE,
		FIRST_BRANCH_KEY,
		FIRST_SUPERVISOR_KEY
	FROM CLIENTS_STARTED_BY_CATEGORY
    ORDER BY PERIOD_BEGIN_DATE;