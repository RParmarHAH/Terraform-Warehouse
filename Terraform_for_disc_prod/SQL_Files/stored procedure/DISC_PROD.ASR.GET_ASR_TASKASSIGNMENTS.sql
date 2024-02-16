CREATE OR REPLACE PROCEDURE DISC_PROD.ASR.GET_ASR_TASKASSIGNMENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ASR.GET_ASR_TASKASSIGNMENTS 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_PROD.ASR.HIST_ASR_TASKASSIGNMENTS FROM (SELECT A.$1 AS TaskAssignmentID, A.$2 AS TaskID, A.$3 AS HoursAssigned, A.$4 AS Notes, A.$5 AS PerRequest, A.$6 AS ServiceVisitID, A.$7 AS TaskStartDate, A.$8 AS TaskEndDate, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_TasksAssignments(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_TASKASSIGNMENTS AS WITH curr_v AS (SELECT TASKASSIGNMENTID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_PROD.ASR.HIST_ASR_TASKASSIGNMENTS GROUP BY TASKASSIGNMENTID) SELECT t.* FROM DISC_PROD.ASR.HIST_ASR_TASKASSIGNMENTS t INNER JOIN curr_v v ON t.TASKASSIGNMENTID = v.TASKASSIGNMENTID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';