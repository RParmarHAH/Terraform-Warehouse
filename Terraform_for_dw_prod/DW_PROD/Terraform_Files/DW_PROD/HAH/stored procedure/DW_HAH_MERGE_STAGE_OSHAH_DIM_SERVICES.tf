resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_OSHAH_DIM_SERVICES" {
	name ="MERGE_STAGE_OSHAH_DIM_SERVICES"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
MERGE INTO DW_${var.SF_ENVIRONMENT}.HAH.DIM_SERVICES TGT 
USING DW_${var.SF_ENVIRONMENT}.STAGE.OSHAH_DIM_SERVICES STAGE 
ON TGT.SERVICE_KEY = STAGE.SERVICE_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.SERVICE_KEY= STAGE.SERVICE_KEY
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SERVICE_CODE= STAGE.SERVICE_CODE
   ,TGT.SERVICE_DESCRIPTION= STAGE.SERVICE_DESCRIPTION
   ,TGT.SERVICE_TYPE= STAGE.SERVICE_TYPE
   ,TGT.SERVICE_RATE_TYPE= STAGE.SERVICE_RATE_TYPE
   ,TGT.REVENUE_CATEGORY= STAGE.REVENUE_CATEGORY
   ,TGT.REVENUE_SUBCATEGORY_CODE= STAGE.REVENUE_SUBCATEGORY_CODE
   ,TGT.REVENUE_SUBCATEGORY_NAME= STAGE.REVENUE_SUBCATEGORY_NAME
   ,TGT.ACTIVE_FLAG= STAGE.ACTIVE_FLAG
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_INSERTED_TASK_KEY= STAGE.ETL_INSERTED_TASK_KEY
   ,TGT.ETL_INSERTED_DATE= STAGE.ETL_INSERTED_DATE
   ,TGT.ETL_INSERTED_BY= STAGE.ETL_INSERTED_BY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    SERVICE_KEY
   ,SYSTEM_CODE
   ,SOURCE_SYSTEM_ID
   ,SERVICE_CODE
   ,SERVICE_DESCRIPTION
   ,SERVICE_TYPE
   ,SERVICE_RATE_TYPE
   ,REVENUE_CATEGORY
   ,REVENUE_SUBCATEGORY_CODE
   ,REVENUE_SUBCATEGORY_NAME
   ,ACTIVE_FLAG
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
) 
VALUES (
    STAGE.SERVICE_KEY
   ,STAGE.SYSTEM_CODE
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SERVICE_CODE
   ,STAGE.SERVICE_DESCRIPTION
   ,STAGE.SERVICE_TYPE
   ,STAGE.SERVICE_RATE_TYPE
   ,STAGE.REVENUE_CATEGORY
   ,STAGE.REVENUE_SUBCATEGORY_CODE
   ,STAGE.REVENUE_SUBCATEGORY_NAME
   ,STAGE.ACTIVE_FLAG
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

