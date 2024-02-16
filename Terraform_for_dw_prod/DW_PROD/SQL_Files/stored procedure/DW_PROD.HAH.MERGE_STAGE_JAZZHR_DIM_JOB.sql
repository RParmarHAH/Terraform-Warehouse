CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_JAZZHR_DIM_JOB()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    MERGE INTO HAH.DIM_JOB TGT 
USING STAGE.JAZZHR_DIM_JOB STAGE 
ON TGT.JOB_KEY = STAGE.JOB_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.JOB_ID= STAGE.JOB_ID
   ,TGT.STATE= STAGE.STATE
   ,TGT.CITY= STAGE.CITY
   ,TGT.JOB_POSTING_DATE= STAGE.JOB_POSTING_DATE
   ,TGT.JOB_CLOSING_DATE= STAGE.JOB_CLOSING_DATE
   ,TGT.JOB_CREATED_DATE= STAGE.JOB_CREATED_DATE
   ,TGT.JOB_TITLE= STAGE.JOB_TITLE
   ,TGT.JOB_TITLE_CODE= STAGE.JOB_TITLE_CODE
   ,TGT.JOB_FAMILY= STAGE.JOB_FAMILY
   ,TGT.JOB_FAMILY_CODE= STAGE.JOB_FAMILY_CODE
   ,TGT.JOB_OWNER= STAGE.JOB_OWNER
   ,TGT.JOB_OWNER_ID= STAGE.JOB_OWNER_ID
   ,TGT.JOB_STATUS= STAGE.JOB_STATUS
   ,TGT.LOCATION_NAME= STAGE.LOCATION_NAME
   ,TGT.EXTERNAL_JOB_REFERENCE_NUMBER= STAGE.EXTERNAL_JOB_REFERENCE_NUMBER
   ,TGT.ARCHIVED= STAGE.ARCHIVED
   ,TGT.REQ_AGE= STAGE.REQ_AGE
   ,TGT.REQ_AGE_GROUP= STAGE.REQ_AGE_GROUP
   ,TGT.JOB_POSTING_LINK= STAGE.JOB_POSTING_LINK
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.BRANCH_KEY= STAGE.BRANCH_KEY
WHEN NOT MATCHED THEN 
INSERT ( 
    JOB_KEY
   ,SOURCE_SYSTEM_ID
   ,SYSTEM_CODE
   ,JOB_ID
   ,STATE
   ,CITY
   ,JOB_POSTING_DATE
   ,JOB_CLOSING_DATE
   ,JOB_CREATED_DATE
   ,JOB_TITLE
   ,JOB_TITLE_CODE
   ,JOB_FAMILY
   ,JOB_FAMILY_CODE
   ,JOB_OWNER
   ,JOB_OWNER_ID
   ,JOB_STATUS
   ,LOCATION_NAME
   ,EXTERNAL_JOB_REFERENCE_NUMBER
   ,ARCHIVED
   ,REQ_AGE
   ,REQ_AGE_GROUP
   ,JOB_POSTING_LINK
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
   ,BRANCH_KEY
) 
VALUES (
    STAGE.JOB_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.JOB_ID
   ,STAGE.STATE
   ,STAGE.CITY
   ,STAGE.JOB_POSTING_DATE
   ,STAGE.JOB_CLOSING_DATE
   ,STAGE.JOB_CREATED_DATE
   ,STAGE.JOB_TITLE
   ,STAGE.JOB_TITLE_CODE
   ,STAGE.JOB_FAMILY
   ,STAGE.JOB_FAMILY_CODE
   ,STAGE.JOB_OWNER
   ,STAGE.JOB_OWNER_ID
   ,STAGE.JOB_STATUS
   ,STAGE.LOCATION_NAME
   ,STAGE.EXTERNAL_JOB_REFERENCE_NUMBER
   ,STAGE.ARCHIVED
   ,STAGE.REQ_AGE
   ,STAGE.REQ_AGE_GROUP
   ,STAGE.JOB_POSTING_LINK
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
   ,STAGE.BRANCH_KEY
);

 SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted & '',"number of rows updated",'' Rows Updated. '') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
END;
    ';