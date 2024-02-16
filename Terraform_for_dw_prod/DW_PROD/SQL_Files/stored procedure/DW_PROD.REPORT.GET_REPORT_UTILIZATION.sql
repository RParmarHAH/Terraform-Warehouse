CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_UTILIZATION("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

	 --*****************************************************************************************************************************
-- NAME:  UTILIZATION
--
-- PURPOSE: Creates derived monthly metrics for each client based on visit/service data
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 		    				         Initial development
-- 11/09/22    Saurav Purohit        Reworked logic to include non-confirmed visits as well and added fields for New Scheduled metrics
-- 17/11/22    Hasnain Motagamwala   Added field NPS by joining HAH.FACT_NPS based on CLIENT_KEY, PERIOD_BEGIN_DATE.
-- 05/25/23	   Nutan Jagnade         Added FUTURE_HOURS_NO_CAREGIVER COLUMN
--*****************************************************************************************************************************
--NOTE:			If Manual Refresh is required then SCHEDULE_METRICS_MONTHLY should be refreshed first before running this object
--*****************************************************************************************************************************
	INSERT OVERWRITE INTO REPORT.UTILIZATION
	(PERIOD_BEGIN_DATE, STATE, BRANCH_KEY, ORIGINAL_BRANCH_KEY, OFFICE_NUMBER, OFFICE_NAME, SUPERVISOR_KEY, SUPERVISOR_CODE,
		CLIENT_KEY, ORIGINAL_CLIENT_KEY, CLIENT_NUMBER, ORIGINAL_CLIENT_NUMBER, ORIGINAL_SOURCE_SYSTEM_ID, SOURCE_SYSTEM_ID, 
		CONTRACT_KEY, CONTRACT_CODE, VISITS_SCHEDULED, VISITS_COMPLETED,	VISITS_CANCELLED, VISITS_IN_REVIEW,	VISITS_MISSED, FUTURE_VISITS, FUTURE_CANCELLED_VISITS, FUTURE_HOLD_VISITS,
		HOURS_SCHEDULED, HOURS_SERVED, HOURS_CANCELLED, HOURS_IN_REVIEW, HOURS_MISSED, FUTURE_HOURS,FUTURE_HOURS_NO_CAREGIVER, FUTURE_CANCELLED_HOURS, FUTURE_HOLD_HOURS,
		HOURS_BILLED, HOURS_AUTHORIZED, HOURS_AUTHORIZED_NON_ADJUSTED,
	UTILIZATION, OVER_AUTHED, OVER_AUTHED_ADJUSTED, OVER_AUTHED_HOURS, OVER_AUTHED_HOURS_ADJUSTED, SERVED_WITHOUT_AUTH, 
	VISITS_ALL, VISITS_CLEAN_SHIFTS, VISITS_NEED_MAINTENANCE, CLIENT_SERVED_FLAG,
		ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG,
		ABSOLUTE_FIRST_SERVICE_DATE, ABSOLUTE_LAST_SERVICE_DATE, NPS)
		--
		WITH VISITS AS (		
		SELECT DISTINCT DATE_TRUNC(MONTH, VISIT.REPORT_DATE) REPORT_DATE, 
		VISIT.CLIENT_KEY, 
		VISIT.SOURCE_SYSTEM_ID,
		FIRST_VALUE(VISIT.ORIGINAL_SOURCE_SYSTEM_ID) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 0 ELSE 1 END) AS ORIGINAL_SOURCE_SYSTEM_ID,
		FIRST_VALUE(VISIT.ORIGINAL_CLIENT_KEY) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 0 ELSE 1 END) AS ORIGINAL_CLIENT_KEY,
		VISIT.CLIENT_NUMBER, 
		MIN(IFF(MAX(VISIT.CONFIRMED_FLAG) = ''YES'' ,VISIT.SERVICE_DATE, NULL)) OVER (PARTITION BY  VISIT.CLIENT_KEY) AS Absolute_First_Service_Date,		--
		MAX(IFF(MAX(VISIT.CONFIRMED_FLAG) = ''YES'' ,VISIT.SERVICE_DATE, NULL)) OVER (PARTITION BY  VISIT.CLIENT_KEY) AS Absolute_Last_Service_Date,		--
		FIRST_VALUE(VISIT.ORIGINAL_CLIENT_NUMBER) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 0 ELSE 1 END) AS ORIGINAL_CLIENT_NUMBER,
		VISIT.CONTRACT_KEY,
		FIRST_VALUE(VISIT.BRANCH_KEY) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY ORDER BY IFF(MAX(VISIT.CONFIRMED_FLAG) = ''YES'', 0, 1), MAX(VISIT.REPORT_DATE) DESC,  NVL(SUM(VISIT.HOURS_SERVED), 0) DESC) BRANCH_KEY,		--
		FIRST_VALUE(VISIT.ORIGINAL_BRANCH_KEY) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 0 ELSE 1 END, IFF(MAX(VISIT.CONFIRMED_FLAG) = ''YES'', 0, 1), MAX(VISIT.REPORT_DATE) DESC,  NVL(SUM(VISIT.HOURS_SERVED), 0) DESC) ORIGINAL_BRANCH_KEY,		--
		FIRST_VALUE(VISIT.SUPERVISOR_KEY) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY ORDER BY IFF(MAX(VISIT.CONFIRMED_FLAG) = ''YES'', 0, 1), MAX(VISIT.REPORT_DATE) DESC,  NVL(SUM(VISIT.HOURS_SERVED), 0) DESC) SUPERVISOR_KEY,		--
		SUM(NVL(SUM(IFF(VISIT.CONFIRMED_FLAG = ''YES'', VISIT.HOURS_SERVED,0)), 0)) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY) HOURS_SERVED,		--
		SUM(COUNT(IFF(VISIT.CONFIRMED_FLAG = ''YES'',VISIT.VISIT_KEY,NULL))) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY) AS VISITS_ALL,
		SUM(COUNT(IFF(VISIT.CLEAN_SHIFT_FLAG = 1 AND VISIT.CONFIRMED_FLAG = ''YES'', VISIT.VISIT_KEY, NULL))) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY) AS VISITS_CLEAN_SHIFTS,		--
		SUM(COUNT(IFF(VISIT.CLEAN_SHIFT_FLAG = 0 AND VISIT.CONFIRMED_FLAG = ''YES'', VISIT.VISIT_KEY, NULL))) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY) AS VISITS_NEED_MAINTENANCE		--
	FROM INTEGRATION.FACT_VISIT_MERGED AS VISIT
	--WHERE VISIT.CONFIRMED_FLAG = ''YES''   Only confirmed visits 					-- Need all visits now
	GROUP BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE),
		VISIT.CLIENT_KEY, 
		VISIT.SOURCE_SYSTEM_ID,
		VISIT.ORIGINAL_SOURCE_SYSTEM_ID,
		VISIT.ORIGINAL_CLIENT_KEY,
		VISIT.CLIENT_NUMBER,
        VISIT.SERVICE_DATE,
		VISIT.ORIGINAL_CLIENT_NUMBER,
		VISIT.CONTRACT_KEY, 
		VISIT.BRANCH_KEY, 
		VISIT.ORIGINAL_BRANCH_KEY,
		VISIT.SUPERVISOR_KEY
), REVENUE_DATAFLEX AS (
	SELECT DATEFROMPARTS(LEFT(INVOICES.PERIOD, 4), RIGHT(TRIM(INVOICES.PERIOD), 2), 1) AS REPORT_DATE, CLIENT.CLIENT_KEY, CONTRACT.CONTRACT_KEY, SUM(INVOICES.HOURSBILLED) HOURS_BILLED
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES INVOICES
	JOIN HAH.DIM_CLIENT CLIENT
		ON CLIENT.SOURCE_SYSTEM_ID = 3 AND CLIENT.SYSTEM_CODE = INVOICES.DBNAME AND CLIENT.CLIENT_NUMBER = INVOICES.CLIENTNUMBER 
	JOIN HAH.DIM_CONTRACT CONTRACT
		ON CONTRACT.SOURCE_SYSTEM_ID = 3 AND CONTRACT.SYSTEM_CODE = INVOICES.DBNAME AND CONTRACT.CONTRACT_CODE = INVOICES.CONTRACTCODE
	WHERE MOVEDTO = ''''
	GROUP BY DATEFROMPARTS(LEFT(INVOICES.PERIOD, 4), RIGHT(TRIM(INVOICES.PERIOD), 2), 1), CLIENT.CLIENT_KEY, CONTRACT.CONTRACT_KEY
), REVENUE_OTHERS AS (
	SELECT DATE_TRUNC(MONTH, REVENUE.REPORT_DATE) AS REPORT_DATE, REVENUE.CLIENT_KEY, REVENUE.CONTRACT_KEY, SUM(REVENUE.INVOICE_HOURS) HOURS_BILLED
	FROM INTEGRATION.FACT_REVENUE_MERGED REVENUE
	JOIN HAH.DIM_INVOICE INVOICE
		ON INVOICE.INVOICE_KEY = REVENUE.INVOICE_KEY
	WHERE REVENUE.SOURCE_SYSTEM_ID <> 3 AND INVOICE.INVOICE_STATUS IN (''Bill Paid'',''Bill Sent'',''Fully Paid'',''Partially Paid'')
	GROUP BY DATE_TRUNC(MONTH, REVENUE.REPORT_DATE), REVENUE.CLIENT_KEY, REVENUE.CONTRACT_KEY
), REVENUE AS (
	SELECT L.REPORT_DATE, CLIENT.CLIENT_KEY, L.CONTRACT_KEY, SUM(L.HOURS_BILLED) AS HOURS_BILLED
	FROM (
		SELECT REPORT_DATE, CLIENT_KEY, CONTRACT_KEY, HOURS_BILLED
		FROM REVENUE_DATAFLEX
		UNION ALL
		SELECT REPORT_DATE, CLIENT_KEY, CONTRACT_KEY, HOURS_BILLED
		FROM REVENUE_OTHERS
	) L
	JOIN INTEGRATION.DIM_CLIENT_MERGED AS CLIENT
		ON CLIENT.ORIGINAL_CLIENT_KEY = L.CLIENT_KEY
	GROUP BY L.REPORT_DATE, CLIENT.CLIENT_KEY, L.CONTRACT_KEY
), INTAKES AS (
	SELECT DATE_TRUNC(MONTH, INTAKE.REPORT_DATE) AS REPORT_DATE, INTAKE.CLIENT_KEY, INTAKE.CLIENT_NUMBER, INTAKE.CONTRACT_KEY, NVL(SUM(INTAKE.HOURS_AUTHORIZED), 0) HOURS_AUTHORIZED, NVL(SUM(INTAKE.HOURS_AUTHORIZED_NON_ADJUSTED), 0) HOURS_AUTHORIZED_NON_ADJUSTED
	FROM INTEGRATION.FACT_INTAKE_MERGED INTAKE
	GROUP BY DATE_TRUNC(MONTH, INTAKE.REPORT_DATE), INTAKE.CLIENT_KEY, INTAKE.CLIENT_NUMBER, INTAKE.CONTRACT_KEY 
), NEW_METRICS AS (
	SELECT	REPORT_DATE, CLIENT_KEY , CONTRACT_KEY , 
		SUM(NM.VISITS_SCHEDULED) AS VISITS_SCHEDULED,
		SUM(NM.VISITS_COMPLETED) AS VISITS_COMPLETED,
		SUM(NM.VISITS_CANCELLED) AS VISITS_CANCELLED,
		SUM(NM.VISITS_IN_REVIEW) AS VISITS_IN_REVIEW,
		SUM(NM.VISITS_MISSED) AS VISITS_MISSED,
		SUM(NM.FUTURE_VISITS) AS FUTURE_VISITS,
		SUM(NM.FUTURE_CANCELLED_VISITS) AS FUTURE_CANCELLED_VISITS,
		SUM(NM.FUTURE_HOLD_VISITS) AS FUTURE_HOLD_VISITS,
		SUM(NM.HOURS_SCHEDULED) AS HOURS_SCHEDULED,
		SUM(NM.HOURS_CANCELLED) AS HOURS_CANCELLED,
		SUM(NM.HOURS_IN_REVIEW) AS HOURS_IN_REVIEW,
		SUM(NM.HOURS_MISSED) AS HOURS_MISSED,
		SUM(NM.FUTURE_HOURS) AS FUTURE_HOURS,
        SUM(NM.FUTURE_HOURS_NO_CAREGIVER) AS FUTURE_HOURS_NO_CAREGIVER,
		SUM(NM.FUTURE_CANCELLED_HOURS) AS FUTURE_CANCELLED_HOURS,
		SUM(NM.FUTURE_HOLD_HOURS) AS FUTURE_HOLD_HOURS,
		MAX(NM.CLIENT_SERVED_FLAG) AS CLIENT_SERVED_FLAG
		FROM REPORT.SCHEDULE_METRICS_MONTHLY NM
		GROUP BY REPORT_DATE, CLIENT_KEY , CONTRACT_KEY 
		)
,UTILIZATION_DETAIL AS (
	SELECT DISTINCT VISIT.REPORT_DATE PERIOD_BEGIN_DATE,
		BRANCH.BRANCH_KEY,
		VISIT.ORIGINAL_BRANCH_KEY,
		COALESCE(BRANCH.OFFICE_STATE_CODE, CLIENT.CLIENT_STATE_CODE) STATE,
		BRANCH.OFFICE_NUMBER,
		BRANCH.DETAILED_OFFICE_NAME AS OFFICE_NAME,
		VISIT.SUPERVISOR_KEY,
		SUPERVISOR.SUPERVISOR_CODE,
		VISIT.CLIENT_KEY, 
		CLIENT.ORIGINAL_CLIENT_KEY,
		VISIT.CLIENT_NUMBER, 
		CLIENT.ORIGINAL_CLIENT_NUMBER,
		VISIT.ORIGINAL_SOURCE_SYSTEM_ID,
		VISIT.SOURCE_SYSTEM_ID,
		VISIT.CONTRACT_KEY,
		CONTRACT.CONTRACT_CODE,
		CONTRACT.CONTRACT_NAME,
		NM.VISITS_SCHEDULED,
		NM.VISITS_COMPLETED,
		NM.VISITS_CANCELLED,
		NM.VISITS_IN_REVIEW,
		NM.VISITS_MISSED,
		NM.FUTURE_VISITS,
		NM.FUTURE_CANCELLED_VISITS,
		NM.FUTURE_HOLD_VISITS,
		NM.HOURS_SCHEDULED,
		VISIT.HOURS_SERVED,
		NM.HOURS_CANCELLED,
		NM.HOURS_IN_REVIEW,
		NM.HOURS_MISSED,
		NM.FUTURE_HOURS, 
        NM.FUTURE_HOURS_NO_CAREGIVER,
		NM.FUTURE_CANCELLED_HOURS,
		NM.FUTURE_HOLD_HOURS,
		REVENUE.HOURS_BILLED,
		INTAKE.HOURS_AUTHORIZED,
		INTAKE.HOURS_AUTHORIZED_NON_ADJUSTED,
		IFF(NVL(INTAKE.HOURS_AUTHORIZED, 0) <= 0, NULL, NVL(VISIT.HOURS_SERVED, 0) / INTAKE.HOURS_AUTHORIZED) AS UTILIZATION,
		IFF(IFF(NVL(INTAKE.HOURS_AUTHORIZED_NON_ADJUSTED , 0) <= 0, NULL, NVL(VISIT.HOURS_SERVED, 0) / INTAKE.HOURS_AUTHORIZED_NON_ADJUSTED)>1, 1, 0) AS OVER_AUTHED,
		IFF(IFF(NVL(INTAKE.HOURS_AUTHORIZED , 0) <= 0, NULL, NVL(VISIT.HOURS_SERVED, 0) / INTAKE.HOURS_AUTHORIZED)>1, 1, 0) AS OVER_AUTHED_ADJUSTED,
		IFF(INTAKE.HOURS_AUTHORIZED_NON_ADJUSTED <VISIT.HOURS_SERVED, NVL(VISIT.HOURS_SERVED, 0) - INTAKE.HOURS_AUTHORIZED_NON_ADJUSTED , NULL) AS OVER_AUTHED_HOURS,
		IFF(INTAKE.HOURS_AUTHORIZED<VISIT.HOURS_SERVED, NVL(VISIT.HOURS_SERVED, 0) - INTAKE.HOURS_AUTHORIZED, NULL) AS OVER_AUTHED_HOURS_ADJUSTED,
		IFF(NVL(VISIT.HOURS_SERVED, 0) > 0 AND NVL(INTAKE.HOURS_AUTHORIZED, 0) <= 0, 1, 0) AS SERVED_WITHOUT_AUTH,
	--	CLIENT.DERIVED_FIRST_SERVICE_DATE,
	--	CLIENT.DERIVED_LAST_SERVICE_DATE,
		VISIT.Absolute_First_Service_Date,
		VISIT.Absolute_Last_Service_Date,
		VISIT.VISITS_ALL,
		VISIT.VISITS_CLEAN_SHIFTS,
		VISIT.VISITS_NEED_MAINTENANCE,
		NM.CLIENT_SERVED_FLAG 
	FROM VISITS VISIT
	JOIN INTEGRATION.DIM_CLIENT_MERGED CLIENT
		ON CLIENT.ORIGINAL_CLIENT_KEY = VISIT.CLIENT_KEY
	JOIN HAH.DIM_CONTRACT CONTRACT
		ON CONTRACT.CONTRACT_KEY = VISIT.CONTRACT_KEY
	LEFT JOIN INTAKES INTAKE
		ON INTAKE.REPORT_DATE = VISIT.REPORT_DATE AND INTAKE.CLIENT_KEY = VISIT.CLIENT_KEY AND INTAKE.CONTRACT_KEY = VISIT.CONTRACT_KEY 
	LEFT JOIN REVENUE REVENUE
		ON REVENUE.REPORT_DATE = VISIT.REPORT_DATE AND REVENUE.CLIENT_KEY = VISIT.CLIENT_KEY AND REVENUE.CONTRACT_KEY = VISIT.CONTRACT_KEY
	JOIN INTEGRATION.DIM_BRANCH_MERGED BRANCH
		ON BRANCH.ORIGINAL_BRANCH_KEY = VISIT.BRANCH_KEY
	LEFT JOIN INTEGRATION.DIM_SUPERVISOR_MERGED SUPERVISOR
		ON SUPERVISOR.ORIGINAL_SUPERVISOR_KEY = VISIT.SUPERVISOR_KEY
	LEFT JOIN NEW_METRICS NM 
		ON NM.REPORT_DATE = VISIT.REPORT_DATE AND NM.CLIENT_KEY = VISIT.CLIENT_KEY AND NM.CONTRACT_KEY = VISIT.CONTRACT_KEY
)
SELECT PERIOD_BEGIN_DATE, STATE, BRANCH_KEY, ORIGINAL_BRANCH_KEY, OFFICE_NUMBER, OFFICE_NAME, SUPERVISOR_KEY, SUPERVISOR_CODE,
	UD.CLIENT_KEY, ORIGINAL_CLIENT_KEY, CLIENT_NUMBER, ORIGINAL_CLIENT_NUMBER, 
	ORIGINAL_SOURCE_SYSTEM_ID, SOURCE_SYSTEM_ID, CONTRACT_KEY, CONTRACT_CODE,  
	VISITS_SCHEDULED, VISITS_COMPLETED,	VISITS_CANCELLED, VISITS_IN_REVIEW,	VISITS_MISSED, FUTURE_VISITS, FUTURE_CANCELLED_VISITS, FUTURE_HOLD_VISITS,
		HOURS_SCHEDULED, HOURS_SERVED, HOURS_CANCELLED, HOURS_IN_REVIEW, HOURS_MISSED, FUTURE_HOURS,FUTURE_HOURS_NO_CAREGIVER, FUTURE_CANCELLED_HOURS, FUTURE_HOLD_HOURS,
		HOURS_BILLED, HOURS_AUTHORIZED, HOURS_AUTHORIZED_NON_ADJUSTED,
	UTILIZATION, OVER_AUTHED, OVER_AUTHED_ADJUSTED, OVER_AUTHED_HOURS, OVER_AUTHED_HOURS_ADJUSTED, SERVED_WITHOUT_AUTH, 
	VISITS_ALL, VISITS_CLEAN_SHIFTS, VISITS_NEED_MAINTENANCE, CLIENT_SERVED_FLAG,
	-- ETL Fields
        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        
	
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG, 
	Absolute_First_Service_Date, Absolute_Last_Service_Date, NPS
FROM UTILIZATION_DETAIL UD
LEFT JOIN DW_PROD.INTEGRATION.FACT_NPS FN
  ON FN.CLIENT_KEY = UD.CLIENT_KEY
  AND YEAR(UD.PERIOD_BEGIN_DATE) = YEAR(FN.RECORDED_DATE) 
  AND MONTH(UD.PERIOD_BEGIN_DATE) = MONTH(FN.RECORDED_DATE);

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';