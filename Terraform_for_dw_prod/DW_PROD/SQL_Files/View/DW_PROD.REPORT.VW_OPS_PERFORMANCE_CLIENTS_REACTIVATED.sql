create or replace view DW_PROD.REPORT.VW_OPS_PERFORMANCE_CLIENTS_REACTIVATED(
	CLIENT_KEY,
	PERIOD_BEGIN_DATE,
	REVENUE_CATEGORY,
	REVENUE_SUBCATEGORY_CODE,
	REVENUE_SUBCATEGORY_NAME,
	FIRST_SERVICE_DATE,
	CURRENT_BRANCH_KEY,
	CURRENT_SUPERVISOR_KEY
) as
WITH NEW_AND_REACTIVATED_CLIENTS AS ( 
	SELECT DISTINCT LIST.PERIOD_BEGIN_DATE,
		LIST.CLIENT_KEY,
		CONTRACTS.REVENUE_CATEGORY,
        CONTRACTS.REVENUE_SUBCATEGORY_CODE,
        CONTRACTS.REVENUE_SUBCATEGORY_NAME,
		MIN(MIN(LIST.FIRST_SERVICE_DATE)) OVER(PARTITION BY LIST.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY) AS FIRST_SERVICE_DATE,
		FIRST_VALUE(LIST.FIRST_BRANCH_KEY) OVER(PARTITION BY LIST.PERIOD_BEGIN_DATE, LIST.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY ORDER BY SUM(LIST.HOURS_SERVED) DESC) AS BRANCH_KEY,
		FIRST_VALUE(LIST.FIRST_SUPERVISOR_KEY) OVER(PARTITION BY LIST.PERIOD_BEGIN_DATE, LIST.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY ORDER BY SUM(LIST.HOURS_SERVED) DESC) AS SUPERVISOR_KEY
	FROM (
		SELECT PERIOD_BEGIN_DATE, CLIENT_KEY, CONTRACT_KEY, FIRST_SERVICE_DATE, FIRST_BRANCH_KEY, FIRST_SUPERVISOR_KEY, HOURS_SERVED
		FROM REPORT.CLIENTS_STARTED
		UNION ALL
		SELECT PERIOD_BEGIN_DATE, CLIENT_KEY, CONTRACT_KEY, FIRST_SERVICE_DATE, CURRENT_BRANCH_KEY, CURRENT_SUPERVISOR_KEY, HOURS_SERVED
		FROM REPORT.CLIENTS_REACTIVATED 
	) LIST
	JOIN REPORT.VW_DASHBOARD_CONTRACTS CONTRACTS
		ON CONTRACTS.CONTRACT_KEY = LIST.CONTRACT_KEY
    WHERE CONTRACTS.INCLUDE_FOR_OPS_PERF_CLIENTS = 1
	GROUP BY LIST.PERIOD_BEGIN_DATE,
		LIST.CLIENT_KEY,
		CONTRACTS.REVENUE_CATEGORY,
        CONTRACTS.REVENUE_SUBCATEGORY_CODE,
        CONTRACTS.REVENUE_SUBCATEGORY_NAME,
		LIST.FIRST_BRANCH_KEY,
		LIST.FIRST_SUPERVISOR_KEY
), REACTIVATED_CLIENTS_BY_CONTRACT AS (
	SELECT DISTINCT CLIENTS.PERIOD_BEGIN_DATE, 
		CLIENTS.CLIENT_KEY,
		CLIENTS.REVENUE_CATEGORY,
		CLIENTS.REVENUE_SUBCATEGORY_CODE,
        CLIENTS.REVENUE_SUBCATEGORY_NAME,
		CLIENTS.FIRST_SERVICE_DATE,
		CLIENTS.BRANCH_KEY,
		CLIENTS.SUPERVISOR_KEY
	FROM NEW_AND_REACTIVATED_CLIENTS CLIENTS
	JOIN REPORT.VW_OPS_PERFORMANCE_DIM_DATE DATES
		ON DATES.PERIOD_BEGIN_DATE = CLIENTS.PERIOD_BEGIN_DATE
	WHERE 
  DATES.PERIOD_BEGIN_DATE BETWEEN DATE_TRUNC(MONTH, DATEADD(MONTH, -14, CURRENT_DATE())) AND DATE_TRUNC(MONTH, DATEADD(MONTH, -1, CURRENT_DATE()))
  AND 
  CLIENTS.FIRST_SERVICE_DATE < CLIENTS.PERIOD_BEGIN_DATE
), VISITS_BY_CATEGORY AS (
	SELECT DATE_TRUNC(MONTH, VISIT.REPORT_DATE) AS PERIOD_BEGIN_DATE, 
		VISIT.CLIENT_KEY, 
		CONTRACTS.REVENUE_CATEGORY
	FROM HAH.FACT_VISIT VISIT
	JOIN REPORT.VW_DASHBOARD_CONTRACTS CONTRACTS
		ON CONTRACTS.CONTRACT_KEY = VISIT.CONTRACT_KEY
    WHERE CONTRACTS.INCLUDE_FOR_OPS_PERF_CLIENTS = 1
		AND VISIT.CONFIRMED_FLAG = 'YES' -- VISIT.STATUS_CODE IN ('02','03','04','05') --STATUS CODE FOR CONFIRMED VISITS 
		AND VISIT.HOURS_SERVED > 0
	GROUP BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, CONTRACTS.REVENUE_CATEGORY
), REACTIVATED_CLIENTS AS (
	SELECT REACTIVATED.PERIOD_BEGIN_DATE,
		REACTIVATED.CLIENT_KEY,
		REACTIVATED.REVENUE_CATEGORY,
		REACTIVATED.REVENUE_SUBCATEGORY_CODE,
		REACTIVATED.REVENUE_SUBCATEGORY_NAME,
		REACTIVATED.FIRST_SERVICE_DATE,
		REACTIVATED.BRANCH_KEY AS CURRENT_BRANCH_KEY,
		REACTIVATED.SUPERVISOR_KEY AS CURRENT_SUPERVISOR_KEY
	FROM REACTIVATED_CLIENTS_BY_CONTRACT REACTIVATED
	LEFT JOIN VISITS_BY_CATEGORY PREVIOUS_PERIOD
		ON PREVIOUS_PERIOD.PERIOD_BEGIN_DATE = DATEADD(MONTH, -1, REACTIVATED.PERIOD_BEGIN_DATE)
			AND PREVIOUS_PERIOD.CLIENT_KEY = REACTIVATED.CLIENT_KEY
			AND PREVIOUS_PERIOD.REVENUE_CATEGORY = REACTIVATED.REVENUE_CATEGORY
	WHERE PREVIOUS_PERIOD.PERIOD_BEGIN_DATE IS NULL
)
	SELECT 
        CLIENT_KEY,
        PERIOD_BEGIN_DATE,
		REVENUE_CATEGORY,
		REVENUE_SUBCATEGORY_CODE,
		REVENUE_SUBCATEGORY_NAME,
		FIRST_SERVICE_DATE,
		CURRENT_BRANCH_KEY,
		CURRENT_SUPERVISOR_KEY
	FROM REACTIVATED_CLIENTS
    ORDER BY PERIOD_BEGIN_DATE;