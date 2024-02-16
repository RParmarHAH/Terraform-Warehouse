CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_DATAFLEXSYNCDATA_DIM_VISIT_EXCEPTION()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '

DECLARE
    return_result VARCHAR;
BEGIN
	MERGE INTO DW_PROD.HAH.DIM_VISIT_EXCEPTION TGT USING DW_PROD.STAGE.DATAFLEXSYNCDATA_DIM_VISIT_EXCEPTION STAGE 
	ON TGT.EXCEPTION_KEY = STAGE.EXCEPTION_KEY
	WHEN MATCHED THEN 
	UPDATE SET 
	TGT.EXCEPTION_KEY =  STAGE.EXCEPTION_KEY
	,TGT.SOURCE_SYSTEM_ID =  STAGE.SOURCE_SYSTEM_ID
	,TGT.SYSTEM_CODE =  STAGE.SYSTEM_CODE
	,TGT.EXCEPTION_CODE =  STAGE.EXCEPTION_CODE
	,TGT.EXCEPTION_DESC =  STAGE.EXCEPTION_DESC
	,TGT.EXCEPTION_CATEGORY =  STAGE.EXCEPTION_CATEGORY
	,TGT.CATEGORY_KEY = STAGE.CATEGORY_KEY
	,TGT.ETL_TASK_KEY =  STAGE.ETL_TASK_KEY
	,TGT.ETL_INSERTED_TASK_KEY =  STAGE.ETL_INSERTED_TASK_KEY
	,TGT.ETL_INSERTED_DATE =  STAGE.ETL_INSERTED_DATE
	,TGT.ETL_INSERTED_BY =  STAGE.ETL_INSERTED_BY
	,TGT.ETL_LAST_UPDATED_DATE =  STAGE.ETL_LAST_UPDATED_DATE
	,TGT.ETL_LAST_UPDATED_BY =  STAGE.ETL_LAST_UPDATED_BY
	,TGT.ETL_DELETED_FLAG =  STAGE.ETL_DELETED_FLAG
	
	WHEN NOT MATCHED THEN 
	INSERT ( 
	    EXCEPTION_KEY
		,SOURCE_SYSTEM_ID
		,SYSTEM_CODE
		,EXCEPTION_CODE
		,EXCEPTION_DESC
		,EXCEPTION_CATEGORY
		,CATEGORY_KEY
		,ETL_TASK_KEY
		,ETL_INSERTED_TASK_KEY
		,ETL_INSERTED_DATE
		,ETL_INSERTED_BY
		,ETL_LAST_UPDATED_DATE
		,ETL_LAST_UPDATED_BY
		,ETL_DELETED_FLAG
	) 
	VALUES (
	    STAGE.EXCEPTION_KEY
		,STAGE.SOURCE_SYSTEM_ID
		,STAGE.SYSTEM_CODE
		,STAGE.EXCEPTION_CODE
		,STAGE.EXCEPTION_DESC
		,STAGE.EXCEPTION_CATEGORY
		,STAGE.CATEGORY_KEY
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