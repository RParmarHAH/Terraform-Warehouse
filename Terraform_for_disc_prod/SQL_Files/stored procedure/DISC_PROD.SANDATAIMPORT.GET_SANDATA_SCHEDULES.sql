CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAIMPORT.GET_SANDATA_SCHEDULES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  GET_SANDATA_SCHEDULES 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- ----------  -------------------   -----------------------------------------------------------------------------------------------
-- 2023-11-20 RAVI SUTHAR            INITIAL DEVELOPMENT
--*****************************************************************************************************************************
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SandataImport.GET_Sandata_Schedules 
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
    COPY INTO DISC_PROD.SandataImport.HIST_Sandata_Schedules FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS ScheduleID, t.$4 AS ServiceID, t.$5 AS Company, t.$6 AS Status, t.$7 AS Status2, t.$8 AS CancelReason, t.$9 AS ScheduleDate, t.$10 AS ScheduleTimeZone, t.$11 AS ProposedTimeIn, t.$12 AS ProposedTimeOut, t.$13 AS ProposedDuration, t.$14 AS EVVTimeIn, t.$15 AS EVVTimeOut, t.$16 AS EVVDuration, t.$17 AS ScheduledTimeIn, t.$18 AS ScheduledTimeOut, t.$19 AS ScheduledDuration, t.$20 AS VerificationType, t.$21 AS Comments, t.$22 AS Miles, t.$23 AS Supplies, t.$24 AS isInService, t.$25 AS CreatedAt, t.$26 AS UpdatedAt, t.$27 AS HashedRowValues, t.$28 AS BatchId, t.$29 AS CancelReasonNotes, t.$30 AS ExceptionCode, t.$31 AS ReasonCode, t.$32 AS ResolutionCode, t.$33 AS RejectionCode, t.$34 AS SYS_CHANGE_VERSION, t.$35 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$35,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/SandataImport_Sandata_Schedules.csv.gz (FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_Schedules AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_Schedules GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_Schedules t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';