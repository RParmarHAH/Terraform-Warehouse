CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_CARELOGS_TASKCOMMENT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_carelogs_taskcomment 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.carelogs_taskcomment  (SELECT t.$1 AS id, t.$2 AS task_log_id, t.$3 AS comment, t.$4 AS user_id, t.$5 AS audio, t.$6 AS recording_sid, t.$7 AS recording_processed, t.$8 AS message_for_next_caregiver, t.$9 AS message_heard_by_next_caregiver, t.$10 AS show_in_family_room, t.$11 AS updated, t.$12 AS deleted, t.$13 AS originator_id, t.$14 AS last_updated_by_id, t.$15 AS deleted_by_id, t.$16 AS created, t.$17 AS date_deleted, t.$18 AS agency_id, t.$19 AS franchisor_id, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_carelogs_taskcomment.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';