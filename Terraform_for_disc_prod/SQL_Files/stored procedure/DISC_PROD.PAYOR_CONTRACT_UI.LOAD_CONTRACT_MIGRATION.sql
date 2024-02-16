CREATE OR REPLACE PROCEDURE DISC_PROD.PAYOR_CONTRACT_UI.LOAD_CONTRACT_MIGRATION("STR_ETL_TASK_KEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
MERGE INTO DISC_PROD.PAYOR_CONTRACT_UI.CONTRACT_MIGRATION TGT 
USING APP_DB_PROD.PAYOR_CONTRACT_MAPPING.CONTRACT_MIGRATION STAGE 
ON TGT.LEGACY_SOURCE_SYSTEM_ID = STAGE.LEGACY_SOURCE_SYSTEM_ID
	AND TGT.LEGACY_SYSTEM_CODE = STAGE.LEGACY_SYSTEM_CODE
	AND TGT.LEGACY_CONTRACT_CODE = STAGE.LEGACY_CONTRACT_CODE
	AND TGT.TARGET_SOURCE_SYSTEM_ID = STAGE.TARGET_SOURCE_SYSTEM_ID
	AND TGT.TARGET_SYSTEM_CODE = STAGE.TARGET_SYSTEM_CODE
	AND TGT.TARGET_CONTRACT_CODE = STAGE.TARGET_CONTRACT_CODE
WHEN MATCHED THEN 
UPDATE SET 
	 TGT.LEGACY_CONTRACT_NAME = STAGE.LEGACY_CONTRACT_NAME
	,TGT.TARGET_CONTRACT_NAME = STAGE.TARGET_CONTRACT_NAME
	,TGT.ETL_TASK_KEY = :STR_ETL_TASK_KEY
	,TGT.ETL_LAST_UPDATED_DATE = CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,TGT.ETL_LAST_UPDATED_BY = CURRENT_USER
WHEN NOT MATCHED THEN 
INSERT 
	(LEGACY_SOURCE_SYSTEM_ID
	,LEGACY_SYSTEM_CODE
	,LEGACY_CONTRACT_CODE
	,LEGACY_CONTRACT_NAME
	,TARGET_SOURCE_SYSTEM_ID
	,TARGET_SYSTEM_CODE
	,TARGET_CONTRACT_CODE
	,TARGET_CONTRACT_NAME
	,ETL_TASK_KEY
	,ETL_INSERTED_TASK_KEY
	,ETL_INSERTED_DATE
	,ETL_INSERTED_BY
	,ETL_LAST_UPDATED_DATE
	,ETL_LAST_UPDATED_BY)
VALUES 
	(STAGE.LEGACY_SOURCE_SYSTEM_ID
	,STAGE.LEGACY_SYSTEM_CODE
	,STAGE.LEGACY_CONTRACT_CODE
	,STAGE.TARGET_SOURCE_SYSTEM_ID
	,STAGE.TARGET_SYSTEM_CODE
	,STAGE.TARGET_CONTRACT_CODE
	,STAGE.LEGACY_CONTRACT_NAME
	,STAGE.TARGET_CONTRACT_NAME
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
';