create or replace view DW_PROD.REPORT.VW_EXECUTIVE_OPERATIONS_EXCELLENCE_UTILIZATION_W_DEMOGRAPHICS_AND_ORIGINAL_BRANCH_VAI(
	PERIOD_BEGIN_DATE,
	PERIOD_NAME,
	STATE,
	ORIGINAL_BRANCH_KEY,
	BRANCH_KEY,
	OFFICE_NUMBER,
	OFFICE_NAME,
	SUPERVISOR_KEY,
	SUPERVISOR_CODE,
	CLIENT_KEY_DATA,
	CLIENT_KEY,
	CLIENT_NUMBER,
	ORIGINAL_SOURCE_SYSTEM_ID,
	SOURCE_SYSTEM_ID,
	CONTRACT_KEY,
	CONTRACT_CODE,
	HOURS_SERVED_WHERE_AUTH_EXISTS,
	HOURS_BILLED_WHERE_AUTH_EXISTS,
	HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,
	HOURS_SERVED_ALL,
	HOURS_BILLED_ALL,
	HOURS_AUTHORIZED_ALL,
	INCLUDE_FOR_CLIENTS,
	INCLUDE_FOR_HOURS,
	REVENUE_CATEGORY,
	ETL_LAST_UPDATED_DATE,
	VISITS_ALL,
	VISITS_CLEAN_SHIFTS,
	VISITS_NEED_MAINTENANCE,
	CLIENT_STATE,
	CLIENT_ETHNICITY,
	CLIENT_GENDER,
	CLIENT_AGE,
	FIRST_SERVICE_MONTH,
	AGENCY,
	CCSI_FLAG
) as 
 	WITH DATES AS (
		SELECT DISTINCT FIRST_DAY_OF_MONTH, CONCAT(MONTH_NAME, ' ', "YEAR") PERIOD_NAME
        FROM HAH.DIM_DATE
--        WHERE FIRST_DAY_OF_MONTH BETWEEN '2018-01-01' and '2020-12-31'
        WHERE FIRST_DAY_OF_MONTH BETWEEN '2018-01-01' AND DATEADD( 'MONTH', 1, CURRENT_DATE())
	), FIRSTSERVICEDATE AS (
SELECT CLIENT_KEY,DATE_TRUNC('MONTH',MIN(SERVICE_DATE)) FIRST_SERVICE_MONTH FROM INTEGRATION.FACT_VISIT_MERGED WHERE NVL(STATUS_CODE, '02') IN ('02', '03', '04', '05') 
	AND SOURCE_SYSTEM_ID = 7 GROUP BY CLIENT_KEY 
),CONTRACTS AS (
		SELECT CONTRACT_KEY, 
			CONTRACT_CODE, 
			CONTRACT_NAME, 
			REVENUE_CATEGORY,
			INCLUDE_FOR_EXEC_OPS_CLIENTS AS INCLUDE_FOR_CLIENTS,
			INCLUDE_FOR_EXEC_OPS_HOURS AS INCLUDE_FOR_HOURS
		FROM REPORT.VW_DASHBOARD_CONTRACTS
		WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE
--		WHERE INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE OR INCLUDE_FOR_EXEC_OPS_HOURS = TRUE
	), UTILIZATION_DATA AS (
		SELECT DISTINCT DATA.PERIOD_BEGIN_DATE,
			DATES.PERIOD_NAME,
            DATA.Original_Branch_Key,
			DATA.BRANCH_KEY,
			DATA.STATE,
			DATA.OFFICE_NUMBER,
			DATA.OFFICE_NAME,
			DATA.SUPERVISOR_KEY,
			DATA.SUPERVISOR_CODE,
			DATA.CLIENT_KEY AS CLIENT_KEY_DATA,
			DATA.CLIENT_NUMBER, 
			DATA.ORIGINAL_SOURCE_SYSTEM_ID,
			DATA.SOURCE_SYSTEM_ID,
            CLIENT.CLIENT_STATE_CODE as CLIENT_STATE,
            CLIENT.CLIENT_ETHNICITY,
            CLIENT.CLIENT_GENDER,
            DATEDIFF(YEAR, CLIENT.CLIENT_DOB, DATA.PERIOD_BEGIN_DATE) as CLIENT_AGE,
            FSD.FIRST_SERVICE_MONTH as FIRST_SERVICE_MONTH,
			DATA.CONTRACT_KEY,
			DATA.CONTRACT_CODE,
			CONTRACT.CONTRACT_NAME,
			CONTRACT.INCLUDE_FOR_CLIENTS,
			CONTRACT.INCLUDE_FOR_HOURS,
			CONTRACT.REVENUE_CATEGORY,
			CASE WHEN CONTRACT.INCLUDE_FOR_CLIENTS = 1 THEN client.CLIENT_KEY END CLIENT_KEY,
			--CASE WHEN CONTRACT.INCLUDE_FOR_CLIENTS = 1 THEN COALESCE(CM.MASTER_CLIENT_KEY,DATA.CLIENT_KEY) END CLIENT_KEY,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 THEN DATA.HOURS_BILLED END, 0) HOURS_BILLED_ALL,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 THEN DATA.HOURS_SERVED END, 0) HOURS_SERVED_ALL,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 THEN DATA.HOURS_AUTHORIZED END, 0) HOURS_AUTHORIZED_ALL,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) <= 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_SERVED END, 0) HOURS_SERVED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) <= 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_BILLED END, 0) HOURS_BILLED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) <= 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_AUTHORIZED END, 0) HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,
--			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_SERVED END, 0) HOURS_SERVED_WHERE_AUTH_EXISTS,
--			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_BILLED END, 0) HOURS_BILLED_WHERE_AUTH_EXISTS,
--			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_AUTHORIZED END, 0) HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,
			DATA.ETL_LAST_UPDATED_DATE,
			DATA.VISITS_ALL,
			DATA.VISITS_CLEAN_SHIFTS,
			DATA.VISITS_NEED_MAINTENANCE
		, M.AGENCY,	CASE WHEN M.AGENCY = 'Community Care' THEN TRUE ELSE FALSE END AS CCSI_FLAG 
		FROM REPORT.UTILIZATION AS DATA
		JOIN CONTRACTS CONTRACT
			ON CONTRACT.CONTRACT_KEY = DATA.CONTRACT_KEY --AND Data.CONTRACT_KEY NOT in ('7a063b085cebe336b0d355ac9df05840', '040c3a083eba1cfd52725c26878010ba','b63036c4869a4398a28f2b2a1bedbcde')
		JOIN DATES DATES 
			ON DATES.FIRST_DAY_OF_MONTH = DATA.PERIOD_BEGIN_DATE 
		LEFT JOIN FIRSTSERVICEDATE FSD ON FSD.CLIENT_KEY=DATA.CLIENT_KEY
        JOIN INTEGRATION.DIM_CLIENT_MERGED CLIENT
            ON CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
         LEFT JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED M ON M.ORIGINAL_CLIENT_KEY = DATA.ORIGINAL_CLIENT_KEY
  --      LEFT JOIN STAGE.VW_MATRIXCARE_MASTER_CLIENT_MAPPING CM ON DATA.CLIENT_KEY=CM.CLIENT_KEY
WHERE NVL(DATA.HOURS_SERVED, 0) > 0
	)
	SELECT PERIOD_BEGIN_DATE, PERIOD_NAME, STATE, Original_Branch_Key,
        BRANCH_KEY, OFFICE_NUMBER, OFFICE_NAME, SUPERVISOR_KEY, SUPERVISOR_CODE,
		CLIENT_KEY_DATA,CLIENT_KEY,  CLIENT_NUMBER, ORIGINAL_SOURCE_SYSTEM_ID,
			SOURCE_SYSTEM_ID, CONTRACT_KEY, CONTRACT_CODE, 
		HOURS_SERVED_WHERE_AUTH_EXISTS, HOURS_BILLED_WHERE_AUTH_EXISTS, HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,
		HOURS_SERVED_ALL, HOURS_BILLED_ALL, HOURS_AUTHORIZED_ALL,
		INCLUDE_FOR_CLIENTS, INCLUDE_FOR_HOURS, REVENUE_CATEGORY,
		ETL_LAST_UPDATED_DATE, VISITS_ALL, VISITS_CLEAN_SHIFTS, VISITS_NEED_MAINTENANCE,
		CLIENT_STATE, CLIENT_ETHNICITY, CLIENT_GENDER, CLIENT_AGE, FIRST_SERVICE_MONTH  , AGENCY, CCSI_FLAG
	FROM UTILIZATION_DATA
    ORDER BY Period_Begin_Date, Client_Key;