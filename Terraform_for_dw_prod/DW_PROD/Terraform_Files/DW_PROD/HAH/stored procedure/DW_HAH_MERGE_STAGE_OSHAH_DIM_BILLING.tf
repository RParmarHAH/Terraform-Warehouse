resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_OSHAH_DIM_BILLING" {
	name ="MERGE_STAGE_OSHAH_DIM_BILLING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
MERGE INTO DW_${var.SF_ENVIRONMENT}.HAH.DIM_BILLING AS tgt
USING DW_${var.SF_ENVIRONMENT}.STAGE.OSHAH_DIM_BILLING AS src
ON (tgt.BILLING_KEY=src.BILLING_KEY)
WHEN MATCHED
THEN UPDATE SET
	tgt.SOURCE_SYSTEM_ID=src.SOURCE_SYSTEM_ID
	 , tgt.SYSTEM_CODE=src.SYSTEM_CODE
	 , tgt.BILL_CODE=src.BILL_CODE
	 , tgt.BILL_NAME=src.BILL_NAME
	 , tgt.BILL_DESCRIPTION=src.BILL_DESCRIPTION
	 , tgt.BILL_TYPE=src.BILL_TYPE
	 , tgt.BILL_UOM=src.BILL_UOM
	 , tgt.BILL_RATE=src.BILL_RATE
	 , tgt.RATE_EFFECTIVE_START_DATE=src.RATE_EFFECTIVE_START_DATE
	 , tgt.REVENUE_CATEGORY=src.REVENUE_CATEGORY
	 , tgt.REVENUE_SUBCATEGORY_CODE=src.REVENUE_SUBCATEGORY_CODE
	 , tgt.REVENUE_SUBCATEGORY_NAME=src.REVENUE_SUBCATEGORY_NAME
	 , tgt.GL_CODE=src.GL_CODE
	 , tgt.GL_NAME=src.GL_NAME
	 , tgt.GL_DESCRIPTION=src.GL_DESCRIPTION
	 , tgt.ACTIVE_FLAG=src.ACTIVE_FLAG
	 , tgt.ETL_TASK_KEY=src.ETL_TASK_KEY
	 , tgt.ETL_INSERTED_TASK_KEY=src.ETL_INSERTED_TASK_KEY
	 , tgt.ETL_INSERTED_DATE=src.ETL_INSERTED_DATE
	 , tgt.ETL_INSERTED_BY=src.ETL_INSERTED_BY
	 , tgt.ETL_LAST_UPDATED_DATE=src.ETL_LAST_UPDATED_DATE
	 , tgt.ETL_LAST_UPDATED_BY=src.ETL_LAST_UPDATED_BY
	 , tgt.ETL_DELETED_FLAG=src.ETL_DELETED_FLAG
	 , tgt.RATE_EFFECTIVE_END_DATE=src.RATE_EFFECTIVE_END_DATE
WHEN NOT MATCHED
THEN INSERT (BILLING_KEY
	 , SOURCE_SYSTEM_ID
	 , SYSTEM_CODE
	 , BILL_CODE
	 , BILL_NAME
	 , BILL_DESCRIPTION
	 , BILL_TYPE
	 , BILL_UOM
	 , BILL_RATE
	 , RATE_EFFECTIVE_START_DATE
	 , REVENUE_CATEGORY
	 , REVENUE_SUBCATEGORY_CODE
	 , REVENUE_SUBCATEGORY_NAME
	 , GL_CODE
	 , GL_NAME
	 , GL_DESCRIPTION
	 , ACTIVE_FLAG
	 , ETL_TASK_KEY
	 , ETL_INSERTED_TASK_KEY
	 , ETL_INSERTED_DATE
	 , ETL_INSERTED_BY
	 , ETL_LAST_UPDATED_DATE
	 , ETL_LAST_UPDATED_BY
	 , ETL_DELETED_FLAG
	 , RATE_EFFECTIVE_END_DATE)
VALUES (src.BILLING_KEY
	 , src.SOURCE_SYSTEM_ID
	 , src.SYSTEM_CODE
	 , src.BILL_CODE
	 , src.BILL_NAME
	 , src.BILL_DESCRIPTION
	 , src.BILL_TYPE
	 , src.BILL_UOM
	 , src.BILL_RATE
	 , src.RATE_EFFECTIVE_START_DATE
	 , src.REVENUE_CATEGORY
	 , src.REVENUE_SUBCATEGORY_CODE
	 , src.REVENUE_SUBCATEGORY_NAME
	 , src.GL_CODE
	 , src.GL_NAME
	 , src.GL_DESCRIPTION
	 , src.ACTIVE_FLAG
	 , src.ETL_TASK_KEY
	 , src.ETL_INSERTED_TASK_KEY
	 , src.ETL_INSERTED_DATE
	 , src.ETL_INSERTED_BY
	 , src.ETL_LAST_UPDATED_DATE
	 , src.ETL_LAST_UPDATED_BY
	 , src.ETL_DELETED_FLAG
	 , src.RATE_EFFECTIVE_END_DATE);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

