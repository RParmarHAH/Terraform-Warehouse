CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_ALAYACARE_FACT_VISIT()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR (1000);
  BEGIN
    MERGE INTO DW_PROD.HAH.FACT_VISIT TGT 
USING STAGE.ALAYACARE_FACT_VISIT STAGE 
ON TGT.VISIT_KEY = STAGE.VISIT_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.REPORT_DATE= STAGE.REPORT_DATE
   ,TGT.BRANCH_KEY= STAGE.BRANCH_KEY
   ,TGT.CLIENT_KEY= STAGE.CLIENT_KEY
   ,TGT.CONTRACT_KEY= STAGE.CONTRACT_KEY
   --,TGT.SCHEDULED_EMPLOYEE_KEY= IFF(STAGE.SCHEDULED_EMPLOYEE_KEY IS NOT NULL,STAGE.SCHEDULED_EMPLOYEE_KEY,TGT.SCHEDULED_EMPLOYEE_KEY)
   ,TGT.SCHEDULED_EMPLOYEE_KEY= IFF(STAGE.SCHEDULE_STATUS_CODE=''s02'',NULL,IFF(STAGE.SCHEDULED_EMPLOYEE_KEY IS NOT NULL,STAGE.SCHEDULED_EMPLOYEE_KEY,TGT.SCHEDULED_EMPLOYEE_KEY))
   ,TGT.EMPLOYEE_KEY= STAGE.EMPLOYEE_KEY
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SUPERVISOR_KEY= STAGE.SUPERVISOR_KEY
   ,TGT.INVOICE_KEY= STAGE.INVOICE_KEY
   ,TGT.PAYROLL_KEY= STAGE.PAYROLL_KEY								  
   ,TGT.CLIENT_SERVICE_KEY = STAGE.CLIENT_SERVICE_KEY
   ,TGT.PARTNER_CONTRACT_SERVICE_KEY = STAGE.PARTNER_CONTRACT_SERVICE_KEY	
	,TGT.BILLING_KEY = STAGE.BILLING_KEY											 
   ,TGT.SERVICE_DATE= STAGE.SERVICE_DATE
   ,TGT.PAYROLL_DATE= STAGE.PAYROLL_DATE
   ,TGT.BRANCH_NAME= STAGE.BRANCH_NAME
   ,TGT.CLIENT_NUMBER= STAGE.CLIENT_NUMBER
   ,TGT.CONTRACT_CODE= STAGE.CONTRACT_CODE
  -- ,TGT.SCHEDULED_EMPLOYEE_ID= IFF(STAGE.SCHEDULED_EMPLOYEE_ID IS NOT NULL, STAGE.SCHEDULED_EMPLOYEE_ID, TGT.SCHEDULED_EMPLOYEE_ID)
   ,TGT.SCHEDULED_EMPLOYEE_ID=IFF(STAGE.SCHEDULE_STATUS_CODE=''s02'',NULL , IFF(STAGE.SCHEDULED_EMPLOYEE_ID IS NOT NULL, STAGE.SCHEDULED_EMPLOYEE_ID, TGT.SCHEDULED_EMPLOYEE_ID))
   ,TGT.EMPLOYEE_ID= STAGE.EMPLOYEE_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SUPERVISOR_CODE= STAGE.SUPERVISOR_CODE
   ,TGT.INVOICE_ID= STAGE.INVOICE_ID
   ,TGT.CHEQUE_NUMBER= STAGE.CHEQUE_NUMBER									  
   ,TGT.CLEAN_SHIFT_FLAG= STAGE.CLEAN_SHIFT_FLAG
   ,TGT.SCHEDULE_STATUS_CODE= STAGE.SCHEDULE_STATUS_CODE
   ,TGT.SCHEDULE_STATUS_NAME= STAGE.SCHEDULE_STATUS_NAME
   ,TGT.SCHEDULE_STATUS_DESCRIPTION= STAGE.SCHEDULE_STATUS_DESCRIPTION
   ,TGT.VISIT_STATUS_CODE= STAGE.VISIT_STATUS_CODE
   ,TGT.VISIT_STATUS_NAME= STAGE.VISIT_STATUS_NAME
   ,TGT.VISIT_STATUS_DESCRIPTION= STAGE.VISIT_STATUS_DESCRIPTION
   ,TGT.INVOICE_STATUS_CODE= STAGE.INVOICE_STATUS_CODE
   ,TGT.INVOICE_STATUS_NAME= STAGE.INVOICE_STATUS_NAME
   ,TGT.INVOICE_STATUS_DESCRIPTION= STAGE.INVOICE_STATUS_DESCRIPTION
   ,TGT.PAYROLL_STATUS_CODE= STAGE.PAYROLL_STATUS_CODE
   ,TGT.PAYROLL_STATUS_NAME= STAGE.PAYROLL_STATUS_NAME
   ,TGT.PAYROLL_STATUS_DESCRIPTION= STAGE.PAYROLL_STATUS_DESCRIPTION
   ,TGT.CANCEL_REASON_CODE= STAGE.CANCEL_REASON_CODE
   ,TGT.CANCEL_REASON_DESCRIPTION= STAGE.CANCEL_REASON_DESCRIPTION
   ,TGT.CANCEL_REASON_NOTES= STAGE.CANCEL_REASON_NOTES
   ,TGT.EXCEPTION_REASON_INDICATOR = STAGE.EXCEPTION_REASON_INDICATOR
   ,TGT.RESOLUTION_CODE= STAGE.RESOLUTION_CODE
   ,TGT.RESOLUTION_DESCRIPTION= STAGE.RESOLUTION_DESCRIPTION
   ,TGT.REJECTION_CODE= STAGE.REJECTION_CODE
   ,TGT.REJECTION_DESCRIPTION= STAGE.REJECTION_DESCRIPTION
   ,TGT.BILL_CODE= STAGE.BILL_CODE
   ,TGT.BILL_RATE= STAGE.BILL_RATE
   ,TGT.BILL_UNITS_SERVED= STAGE.BILL_UNITS_SERVED
   ,TGT.BILL_UNIT_TYPE= STAGE.BILL_UNIT_TYPE
   ,TGT.OVERHEAD_RATE= STAGE.OVERHEAD_RATE
	,TGT.SCHEDULE_TIMEIN= STAGE.SCHEDULE_TIMEIN
   ,TGT.SCHEDULE_TIMEOUT= STAGE.SCHEDULE_TIMEOUT
   ,TGT.SCHEDULE_DURATION= STAGE.SCHEDULE_DURATION
   ,TGT.ACTUAL_TIMEIN= STAGE.ACTUAL_TIMEIN
   ,TGT.ACTUAL_TIMEOUT= STAGE.ACTUAL_TIMEOUT
   ,TGT.ACTUAL_DURATION= STAGE.ACTUAL_DURATION
   ,TGT.ADJUSTED_TIMEIN= STAGE.ADJUSTED_TIMEIN
   ,TGT.ADJUSTED_TIMEOUT= STAGE.ADJUSTED_TIMEOUT
   ,TGT.ADJUSTED_DURATION= STAGE.ADJUSTED_DURATION
   ,TGT.HOURS_SERVED= STAGE.HOURS_SERVED
   ,TGT.COMMENTS= STAGE.COMMENTS
   ,TGT.IS_EVV_FLAG= STAGE.IS_EVV_FLAG
   ,TGT.TIMESHEET_TYPE= STAGE.TIMESHEET_TYPE
   ,TGT.TRACKING_ID= STAGE.TRACKING_ID
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.CONFIRMED_FLAG= STAGE.CONFIRMED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    VISIT_KEY
   ,REPORT_DATE
   ,BRANCH_KEY
   ,CLIENT_KEY
   ,CONTRACT_KEY
   ,SCHEDULED_EMPLOYEE_KEY
   ,EMPLOYEE_KEY
   ,SOURCE_SYSTEM_ID
   ,SUPERVISOR_KEY
   ,INVOICE_KEY
   ,PAYROLL_KEY
	,CLIENT_SERVICE_KEY
   ,PARTNER_CONTRACT_SERVICE_KEY
	,BILLING_KEY				  
   ,SERVICE_DATE
   ,PAYROLL_DATE
   ,BRANCH_NAME
   ,CLIENT_NUMBER
   ,CONTRACT_CODE
   ,SCHEDULED_EMPLOYEE_ID
   ,EMPLOYEE_ID
   ,SYSTEM_CODE
   ,SUPERVISOR_CODE
   ,INVOICE_ID
   ,CHEQUE_NUMBER
   ,CLEAN_SHIFT_FLAG
   ,SCHEDULE_STATUS_CODE
   ,SCHEDULE_STATUS_NAME
   ,SCHEDULE_STATUS_DESCRIPTION
   ,VISIT_STATUS_CODE
   ,VISIT_STATUS_NAME
   ,VISIT_STATUS_DESCRIPTION
   ,INVOICE_STATUS_CODE
   ,INVOICE_STATUS_NAME
   ,INVOICE_STATUS_DESCRIPTION
   ,PAYROLL_STATUS_CODE
   ,PAYROLL_STATUS_NAME
   ,PAYROLL_STATUS_DESCRIPTION
   ,CANCEL_REASON_CODE
   ,CANCEL_REASON_DESCRIPTION
   ,CANCEL_REASON_NOTES
   ,EXCEPTION_REASON_INDICATOR
   ,RESOLUTION_CODE
   ,RESOLUTION_DESCRIPTION
   ,REJECTION_CODE
   ,REJECTION_DESCRIPTION
   ,BILL_CODE
   ,BILL_RATE
   ,BILL_UNITS_SERVED
   ,BILL_UNIT_TYPE
   ,OVERHEAD_RATE
   ,SCHEDULE_TIMEIN
   ,SCHEDULE_TIMEOUT
   ,SCHEDULE_DURATION
   ,ACTUAL_TIMEIN
   ,ACTUAL_TIMEOUT
   ,ACTUAL_DURATION
   ,ADJUSTED_TIMEIN
   ,ADJUSTED_TIMEOUT
   ,ADJUSTED_DURATION
   ,HOURS_SERVED
   ,COMMENTS
   ,IS_EVV_FLAG
   ,TIMESHEET_TYPE
   ,TRACKING_ID
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
   ,CONFIRMED_FLAG
) 
VALUES (
    STAGE.VISIT_KEY
   ,STAGE.REPORT_DATE
   ,STAGE.BRANCH_KEY
   ,STAGE.CLIENT_KEY
   ,STAGE.CONTRACT_KEY
   ,STAGE.SCHEDULED_EMPLOYEE_KEY
   ,STAGE.EMPLOYEE_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SUPERVISOR_KEY
   ,STAGE.INVOICE_KEY
   ,STAGE.PAYROLL_KEY
	,STAGE.CLIENT_SERVICE_KEY
   ,STAGE.PARTNER_CONTRACT_SERVICE_KEY	
   ,STAGE.BILLING_KEY					
   ,STAGE.SERVICE_DATE
   ,STAGE.PAYROLL_DATE
   ,STAGE.BRANCH_NAME
   ,STAGE.CLIENT_NUMBER
   ,STAGE.CONTRACT_CODE
   ,STAGE.SCHEDULED_EMPLOYEE_ID
   ,STAGE.EMPLOYEE_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.SUPERVISOR_CODE
   ,STAGE.INVOICE_ID
   ,STAGE.CHEQUE_NUMBER
   ,STAGE.CLEAN_SHIFT_FLAG
   ,STAGE.SCHEDULE_STATUS_CODE
   ,STAGE.SCHEDULE_STATUS_NAME
   ,STAGE.SCHEDULE_STATUS_DESCRIPTION
   ,STAGE.VISIT_STATUS_CODE
   ,STAGE.VISIT_STATUS_NAME
   ,STAGE.VISIT_STATUS_DESCRIPTION
   ,STAGE.INVOICE_STATUS_CODE
   ,STAGE.INVOICE_STATUS_NAME
   ,STAGE.INVOICE_STATUS_DESCRIPTION
   ,STAGE.PAYROLL_STATUS_CODE
   ,STAGE.PAYROLL_STATUS_NAME
   ,STAGE.PAYROLL_STATUS_DESCRIPTION
   ,STAGE.CANCEL_REASON_CODE
   ,STAGE.CANCEL_REASON_DESCRIPTION
   ,STAGE.CANCEL_REASON_NOTES
   ,STAGE.EXCEPTION_REASON_INDICATOR
   ,STAGE.RESOLUTION_CODE
   ,STAGE.RESOLUTION_DESCRIPTION
   ,STAGE.REJECTION_CODE
   ,STAGE.REJECTION_DESCRIPTION
   ,STAGE.BILL_CODE
   ,STAGE.BILL_RATE
   ,STAGE.BILL_UNITS_SERVED
   ,STAGE.BILL_UNIT_TYPE
   ,STAGE.OVERHEAD_RATE
   ,STAGE.SCHEDULE_TIMEIN
   ,STAGE.SCHEDULE_TIMEOUT
   ,STAGE.SCHEDULE_DURATION
   ,STAGE.ACTUAL_TIMEIN
   ,STAGE.ACTUAL_TIMEOUT
   ,STAGE.ACTUAL_DURATION
   ,STAGE.ADJUSTED_TIMEIN
   ,STAGE.ADJUSTED_TIMEOUT
   ,STAGE.ADJUSTED_DURATION
   ,STAGE.HOURS_SERVED
   ,STAGE.COMMENTS
   ,STAGE.IS_EVV_FLAG
   ,STAGE.TIMESHEET_TYPE
   ,STAGE.TRACKING_ID
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
   ,STAGE.CONFIRMED_FLAG
);
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted & '',"number of rows updated",'' Rows Updated. '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
END;
    ';