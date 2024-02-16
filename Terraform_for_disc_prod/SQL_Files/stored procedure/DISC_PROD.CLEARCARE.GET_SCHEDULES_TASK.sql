CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_SCHEDULES_TASK("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_schedules_task 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.schedules_task  (SELECT t.$1 AS id, t.$2 AS shift_id, t.$3 AS title, t.$4 AS description, t.$5 AS cci_start, t.$6 AS cci_end, t.$7 AS original_tz, t.$8 AS assessment_task_id, t.$9 AS created, t.$10 AS updated, t.$11 AS deleted, t.$12 AS originator_id, t.$13 AS last_updated_by_id, t.$14 AS deleted_by_id, t.$15 AS weekday_filter, t.$16 AS client_id, t.$17 AS date_deleted, t.$18 AS agency_id, t.$19 AS franchisor_id, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_schedules_task.*[.]csv.gz'') t);

   
    return ''Success'';
END;
';