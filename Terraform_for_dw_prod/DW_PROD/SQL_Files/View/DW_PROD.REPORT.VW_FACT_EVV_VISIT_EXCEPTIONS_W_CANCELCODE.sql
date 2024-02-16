create or replace view DW_PROD.REPORT.VW_FACT_EVV_VISIT_EXCEPTIONS_W_CANCELCODE(
	VISIT_KEY,
	EXCEPTION_REASON_CODE,
	REPORT_DATE,
	BRANCH_KEY,
	CLIENT_KEY,
	CONTRACT_KEY,
	EMPLOYEE_KEY,
	SUPERVISOR_KEY,
	SERVICE_DATE,
	CLIENT_NUMBER,
	CONTRACT_CODE,
	EMPLOYEE_ID,
	SYSTEM_CODE,
	EXCEPTION_REASON_DESCRIPTION,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG,
	CANCEL_REASON_CODE,
	CANCEL_REASON_DESCRIPTION,
	CANCEL_REASON_NOTES
) as
SELECT E.*,V.CANCEL_REASON_CODE ,V.CANCEL_REASON_DESCRIPTION ,V.CANCEL_REASON_NOTES 
FROM DW_PROD.HAH.FACT_EVV_VISIT_EXCEPTIONS_NEW E 
JOIN DW_PROD.HAH.FACT_EVV_VISIT V ON E.VISIT_KEY = V.VISIT_KEY;