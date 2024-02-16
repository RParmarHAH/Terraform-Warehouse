resource "snowflake_procedure" "DISC_CLEARCARE_GET_ASSESSMENT_CLIENTTASK" {
	name ="GET_ASSESSMENT_CLIENTTASK"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

 
--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_assessment_clienttask 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.assessment_clienttask  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS client_id, t.$5 AS life_activity_task_id, t.$6 AS life_activity_id, t.$7 AS title, t.$8 AS caregiver_instruction, t.$9 AS active, t.$10 AS start_time, t.$11 AS shift_range, t.$12 AS deleted, t.$13 AS originator_id, t.$14 AS last_updated_by_id, t.$15 AS deleted_by_id, t.$16 AS shift_days, t.$17 AS rate_schedule_id, t.$18 AS amount, t.$19 AS duration, t.$20 AS cci_start, t.$21 AS cci_end, t.$22 AS original_tz, t.$23 AS community_task_id, t.$24 AS task_type, t.$25 AS status, t.$26 AS date_deleted, t.$27 AS agency_id, t.$28 AS franchisor_id, t.$29 AS SYS_CHANGE_VERSION, t.$30 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$30,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_assessment_clienttask.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

