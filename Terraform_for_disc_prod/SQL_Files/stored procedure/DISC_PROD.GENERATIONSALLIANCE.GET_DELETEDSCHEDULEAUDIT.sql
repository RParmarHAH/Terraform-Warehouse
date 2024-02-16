CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_DELETEDSCHEDULEAUDIT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_DeletedScheduleAudit 
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
    COPY INTO GENERATIONSALLIANCE.DeletedScheduleAudit FROM (SELECT t.$1 AS SocialSecNum, t.$2 AS ClientId, t.$3 AS Date, t.$4 AS StartTime, t.$5 AS EndTime, t.$6 AS ServiceCode, t.$7 AS IsConfirmed, t.$8 AS serviceRequestId, t.$9 AS itemName, t.$10 AS createdBy, t.$11 AS created, t.$12 AS updatedBy, t.$13 AS lastUpdated, t.$14 AS notes, t.$15 AS scheduleID, t.$16 AS timematch, t.$17 AS int_missedstatus, t.$18 AS TelephonyAlertEnabled, t.$19 AS PayorId, t.$20 AS EnableClientQA, t.$21 AS MileageEnabled, t.$22 AS DeletedBy, t.$23 AS DeletedDateTime, t.$24 AS deletedSource, t.$25 AS IsCGSignRequired, t.$26 AS IsClientSignRequired, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_DeletedScheduleAudit.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.DeletedScheduleAudit AS WITH curr_v AS (SELECT scheduleID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.DeletedScheduleAudit GROUP BY scheduleID) SELECT t.* FROM GENERATIONSALLIANCE.DeletedScheduleAudit t INNER JOIN curr_v v ON t.scheduleID = v.scheduleID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';