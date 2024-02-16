resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_ASR_DIM_INVOICE" {
	name ="MERGE_STAGE_ASR_DIM_INVOICE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
    MERGE INTO HAH.DIM_INVOICE TGT USING STAGE.ASR_DIM_INVOICE STAGE 
ON TGT.INVOICE_KEY = STAGE.INVOICE_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.CLIENT_KEY= STAGE.CLIENT_KEY
   ,TGT.INVOICE_NUMBER= STAGE.INVOICE_NUMBER
   ,TGT.PERIOD= STAGE.PERIOD
   ,TGT.INVOICE_TYPE= STAGE.INVOICE_TYPE
   ,TGT.NUMBER_OF_CLIENTS= STAGE.NUMBER_OF_CLIENTS
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.BRANCH_KEY= STAGE.BRANCH_KEY
   ,TGT.PAYOR_CODE= STAGE.PAYOR_CODE
   ,TGT.PAYOR_NAME= STAGE.PAYOR_NAME
   ,TGT.INVOICE_OPEN_FLAG= STAGE.INVOICE_OPEN_FLAG
   ,TGT.FIRST_INVOICE_DATE= STAGE.FIRST_INVOICE_DATE
   ,TGT.FINAL_PAYMENT_DATE= STAGE.FINAL_PAYMENT_DATE
   ,TGT.FIRST_INVOICE_NUMBER= STAGE.FIRST_INVOICE_NUMBER
   ,TGT.BILL_ITERATION= STAGE.BILL_ITERATION
   ,TGT.BILL_REPRESENTATIVE= STAGE.BILL_REPRESENTATIVE
   ,TGT.BILL_SUPERVISOR= STAGE.BILL_SUPERVISOR
   ,TGT.BILL_MANAGER= STAGE.BILL_MANAGER
   ,TGT.INVOICE_STATUS= STAGE.INVOICE_STATUS
   ,TGT.WRITEOFF_FLAG= STAGE.WRITEOFF_FLAG
   ,TGT.WRITEOFF_REASON= STAGE.WRITEOFF_REASON
   ,TGT.AMOUNT_BILLED= STAGE.AMOUNT_BILLED
   ,TGT.AMOUNT_COLLECTED= STAGE.AMOUNT_COLLECTED
   ,TGT.AMOUNT_OUTSTANDING= STAGE.AMOUNT_OUTSTANDING
   ,TGT.EFFECTIVE_FROM_DATE= STAGE.EFFECTIVE_FROM_DATE
   ,TGT.EFFECTIVE_TO_DATE= STAGE.EFFECTIVE_TO_DATE
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    INVOICE_KEY
   ,CLIENT_KEY
   ,INVOICE_NUMBER
   ,PERIOD
   ,INVOICE_TYPE
   ,NUMBER_OF_CLIENTS
   ,SYSTEM_CODE
   ,SOURCE_SYSTEM_ID
   ,BRANCH_KEY
   ,PAYOR_CODE
   ,PAYOR_NAME
   ,INVOICE_OPEN_FLAG
   ,FIRST_INVOICE_DATE
   ,FINAL_PAYMENT_DATE
   ,FIRST_INVOICE_NUMBER
   ,BILL_ITERATION
   ,BILL_REPRESENTATIVE
   ,BILL_SUPERVISOR
   ,BILL_MANAGER
   ,INVOICE_STATUS
   ,WRITEOFF_FLAG
   ,WRITEOFF_REASON
   ,AMOUNT_BILLED
   ,AMOUNT_COLLECTED
   ,AMOUNT_OUTSTANDING
   ,EFFECTIVE_FROM_DATE
   ,EFFECTIVE_TO_DATE
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
   ,ETL_INFERRED_MEMBER_FLAG
) 
VALUES (
    STAGE.INVOICE_KEY
   ,STAGE.CLIENT_KEY
   ,STAGE.INVOICE_NUMBER
   ,STAGE.PERIOD
   ,STAGE.INVOICE_TYPE
   ,STAGE.NUMBER_OF_CLIENTS
   ,STAGE.SYSTEM_CODE
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.BRANCH_KEY
   ,STAGE.PAYOR_CODE
   ,STAGE.PAYOR_NAME
   ,STAGE.INVOICE_OPEN_FLAG
   ,STAGE.FIRST_INVOICE_DATE
   ,STAGE.FINAL_PAYMENT_DATE
   ,STAGE.FIRST_INVOICE_NUMBER
   ,STAGE.BILL_ITERATION
   ,STAGE.BILL_REPRESENTATIVE
   ,STAGE.BILL_SUPERVISOR
   ,STAGE.BILL_MANAGER
   ,STAGE.INVOICE_STATUS
   ,STAGE.WRITEOFF_FLAG
   ,STAGE.WRITEOFF_REASON
   ,STAGE.AMOUNT_BILLED
   ,STAGE.AMOUNT_COLLECTED
   ,STAGE.AMOUNT_OUTSTANDING
   ,STAGE.EFFECTIVE_FROM_DATE
   ,STAGE.EFFECTIVE_TO_DATE
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
   ,STAGE.ETL_INFERRED_MEMBER_FLAG
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
    
 EOT
}

