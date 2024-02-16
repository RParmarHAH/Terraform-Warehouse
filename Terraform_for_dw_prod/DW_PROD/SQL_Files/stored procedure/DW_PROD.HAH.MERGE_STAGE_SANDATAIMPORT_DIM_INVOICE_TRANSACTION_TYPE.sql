CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_SANDATAIMPORT_DIM_INVOICE_TRANSACTION_TYPE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN 
    MERGE INTO HAH.DIM_INVOICE_TRANSACTION_TYPE TGT 
USING STAGE.SANDATAIMPORT_DIM_INVOICE_TRANSACTION_TYPE STAGE
ON 
TGT.TRANSACTION_TYPE_KEY = STAGE.TRANSACTION_TYPE_KEY
WHEN MATCHED THEN 
UPDATE SET 
	TGT.TRANSACTION_TYPE_KEY =STAGE.TRANSACTION_TYPE_KEY
	,TGT.PARENT_TRANSACTION_TYPE_KEY = STAGE.PARENT_TRANSACTION_TYPE_KEY
	,TGT.TRANSACTION_CODE = STAGE.TRANSACTION_CODE
	,TGT.TRANSACTION_NAME = STAGE.TRANSACTION_NAME
	,TGT.TRANSACTION_DESC = STAGE.TRANSACTION_DESC
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
		 TRANSACTION_TYPE_KEY
		,PARENT_TRANSACTION_TYPE_KEY
		,TRANSACTION_CODE
		,TRANSACTION_NAME
		,TRANSACTION_DESC
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
	 	STAGE.TRANSACTION_TYPE_KEY
		,STAGE.PARENT_TRANSACTION_TYPE_KEY
		,STAGE.TRANSACTION_CODE
		,STAGE.TRANSACTION_NAME
		,STAGE.TRANSACTION_DESC
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
';