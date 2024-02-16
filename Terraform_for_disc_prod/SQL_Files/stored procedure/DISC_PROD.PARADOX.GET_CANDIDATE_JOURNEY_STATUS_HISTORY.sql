CREATE OR REPLACE PROCEDURE DISC_PROD.PARADOX.GET_CANDIDATE_JOURNEY_STATUS_HISTORY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  GET_CANDIDATE_JOURNEY_STATUS_HISTORY 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR										NOTES:
-- ----------		-------------------							-----------------------------------------------------------------------------------------------
-- 2023-11-20		KOMAL DHOKAI/RAVI SUTHAR					INITIAL DEVELOPMENT
--*****************************************************************************************************************************

 
BEGIN 
    --TARGETSQL
    COPY INTO DISC_PROD.PARADOX.HIST_CANDIDATE_JOURNEY_STATUS_HISTORY FROM (SELECT DISTINCT  A.$1 CANDIDATE_ID, A.$2 CANDIDATE_NAME, A.$3 CANDIDATE_PHONE_NUMBER, A.$4 CANDIDATE_EMAIL, A.$5 CANDIDATE_CREATE_DATE, A.$6 REQUISITION_ID, A.$7 JOB_TITLE, A.$8 JOB_CODE, A.$9 LOCATION_NAME, A.$10 CANDIDATE_JOURNEY_NAME, A.$11 JOURNEY_STAGE_NAME, A.$12 JOURNEY_STAGE_ORDER_NUMBER, A.$13 JOURNEY_STATUS_ORDER_NUMBER, A.$14 STATUS_CHANGE_DATE, A.$15 STATUS, A.$16 STATUS_CHANGED_BY_USER, A.$17 CANDIDATE_SOURCE, A.$18 CANDIDATE_SOURCED_FROM_NAME, A.$19 PROFILE_ID, A.$20 MULTIPLE_RECORDS, A.$21 PRIMARY_IDENTIFIER, A.$22 REAPPLY_IN_CAPTURE, A.$23 REAPPLY_IN_JOB_SEARCH, A.$24 REAPPLY_IN_CAMPAIGN, :TASKKEY AS ETL_TASK_KEY, :TASKKEY AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG  FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/PARADOX/Upload_file/HireCandidate.Journey.Status.History (FILE_FORMAT => DISC_PROD.STAGE.CSV_FORMAT) A);

    --VIEWSQL
    MERGE INTO DISC_PROD.PARADOX.CANDIDATE_JOURNEY_STATUS_HISTORY TGT  USING (   SELECT *   FROM DISC_PROD.PARADOX.HIST_CANDIDATE_JOURNEY_STATUS_HISTORY WHERE ETL_LAST_UPDATED_DATE = ( SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.PARADOX.HIST_CANDIDATE_JOURNEY_STATUS_HISTORY) ) STAGE  ON TGT.CANDIDATE_ID = STAGE.CANDIDATE_ID AND TGT.CANDIDATE_JOURNEY_NAME = STAGE.CANDIDATE_JOURNEY_NAME AND TGT.STATUS_CHANGE_DATE = STAGE.STATUS_CHANGE_DATE AND TGT.STATUS = STAGE.STATUS WHEN MATCHED THEN  UPDATE SET     TGT.CANDIDATE_ID = STAGE.CANDIDATE_ID, TGT.CANDIDATE_NAME = STAGE.CANDIDATE_NAME, TGT.CANDIDATE_PHONE_NUMBER = STAGE.CANDIDATE_PHONE_NUMBER, TGT.CANDIDATE_EMAIL = STAGE.CANDIDATE_EMAIL, TGT.CANDIDATE_CREATE_DATE = STAGE.CANDIDATE_CREATE_DATE, TGT.REQUISITION_ID = STAGE.REQUISITION_ID, TGT.JOB_TITLE = STAGE.JOB_TITLE, TGT.JOB_CODE = STAGE.JOB_CODE, TGT.LOCATION_NAME = STAGE.LOCATION_NAME, TGT.CANDIDATE_JOURNEY_NAME = STAGE.CANDIDATE_JOURNEY_NAME, TGT.JOURNEY_STAGE_NAME = STAGE.JOURNEY_STAGE_NAME, TGT.JOURNEY_STAGE_ORDER_NUMBER = STAGE.JOURNEY_STAGE_ORDER_NUMBER, TGT.JOURNEY_STATUS_ORDER_NUMBER = STAGE.JOURNEY_STATUS_ORDER_NUMBER, TGT.STATUS_CHANGE_DATE = STAGE.STATUS_CHANGE_DATE, TGT.STATUS = STAGE.STATUS, TGT.STATUS_CHANGED_BY_USER = STAGE.STATUS_CHANGED_BY_USER, TGT.CANDIDATE_SOURCE = STAGE.CANDIDATE_SOURCE, TGT.CANDIDATE_SOURCED_FROM_NAME = STAGE.CANDIDATE_SOURCED_FROM_NAME, TGT.PROFILE_ID = STAGE.PROFILE_ID, TGT.MULTIPLE_RECORDS = STAGE.MULTIPLE_RECORDS, TGT.PRIMARY_IDENTIFIER = STAGE.PRIMARY_IDENTIFIER, TGT.REAPPLY_IN_CAPTURE = STAGE.REAPPLY_IN_CAPTURE, TGT.REAPPLY_IN_JOB_SEARCH = STAGE.REAPPLY_IN_JOB_SEARCH, TGT.REAPPLY_IN_CAMPAIGN = STAGE.REAPPLY_IN_CAMPAIGN ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG::NUMBER WHEN NOT MATCHED THEN  INSERT (  CANDIDATE_ID, CANDIDATE_NAME, CANDIDATE_PHONE_NUMBER, CANDIDATE_EMAIL, CANDIDATE_CREATE_DATE, REQUISITION_ID, JOB_TITLE, JOB_CODE, LOCATION_NAME, CANDIDATE_JOURNEY_NAME, JOURNEY_STAGE_NAME, JOURNEY_STAGE_ORDER_NUMBER, JOURNEY_STATUS_ORDER_NUMBER, STATUS_CHANGE_DATE, STATUS, STATUS_CHANGED_BY_USER, CANDIDATE_SOURCE, CANDIDATE_SOURCED_FROM_NAME, PROFILE_ID, MULTIPLE_RECORDS, PRIMARY_IDENTIFIER, REAPPLY_IN_CAPTURE, REAPPLY_IN_JOB_SEARCH, REAPPLY_IN_CAMPAIGN, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG )  VALUES ( STAGE.CANDIDATE_ID, STAGE.CANDIDATE_NAME, STAGE.CANDIDATE_PHONE_NUMBER, STAGE.CANDIDATE_EMAIL, STAGE.CANDIDATE_CREATE_DATE, STAGE.REQUISITION_ID, STAGE.JOB_TITLE, STAGE.JOB_CODE, STAGE.LOCATION_NAME, STAGE.CANDIDATE_JOURNEY_NAME, STAGE.JOURNEY_STAGE_NAME, STAGE.JOURNEY_STAGE_ORDER_NUMBER, STAGE.JOURNEY_STATUS_ORDER_NUMBER, STAGE.STATUS_CHANGE_DATE, STAGE.STATUS, STAGE.STATUS_CHANGED_BY_USER, STAGE.CANDIDATE_SOURCE, STAGE.CANDIDATE_SOURCED_FROM_NAME, STAGE.PROFILE_ID, STAGE.MULTIPLE_RECORDS, STAGE.PRIMARY_IDENTIFIER, STAGE.REAPPLY_IN_CAPTURE, STAGE.REAPPLY_IN_JOB_SEARCH, STAGE.REAPPLY_IN_CAMPAIGN, STAGE.ETL_TASK_KEY, STAGE.ETL_INSERTED_TASK_KEY, STAGE.ETL_INSERTED_DATE, STAGE.ETL_INSERTED_BY, STAGE.ETL_LAST_UPDATED_DATE, STAGE.ETL_LAST_UPDATED_BY, STAGE.ETL_DELETED_FLAG::NUMBER );

    RETURN ''SUCCESS'';
END;

';