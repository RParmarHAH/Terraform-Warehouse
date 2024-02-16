CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_QUALTRICS_DIM_DISTRIBUTION()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

MERGE INTO DW_PROD.HAH.DIM_DISTRIBUTION TGT 
USING DW_PROD.STAGE.QUALTRICS_DIM_DISTRIBUTION STAGE 
ON TGT.DIM_DISTRIBUTION_KEY = STAGE.QUALTRICS_DIM_DISTRIBUTION_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.PARENT_DISTRIBUTION_ID= STAGE.PARENT_DISTRIBUTION_ID
   ,TGT.SURVEY_SOURCE_TYPE= STAGE.SURVEY_SOURCE_TYPE
   ,TGT.DISTRIBUTION_STATUS= STAGE.DISTRIBUTION_STATUS
   ,TGT.DISTRIBUTION_TYPE= STAGE.DISTRIBUTION_TYPE
   ,TGT.SURVEY_KEY= STAGE.SURVEY_KEY
   ,TGT.SURVEY_ID= STAGE.SURVEY_ID
   ,TGT.DISTRIBUTION_NAME= STAGE.DISTRIBUTION_NAME
   ,TGT.SEND_DATE= STAGE.SEND_DATE
   ,TGT.CREATED_DATE= STAGE.CREATED_DATE
   ,TGT.MODIFIED_DATE= STAGE.MODIFIED_DATE
   ,TGT.FAILED= STAGE.FAILED
   ,TGT.FINISHED= STAGE.FINISHED
   ,TGT.SENT= STAGE.SENT
   ,TGT.STARTED= STAGE.STARTED
   ,TGT.CREDITS= STAGE.CREDITS
   ,TGT.SEGMENTS= STAGE.SEGMENTS
   ,TGT.BLOCKED= STAGE.BLOCKED
   ,TGT.BOUNCED= STAGE.BOUNCED
   ,TGT.COMPLAINTS= STAGE.COMPLAINTS
   ,TGT.OPENED= STAGE.OPENED
   ,TGT.SKIPPED= STAGE.SKIPPED
   ,TGT.SURVEY_LINK_EXPIRATION_DATE= STAGE.SURVEY_LINK_EXPIRATION_DATE
   ,TGT.SOURCE_SYSTEM_ID=STAGE.SOURCE_SYSTEM_ID
   ,TGT.SOURCE_SYSTEM_CODE=STAGE.SOURCE_SYSTEM_CODE
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_INSERTED_TASK_KEY= STAGE.ETL_INSERTED_TASK_KEY
   ,TGT.ETL_INSERTED_DATE= STAGE.ETL_INSERTED_DATE
   ,TGT.ETL_INSERTED_BY= STAGE.ETL_INSERTED_BY
   ,TGT.ETL_UPDATED_DATE= STAGE.ETL_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
   
WHEN NOT MATCHED THEN 
INSERT ( 
    DIM_DISTRIBUTION_KEY,
	PARENT_DISTRIBUTION_ID,
	SURVEY_SOURCE_TYPE,
	DISTRIBUTION_STATUS,
	DISTRIBUTION_TYPE,
	SURVEY_KEY,
	SURVEY_ID,
	DISTRIBUTION_NAME,
	SEND_DATE,
	CREATED_DATE,
	MODIFIED_DATE,
	FAILED,
	FINISHED,
	SENT,
	STARTED,
	CREDITS,
	SEGMENTS,
	BLOCKED,
	BOUNCED,
	COMPLAINTS,
	OPENED,
	SKIPPED,
	SURVEY_LINK_EXPIRATION_DATE,
    SOURCE_SYSTEM_ID,
    SOURCE_SYSTEM_CODE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE ,
	ETL_INSERTED_BY,
	ETL_UPDATED_DATE ,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG,
	ETL_INFERRED_MEMBER_FLAG 
) 
VALUES (
    STAGE.QUALTRICS_DIM_DISTRIBUTION_KEY,
	STAGE.PARENT_DISTRIBUTION_ID,
	STAGE.SURVEY_SOURCE_TYPE,
	STAGE.DISTRIBUTION_STATUS,
	STAGE.DISTRIBUTION_TYPE,
	STAGE.SURVEY_KEY,
	STAGE.SURVEY_ID,
	STAGE.DISTRIBUTION_NAME,
	STAGE.SEND_DATE,
	STAGE.CREATED_DATE,
	STAGE.MODIFIED_DATE,
	STAGE.FAILED,
	STAGE.FINISHED,
	STAGE.SENT,
	STAGE.STARTED,
	STAGE.CREDITS,
	STAGE.SEGMENTS,
	STAGE.BLOCKED,
	STAGE.BOUNCED,
	STAGE.COMPLAINTS,
	STAGE.OPENED,
	STAGE.SKIPPED,
	STAGE.SURVEY_LINK_EXPIRATION_DATE,
        STAGE.SOURCE_SYSTEM_ID,
        STAGE.SOURCE_SYSTEM_CODE,
	STAGE.ETL_TASK_KEY,
	STAGE.ETL_INSERTED_TASK_KEY,
	STAGE.ETL_INSERTED_DATE ,
	STAGE.ETL_INSERTED_BY,
	STAGE.ETL_UPDATED_DATE ,
	STAGE.ETL_LAST_UPDATED_BY,
	STAGE.ETL_DELETED_FLAG,
	STAGE.ETL_INFERRED_MEMBER_FLAG
);

END;
';