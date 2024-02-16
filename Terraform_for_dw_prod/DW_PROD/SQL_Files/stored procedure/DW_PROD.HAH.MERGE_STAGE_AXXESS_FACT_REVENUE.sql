CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_AXXESS_FACT_REVENUE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    MERGE INTO HAH.FACT_REVENUE TGT 
USING STAGE.AXXESS_FACT_REVENUE STAGE 
ON TGT.REVENUE_KEY = STAGE.REVENUE_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.REPORT_DATE= STAGE.REPORT_DATE
   ,TGT.BRANCH_KEY= STAGE.BRANCH_KEY
   ,TGT.EMPLOYEE_KEY= STAGE.EMPLOYEE_KEY
   ,TGT.CLIENT_KEY= STAGE.CLIENT_KEY
   ,TGT.CONTRACT_KEY= STAGE.CONTRACT_KEY
   ,TGT.INVOICE_KEY= STAGE.INVOICE_KEY
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SUPERVISOR_KEY= STAGE.SUPERVISOR_KEY
   ,TGT.REVENUE_DATE= STAGE.REVENUE_DATE
   ,TGT.PAYMENT_DATE= STAGE.PAYMENT_DATE
   ,TGT.BRANCH_NAME= STAGE.BRANCH_NAME
   ,TGT.EMPLOYEE_ID= STAGE.EMPLOYEE_ID
   ,TGT.CLIENT_NUMBER= STAGE.CLIENT_NUMBER
   ,TGT.CONTRACT_CODE= STAGE.CONTRACT_CODE
   ,TGT.INVOICE_NUMBER= STAGE.INVOICE_NUMBER
   ,TGT.INVOICE_TYPE= STAGE.INVOICE_TYPE
   ,TGT.BILL_UNIT_TYPE=STAGE.BILL_UNIT_TYPE
   ,TGT.NUMBER_OF_CLIENTS= STAGE.NUMBER_OF_CLIENTS
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SUPERVISOR_CODE= STAGE.SUPERVISOR_CODE
   ,TGT.BILL_CODE= STAGE.BILL_CODE
   ,TGT.INVOICE_HOURS= STAGE.INVOICE_HOURS
   ,TGT.INVOICE_RATE= STAGE.INVOICE_RATE
   ,TGT.AMOUNT_BILLED= STAGE.AMOUNT_BILLED
   ,TGT.AMOUNT_COLLECTED= STAGE.AMOUNT_COLLECTED
   ,TGT.AMOUNT_OUTSTANDING= STAGE.AMOUNT_OUTSTANDING
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    REVENUE_KEY
   ,REPORT_DATE
   ,BRANCH_KEY
   ,EMPLOYEE_KEY
   ,CLIENT_KEY
   ,CONTRACT_KEY
   ,INVOICE_KEY
   ,SOURCE_SYSTEM_ID
   ,SUPERVISOR_KEY
   ,REVENUE_DATE
   ,PAYMENT_DATE
   ,BRANCH_NAME
   ,EMPLOYEE_ID
   ,CLIENT_NUMBER
   ,CONTRACT_CODE
   ,INVOICE_NUMBER
   ,INVOICE_TYPE
   ,BILL_UNIT_TYPE
   ,NUMBER_OF_CLIENTS
   ,SYSTEM_CODE
   ,SUPERVISOR_CODE
   ,BILL_CODE
   ,INVOICE_HOURS
   ,INVOICE_RATE
   ,AMOUNT_BILLED
   ,AMOUNT_COLLECTED
   ,AMOUNT_OUTSTANDING
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
) 
VALUES (
    STAGE.REVENUE_KEY
   ,STAGE.REPORT_DATE
   ,STAGE.BRANCH_KEY
   ,STAGE.EMPLOYEE_KEY
   ,STAGE.CLIENT_KEY
   ,STAGE.CONTRACT_KEY
   ,STAGE.INVOICE_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SUPERVISOR_KEY
   ,STAGE.REVENUE_DATE
   ,STAGE.PAYMENT_DATE
   ,STAGE.BRANCH_NAME
   ,STAGE.EMPLOYEE_ID
   ,STAGE.CLIENT_NUMBER
   ,STAGE.CONTRACT_CODE
   ,STAGE.INVOICE_NUMBER
   ,STAGE.INVOICE_TYPE
   ,STAGE.BILL_UNIT_TYPE
   ,STAGE.NUMBER_OF_CLIENTS
   ,STAGE.SYSTEM_CODE
   ,STAGE.SUPERVISOR_CODE
   ,STAGE.BILL_CODE
   ,STAGE.INVOICE_HOURS
   ,STAGE.INVOICE_RATE
   ,STAGE.AMOUNT_BILLED
   ,STAGE.AMOUNT_COLLECTED
   ,STAGE.AMOUNT_OUTSTANDING
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
);

SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted & '',"number of rows updated",'' Rows Updated. '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
END;
    ';