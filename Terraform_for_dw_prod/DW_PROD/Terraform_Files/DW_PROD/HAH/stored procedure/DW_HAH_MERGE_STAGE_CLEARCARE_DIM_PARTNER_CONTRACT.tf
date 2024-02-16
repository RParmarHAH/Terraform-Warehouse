resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_CLEARCARE_DIM_PARTNER_CONTRACT" {
	name ="MERGE_STAGE_CLEARCARE_DIM_PARTNER_CONTRACT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
MERGE INTO DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER_CONTRACT AS TGT
USING DW_${var.SF_ENVIRONMENT}.STAGE.CLEARCARE_DIM_PARTNER_CONTRACT AS SRC
ON TGT.PARTNER_CONTRACT_KEY=SRC.PARTNER_CONTRACT_KEY
WHEN MATCHED
THEN UPDATE SET
	  TGT.SOURCE_SYSTEM_ID=SRC.SOURCE_SYSTEM_ID
	, TGT.SYSTEM_CODE=SRC.SYSTEM_CODE
    , TGT.STATE=SRC.STATE
	, TGT.PARTNER_KEY=SRC.PARTNER_KEY
	, TGT.PARTNER_CODE=SRC.PARTNER_CODE
	, TGT.PARTNER_NAME=SRC.PARTNER_NAME
	, TGT.CONTRACT_CODE=SRC.CONTRACT_CODE
	, TGT.CONTRACT_NAME=SRC.CONTRACT_NAME
	, TGT.ACTIVE_FLAG=SRC.ACTIVE_FLAG
	, TGT.START_DATE=SRC.START_DATE
	, TGT.END_DATE=SRC.END_DATE
	, TGT.ETL_TASK_KEY=SRC.ETL_TASK_KEY
	, TGT.ETL_INSERTED_TASK_KEY=SRC.ETL_INSERTED_TASK_KEY
	, TGT.ETL_INSERTED_DATE=SRC.ETL_INSERTED_DATE
	, TGT.ETL_INSERTED_BY=SRC.ETL_INSERTED_BY
	, TGT.ETL_LAST_UPDATED_DATE=SRC.ETL_LAST_UPDATED_DATE
	, TGT.ETL_LAST_UPDATED_BY=SRC.ETL_LAST_UPDATED_BY
	, TGT.ETL_DELETED_FLAG=SRC.ETL_DELETED_FLAG
WHEN NOT MATCHED
THEN INSERT (PARTNER_CONTRACT_KEY
	, SOURCE_SYSTEM_ID
	, SYSTEM_CODE
    , STATE
	, PARTNER_KEY
	, PARTNER_CODE
	, PARTNER_NAME
	, CONTRACT_CODE
	, CONTRACT_NAME
	, ACTIVE_FLAG
	, START_DATE
	, END_DATE
	, ETL_TASK_KEY
	, ETL_INSERTED_TASK_KEY
	, ETL_INSERTED_DATE
	, ETL_INSERTED_BY
	, ETL_LAST_UPDATED_DATE
	, ETL_LAST_UPDATED_BY
	, ETL_DELETED_FLAG)
VALUES (SRC.PARTNER_CONTRACT_KEY
	, SRC.SOURCE_SYSTEM_ID
	, SRC.SYSTEM_CODE
    , SRC.STATE
	, SRC.PARTNER_KEY
	, SRC.PARTNER_CODE
	, SRC.PARTNER_NAME
	, SRC.CONTRACT_CODE
	, SRC.CONTRACT_NAME
	, SRC.ACTIVE_FLAG
	, SRC.START_DATE
	, SRC.END_DATE
	, SRC.ETL_TASK_KEY
	, SRC.ETL_INSERTED_TASK_KEY
	, SRC.ETL_INSERTED_DATE
	, SRC.ETL_INSERTED_BY
	, SRC.ETL_LAST_UPDATED_DATE
	, SRC.ETL_LAST_UPDATED_BY
	, SRC.ETL_DELETED_FLAG);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

