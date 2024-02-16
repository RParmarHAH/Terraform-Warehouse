resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_AXXESS_FACT_BRANCH_PAYROLL_PERIODS" {
	name ="MERGE_STAGE_AXXESS_FACT_BRANCH_PAYROLL_PERIODS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN 
    MERGE INTO HAH.FACT_BRANCH_PAYROLL_PERIODS TGT 
USING STAGE.AXXESS_FACT_BRANCH_PAYROLL_PERIODS STAGE 
ON TGT.BRANCH_PAYROLL_PERIODS_KEY = STAGE.BRANCH_PAYROLL_PERIODS_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.BRANCH_KEY= STAGE.BRANCH_KEY
   ,TGT.OFFICE_STATE_CODE= STAGE.OFFICE_STATE_CODE
   ,TGT.DETAILED_OFFICE_NAME= STAGE.DETAILED_OFFICE_NAME
   ,TGT.PERIOD_START_DATE= STAGE.PERIOD_START_DATE
   ,TGT.PERIOD_END_DATE= STAGE.PERIOD_END_DATE
   ,TGT.CHECK_DATE= STAGE.CHECK_DATE
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    BRANCH_PAYROLL_PERIODS_KEY
   ,BRANCH_KEY
   ,OFFICE_STATE_CODE
   ,DETAILED_OFFICE_NAME
   ,PERIOD_START_DATE
   ,PERIOD_END_DATE
   ,CHECK_DATE
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
    STAGE.BRANCH_PAYROLL_PERIODS_KEY
   ,STAGE.BRANCH_KEY
   ,STAGE.OFFICE_STATE_CODE
   ,STAGE.DETAILED_OFFICE_NAME
   ,STAGE.PERIOD_START_DATE
   ,STAGE.PERIOD_END_DATE
   ,STAGE.CHECK_DATE
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
end;

 EOT
}

