CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_COVID_19_NEW_STARTS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    INSERT OVERWRITE INTO REPORT.COVID_19_NEW_STARTS
	(STATE, OFFICE_NUMBER, OFFICE_NAME, BRANCH_KEY, CLIENT_KEY, CLIENT_NUMBER, CLIENT_NAME,
		FIRST_DATE_OF_SERVICE, YEAR, MONTH, PERIOD_BEGIN_DATE, PERIOD_NAME,
		ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG)
WITH DATES AS (
	SELECT CALENDAR_DATE DATE, YEAR, MONTH, FIRST_DAY_OF_MONTH, CONCAT(MONTH_NAME, '' '', "YEAR") MONTH_NAME
	FROM HAH.DIM_DATE 
	WHERE CALENDAR_DATE BETWEEN ''2019-01-02'' AND DATEADD(DAY, -2, CURRENT_DATE()) 
		AND UPPER(DAY_NAME) NOT IN (''SAT'',''SUN'')
), CONTRACTS AS (
	SELECT CONTRACT_KEY
	FROM HAH.DIM_CONTRACT 
	WHERE NVL(BILLABLE_FLAG, 1) = 1 AND NVL(PAYABLE_FLAG, 1) = 1 AND NVL(MILEAGE_FLAG, 0) = 0
		AND NVL(REVENUE_CATEGORY, '''') <> ''CLS''
), STATES AS (
	SELECT STATE_ISO_CODE STATE, SANDATA_AGENCY_ID AGENCYID, CASE STATE_ISO_CODE WHEN ''PA'' THEN ''8485'' ELSE STATE_ISO_CODE END SYSTEM_CODE
	FROM HAH.DIM_STATE 
	WHERE STATE_ISO_CODE IN (''IL'',''IN'',''PA'')
), TIMESHEET_VISITS AS (
	SELECT DISTINCT STATE.STATE, 
		FIRST_VALUE(BRANCH.OFFICE_NUMBER) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY MIN(VISIT.SERVICE_DATE), SUM(VISIT.HOURS_SERVED) DESC) OFFICE_NUMBER, 
		FIRST_VALUE(UPPER(CONCAT(BRANCH.OFFICE_STATE_CODE, '' - '', BRANCH.OFFICE_NAME))) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY MIN(VISIT.SERVICE_DATE), SUM(VISIT.HOURS_SERVED) DESC) OFFICE_NAME, 
		FIRST_VALUE(BRANCH.BRANCH_KEY) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY MIN(VISIT.SERVICE_DATE), SUM(VISIT.HOURS_SERVED) DESC) BRANCH_KEY,
		VISIT.CLIENT_KEY, 
		VISIT.CLIENT_NUMBER,
		CONCAT(CLIENT.CLIENT_LAST_NAME, '', '', CLIENT.CLIENT_FIRST_NAME) CLIENT_NAME,
		MIN(MIN(VISIT.SERVICE_DATE)) OVER(PARTITION BY VISIT.CLIENT_KEY) FIRST_SERVICE_DATE
	FROM HAH.FACT_VISIT VISIT
	JOIN STATES STATE
		ON STATE.SYSTEM_CODE = VISIT.SYSTEM_CODE 
	JOIN CONTRACTS CONTRACTS
		ON CONTRACTS.CONTRACT_KEY = VISIT.CONTRACT_KEY
	JOIN HAH.DIM_BRANCH BRANCH 
		ON BRANCH.BRANCH_KEY = VISIT.BRANCH_KEY 
	JOIN HAH.DIM_CLIENT CLIENT
		ON CLIENT.CLIENT_KEY = VISIT.CLIENT_KEY 
	WHERE VISIT.SERVICE_DATE <= (SELECT MAX(DATE) FROM DATES)
		--AND VISIT.STATUS_CODE IN (''02'',''03'',''04'',''05'') 
		AND VISIT.CONFIRMED_FLAG = ''YES'' --AND NVL(VISIT.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
	GROUP BY STATE.STATE, BRANCH.OFFICE_NUMBER, UPPER(CONCAT(BRANCH.OFFICE_STATE_CODE, '' - '', BRANCH.OFFICE_NAME)), BRANCH.BRANCH_KEY,
		VISIT.CLIENT_KEY, 
		VISIT.CLIENT_NUMBER,
		CONCAT(CLIENT.CLIENT_LAST_NAME, '', '', CLIENT.CLIENT_FIRST_NAME)
), VISITS AS (
	SELECT *
	FROM TIMESHEET_VISITS TIMESHEETS
	WHERE TIMESHEETS.FIRST_SERVICE_DATE >= (SELECT MIN(DATE) FROM DATES)
)
	SELECT VISITS.STATE, 
		VISITS.OFFICE_NUMBER, 
		VISITS.OFFICE_NAME, 
		VISITS.BRANCH_KEY, 
		VISITS.CLIENT_KEY, 
		VISITS.CLIENT_NUMBER,
		VISITS.CLIENT_NAME,
		VISITS.FIRST_SERVICE_DATE FIRST_DATE_OF_SERVICE, 
		DATES.YEAR, 
		DATES.MONTH, 
		DATES.FIRST_DAY_OF_MONTH PERIOD_BEGIN_DATE, 
		DATES.MONTH_NAME PERIOD_NAME,
		-- ETL Fields
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	FROM VISITS VISITS
	JOIN DATES DATES
		ON DATES.DATE = VISITS.FIRST_SERVICE_DATE;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';