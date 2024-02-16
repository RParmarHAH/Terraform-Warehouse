CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_DMAS90("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_DMAS90 
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
    COPY INTO GENERATIONSALLIANCE.DMAS90 FROM (SELECT t.$1 AS DMAS90ID, t.$2 AS WeeklyStartDate, t.$3 AS WeeklyEndDate, t.$4 AS ClientID, t.$5 AS SocialSecNum, t.$6 AS PhysicalConditionChanged, t.$7 AS EmotionalConditionChanged, t.$8 AS DailyActivityChanged, t.$9 AS ResponseToServiceChanged, t.$10 AS PhysicalConditionObservation, t.$11 AS EmotionalConditionObservation, t.$12 AS DailyActivityObservation, t.$13 AS ResponseToServiceObservation, t.$14 AS AdditionalObservation, t.$15 AS ClientSignature, t.$16 AS ClientSignDate, t.$17 AS CaregiverSignature, t.$18 AS CaregiverSignDate, t.$19 AS RNSignature, t.$20 AS RNSignDate, t.$21 AS PayorId, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_DMAS90.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.DMAS90 AS WITH curr_v AS (SELECT DMAS90ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.DMAS90 GROUP BY DMAS90ID) SELECT t.* FROM GENERATIONSALLIANCE.DMAS90 t INNER JOIN curr_v v ON t.DMAS90ID = v.DMAS90ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';