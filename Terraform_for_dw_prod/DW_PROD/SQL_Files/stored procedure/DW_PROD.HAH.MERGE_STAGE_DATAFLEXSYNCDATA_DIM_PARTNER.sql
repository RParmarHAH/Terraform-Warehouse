CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_DATAFLEXSYNCDATA_DIM_PARTNER()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
MERGE INTO DW_PROD.HAH.DIM_PARTNER AS tgt
USING DW_PROD.STAGE.DATAFLEXSYNCDATA_DIM_PARTNER AS src
ON tgt.PARTNER_KEY=src.PARTNER_KEY
WHEN MATCHED
THEN UPDATE SET
      tgt.PARENT_PARTNER_KEY= src.PARENT_PARTNER_KEY
    , tgt.PARENT_PARTNER_NAME=src.PARENT_PARTNER_NAME
	, tgt.SOURCE_SYSTEM_ID=src.SOURCE_SYSTEM_ID
	, tgt.SYSTEM_CODE=src.SYSTEM_CODE
	, tgt.PARTNER_NAME=src.PARTNER_NAME
	, tgt.PARTNER_CODE=src.PARTNER_CODE
	, tgt.ACTIVE_FLAG=src.ACTIVE_FLAG
	, tgt.START_DATE=src.START_DATE
	, tgt.END_DATE=src.END_DATE
	, tgt.ETL_TASK_KEY=src.ETL_TASK_KEY
	, tgt.ETL_INSERTED_TASK_KEY=src.ETL_INSERTED_TASK_KEY
	, tgt.ETL_INSERTED_DATE=src.ETL_INSERTED_DATE
	, tgt.ETL_INSERTED_BY=src.ETL_INSERTED_BY
	, tgt.ETL_LAST_UPDATED_DATE=src.ETL_LAST_UPDATED_DATE
	, tgt.ETL_LAST_UPDATED_BY=src.ETL_LAST_UPDATED_BY
	, tgt.ETL_DELETED_FLAG=src.ETL_DELETED_FLAG
	, tgt.ETL_INFERRED_MEMBER_FLAG=src.ETL_INFERRED_MEMBER_FLAG
WHEN NOT MATCHED
THEN INSERT (PARTNER_KEY
    , PARENT_PARTNER_KEY
    , PARENT_PARTNER_NAME
	, SOURCE_SYSTEM_ID
	, SYSTEM_CODE
	, PARTNER_NAME
	, PARTNER_CODE
	, ACTIVE_FLAG
	, START_DATE
	, END_DATE
	, ETL_TASK_KEY
	, ETL_INSERTED_TASK_KEY
	, ETL_INSERTED_DATE
	, ETL_INSERTED_BY
	, ETL_LAST_UPDATED_DATE
	, ETL_LAST_UPDATED_BY
	, ETL_DELETED_FLAG
	, ETL_INFERRED_MEMBER_FLAG)
VALUES (src.PARTNER_KEY
    , src.PARENT_PARTNER_KEY
    , src.PARENT_PARTNER_NAME
	, src.SOURCE_SYSTEM_ID
	, src.SYSTEM_CODE
	, src.PARTNER_NAME
	, src.PARTNER_CODE
	, src.ACTIVE_FLAG
	, src.START_DATE
	, src.END_DATE
	, src.ETL_TASK_KEY
	, src.ETL_INSERTED_TASK_KEY
	, src.ETL_INSERTED_DATE
	, src.ETL_INSERTED_BY
	, src.ETL_LAST_UPDATED_DATE
	, src.ETL_LAST_UPDATED_BY
	, src.ETL_DELETED_FLAG
	, src.ETL_INFERRED_MEMBER_FLAG);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';