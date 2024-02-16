CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_PREFERRED_DIM_REFERRER()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
    MERGE INTO HAH.DIM_REFERRER TGT 
USING STAGE.PREFERRED_DIM_REFERRER STAGE 
ON TGT.REFERRER_KEY = STAGE.REFERRER_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.REFERRER_TYPE= STAGE.REFERRER_TYPE
   ,TGT.REFERRER_CODE= STAGE.REFERRER_CODE
   ,TGT.REFERRER_NAME= STAGE.REFERRER_NAME
   ,TGT.REFERRER_ADDRESS1= STAGE.REFERRER_ADDRESS1
   ,TGT.REFERRER_ADDRESS2= STAGE.REFERRER_ADDRESS2
   ,TGT.REFERRER_CITY= STAGE.REFERRER_CITY
   ,TGT.REFERRER_STATE_CODE= STAGE.REFERRER_STATE_CODE
   ,TGT.REFERRER_ZIP= STAGE.REFERRER_ZIP
   ,TGT.REFERRER_PHONE= STAGE.REFERRER_PHONE
   ,TGT.REFERRER_FAX= STAGE.REFERRER_FAX
   ,TGT.DESCRIPTION= STAGE.DESCRIPTION
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_INSERTED_TASK_KEY= STAGE.ETL_INSERTED_TASK_KEY
   ,TGT.ETL_INSERTED_DATE= STAGE.ETL_INSERTED_DATE
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_INSERTED_BY= STAGE.ETL_INSERTED_BY
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    REFERRER_KEY
   ,SOURCE_SYSTEM_ID
   ,SYSTEM_CODE
   ,REFERRER_TYPE
   ,REFERRER_CODE
   ,REFERRER_NAME
   ,REFERRER_ADDRESS1
   ,REFERRER_ADDRESS2
   ,REFERRER_CITY
   ,REFERRER_STATE_CODE
   ,REFERRER_ZIP
   ,REFERRER_PHONE
   ,REFERRER_FAX
   ,DESCRIPTION
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_LAST_UPDATED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
) 
VALUES (
    STAGE.REFERRER_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.REFERRER_TYPE
   ,STAGE.REFERRER_CODE
   ,STAGE.REFERRER_NAME
   ,STAGE.REFERRER_ADDRESS1
   ,STAGE.REFERRER_ADDRESS2
   ,STAGE.REFERRER_CITY
   ,STAGE.REFERRER_STATE_CODE
   ,STAGE.REFERRER_ZIP
   ,STAGE.REFERRER_PHONE
   ,STAGE.REFERRER_FAX
   ,STAGE.DESCRIPTION
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';