CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_DATAFLEXSYNCDATA_FACT_VISIT_EXCEPTION()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '

DECLARE
    return_result VARCHAR;
BEGIN
	MERGE INTO HAH.FACT_VISIT_EXCEPTION TGT USING STAGE.DATAFLEXSYNCDATA_FACT_VISIT_EXCEPTION STAGE 
	ON TGT.VISIT_EXCEPTION_KEY = STAGE.VISIT_EXCEPTION_KEY
	WHEN MATCHED THEN 
	UPDATE SET 
	TGT.VISIT_EXCEPTION_KEY = STAGE.VISIT_EXCEPTION_KEY
	,TGT.VISIT_KEY = STAGE.VISIT_KEY
	,TGT.EXCEPTION_KEY = STAGE.EXCEPTION_KEY
	,TGT.SERVICE_DATE = STAGE.SERVICE_DATE
	,TGT.SOURCE_SYSTEM_ID = STAGE.SOURCE_SYSTEM_ID
	,TGT.SYSTEM_CODE = STAGE.SYSTEM_CODE
	,TGT.EXCEPTION_CODE = STAGE.EXCEPTION_CODE
	,TGT.ACKNOWLEDGED_FLAG = STAGE.ACKNOWLEDGED_FLAG
	,TGT.RESOLVED_FLAG = STAGE.RESOLVED_FLAG
	,TGT.REASON_CODE = STAGE.REASON_CODE
	,TGT.REASON_NAME = STAGE.REASON_NAME
	,TGT.RESOLUTION_CODE = STAGE.RESOLUTION_CODE
	,TGT.RESOLUTION_NAME = STAGE.RESOLUTION_NAME
	,TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY
	,TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY
	,TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE
	,TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY
	,TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE
	,TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY
	,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG

	WHEN NOT MATCHED THEN 
	INSERT ( 
	    VISIT_EXCEPTION_KEY
		,VISIT_KEY
		,EXCEPTION_KEY
		,SERVICE_DATE
		,SOURCE_SYSTEM_ID
		,SYSTEM_CODE
		,EXCEPTION_CODE
		,ACKNOWLEDGED_FLAG
		,RESOLVED_FLAG
		,REASON_CODE
		,REASON_NAME
		,RESOLUTION_CODE
		,RESOLUTION_NAME
		,ETL_TASK_KEY
		,ETL_INSERTED_TASK_KEY
		,ETL_INSERTED_DATE
		,ETL_INSERTED_BY
		,ETL_LAST_UPDATED_DATE
		,ETL_LAST_UPDATED_BY
		,ETL_DELETED_FLAG
	) 
	VALUES (
	    STAGE.VISIT_EXCEPTION_KEY
		,STAGE.VISIT_KEY
		,STAGE.EXCEPTION_KEY
		,STAGE.SERVICE_DATE
		,STAGE.SOURCE_SYSTEM_ID
		,STAGE.SYSTEM_CODE
		,STAGE.EXCEPTION_CODE
		,STAGE.ACKNOWLEDGED_FLAG
		,STAGE.RESOLVED_FLAG
		,STAGE.REASON_CODE
		,STAGE.REASON_NAME
		,STAGE.RESOLUTION_CODE
		,STAGE.RESOLUTION_NAME
		,STAGE.ETL_TASK_KEY
		,STAGE.ETL_INSERTED_TASK_KEY
		,STAGE.ETL_INSERTED_DATE
		,STAGE.ETL_INSERTED_BY
		,STAGE.ETL_LAST_UPDATED_DATE
		,STAGE.ETL_LAST_UPDATED_BY
		,STAGE.ETL_DELETED_FLAG
	);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

';