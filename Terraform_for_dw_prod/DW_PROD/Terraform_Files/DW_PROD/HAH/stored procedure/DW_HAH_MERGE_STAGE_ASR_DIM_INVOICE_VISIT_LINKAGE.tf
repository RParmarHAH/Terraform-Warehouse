resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_ASR_DIM_INVOICE_VISIT_LINKAGE" {
	name ="MERGE_STAGE_ASR_DIM_INVOICE_VISIT_LINKAGE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN 
    MERGE INTO HAH.DIM_INVOICE_VISIT_LINKAGE TGT 
USING STAGE.ASR_DIM_INVOICE_VISIT_LINKAGE STAGE
ON 
TGT.REVENUE_KEY = STAGE.REVENUE_KEY AND TGT.VISIT_KEY = STAGE.VISIT_KEY
WHEN MATCHED THEN 
UPDATE SET 
	TGT.REVENUE_KEY =STAGE.REVENUE_KEY
	,TGT.VISIT_KEY = STAGE.VISIT_KEY
	,TGT.VISIT_ID = STAGE.VISIT_ID
	,TGT.SERVICE_DATE = STAGE.SERVICE_DATE
	,TGT.SYSTEM_CODE = STAGE.SYSTEM_CODE
	,TGT.SOURCE_SYSTEM_ID = STAGE.SOURCE_SYSTEM_ID
	,TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY
	,TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY
	,TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE
	,TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY
	,TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE
	,TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY  
	,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
		 REVENUE_KEY
		,VISIT_KEY
		,VISIT_ID
		,SERVICE_DATE
		,SYSTEM_CODE
		,SOURCE_SYSTEM_ID
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
		,STAGE.VISIT_KEY
		,STAGE.VISIT_ID
		,STAGE.SERVICE_DATE
		,STAGE.SYSTEM_CODE
		,STAGE.SOURCE_SYSTEM_ID
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
end;

 EOT
}

