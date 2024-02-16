CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_SCHEDULES_SCHEDULE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_schedules_schedule 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.schedules_schedule  (SELECT t.$1 AS id, t.$2 AS cci_start, t.$3 AS freq, t.$4 AS cci_interval, t.$5 AS repeat_on, t.$6 AS repeat_by, t.$7 AS all_day, t.$8 AS original_tz, t.$9 AS cci_end, t.$10 AS cci_repeat_until, t.$11 AS unique_hash, t.$12 AS created, t.$13 AS updated, t.$14 AS deleted, t.$15 AS originator_id, t.$16 AS last_updated_by_id, t.$17 AS deleted_by_id, t.$18 AS date_deleted, t.$19 AS agency_id, t.$20 AS franchisor_id, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_schedules_schedule.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';