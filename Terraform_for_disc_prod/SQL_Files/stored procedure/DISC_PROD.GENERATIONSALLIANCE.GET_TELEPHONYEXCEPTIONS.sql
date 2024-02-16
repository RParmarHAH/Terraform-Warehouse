CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_TELEPHONYEXCEPTIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_TelephonyExceptions 
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
    COPY INTO GENERATIONSALLIANCE.TelephonyExceptions FROM (SELECT t.$1 AS ScheduleExceptionID, t.$2 AS ScheduleID, t.$3 AS ExceptionID, t.$4 AS int_PattiID, t.$5 AS Acknowledged, t.$6 AS ReasonID, t.$7 AS ResolutionID, t.$8 AS ExceptionNote, t.$9 AS Created, t.$10 AS CreatedBy, t.$11 AS Updatedby, t.$12 AS LastUpdated, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_TelephonyExceptions.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.TelephonyExceptions AS WITH curr_v AS (SELECT ScheduleExceptionID, ScheduleID, ExceptionID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.TelephonyExceptions GROUP BY ScheduleExceptionID, ScheduleID, ExceptionID) SELECT t.* FROM GENERATIONSALLIANCE.TelephonyExceptions t INNER JOIN curr_v v ON t.ScheduleExceptionID = v.ScheduleExceptionID AND t.ScheduleID = v.ScheduleID AND t.ExceptionID = v.ExceptionID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';