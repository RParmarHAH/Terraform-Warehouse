resource "snowflake_procedure" "DISC_PAYOR_CONTRACT_UI_LOAD_REVENUE_CATEGORY" {
	name ="LOAD_REVENUE_CATEGORY"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYOR_CONTRACT_UI"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    RETURN_RESULT VARCHAR;
BEGIN

MERGE INTO DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.REVENUE_CATEGORY TGT 
USING APP_DB_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_MAPPING.REVENUE_CATEGORY STAGE
ON STAGE.REVENUE_CATEGORY_CODE = TGT.REVENUE_CATEGORY_CODE
WHEN MATCHED THEN 
UPDATE SET TGT.REVENUE_CATEGORY_CODE = STAGE.REVENUE_CATEGORY_CODE
		  ,TGT.REVENUE_CATEGORY_NAME = STAGE.REVENUE_CATEGORY_NAME
		  ,TGT.ETL_TASK_KEY = :STR_ETL_TASK_KEY
        ,TGT.ETL_LAST_UPDATED_DATE = CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ
        ,TGT.ETL_LAST_UPDATED_BY = CURRENT_USER
WHEN NOT MATCHED THEN 
INSERT 
	(REVENUE_CATEGORY_CODE
	,REVENUE_CATEGORY_NAME
	,ETL_TASK_KEY
	,ETL_INSERTED_TASK_KEY
	,ETL_INSERTED_DATE
	,ETL_INSERTED_BY
	,ETL_LAST_UPDATED_DATE
	,ETL_LAST_UPDATED_BY)
VALUES 
	(STAGE.REVENUE_CATEGORY_CODE
	,STAGE.REVENUE_CATEGORY_NAME
	,:STR_ETL_TASK_KEY  
	,:STR_ETL_TASK_KEY  
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,CURRENT_USER
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,CURRENT_USER)
;
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

