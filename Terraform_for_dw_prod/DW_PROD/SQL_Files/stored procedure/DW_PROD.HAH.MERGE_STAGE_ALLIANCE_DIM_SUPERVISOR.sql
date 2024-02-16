CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_ALLIANCE_DIM_SUPERVISOR()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
	MERGE INTO HAH.DIM_SUPERVISOR TGT
	USING STAGE.ALLIANCE_DIM_SUPERVISOR STAGE
	ON TGT.SUPERVISOR_KEY=STAGE.SUPERVISOR_KEY
	WHEN MATCHED THEN 
UPDATE SET 
    TGT.SUPERVISOR_CODE= STAGE.SUPERVISOR_CODE
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SUPERVISOR_NAME= STAGE.SUPERVISOR_NAME
   ,TGT.SUPERVISOR_STATE_CODE= STAGE.SUPERVISOR_STATE_CODE
   ,TGT.SUPERVISOR_JOB_CODE= STAGE.SUPERVISOR_JOB_CODE
   ,TGT.SUPERVISOR_JOB_TITLE= STAGE.SUPERVISOR_JOB_TITLE
   ,TGT.EFFECTIVE_FROM_DATE= STAGE.EFFECTIVE_FROM_DATE
   ,TGT.EFFECTIVE_TO_DATE= STAGE.EFFECTIVE_TO_DATE
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   ,TGT.ETL_INFERRED_MEMBER_FLAG= STAGE.ETL_INFERRED_MEMBER_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    SUPERVISOR_KEY
   ,SUPERVISOR_CODE
   ,SYSTEM_CODE
   ,SOURCE_SYSTEM_ID
   ,SUPERVISOR_NAME
   ,SUPERVISOR_STATE_CODE
   ,SUPERVISOR_JOB_CODE
   ,SUPERVISOR_JOB_TITLE
   ,EFFECTIVE_FROM_DATE
   ,EFFECTIVE_TO_DATE
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
   ,ETL_INFERRED_MEMBER_FLAG
) 
VALUES (
    STAGE.SUPERVISOR_KEY
   ,STAGE.SUPERVISOR_CODE
   ,STAGE.SYSTEM_CODE
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SUPERVISOR_NAME
   ,STAGE.SUPERVISOR_STATE_CODE
   ,STAGE.SUPERVISOR_JOB_CODE
   ,STAGE.SUPERVISOR_JOB_TITLE
   ,STAGE.EFFECTIVE_FROM_DATE
   ,STAGE.EFFECTIVE_TO_DATE
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
   ,STAGE.ETL_INFERRED_MEMBER_FLAG
);
RETURN ''SUCCESS'';
END;
    ';