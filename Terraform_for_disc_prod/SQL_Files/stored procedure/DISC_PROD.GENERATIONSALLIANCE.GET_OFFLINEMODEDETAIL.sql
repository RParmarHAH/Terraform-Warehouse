CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_OFFLINEMODEDETAIL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_OfflineModeDetail 
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
    COPY INTO GENERATIONSALLIANCE.OfflineModeDetail FROM (SELECT t.$1 AS OfflineDetailGuid, t.$2 AS ScheduleID, t.$3 AS ClientTelephonyID, t.$4 AS CaregiverTelephonyID, t.$5 AS Purpose, t.$6 AS DateOfService, t.$7 AS Message, t.$8 AS MatchedToSchedule, t.$9 AS CallID, t.$10 AS DeviceDetails, t.$11 AS ClientID, t.$12 AS SocialSecurityNum, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_OfflineModeDetail.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.OfflineModeDetail AS WITH curr_v AS (SELECT OfflineDetailGuid, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.OfflineModeDetail GROUP BY OfflineDetailGuid) SELECT t.* FROM GENERATIONSALLIANCE.OfflineModeDetail t INNER JOIN curr_v v ON t.OfflineDetailGuid = v.OfflineDetailGuid AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';