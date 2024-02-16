resource "snowflake_procedure" "DISC_CLEARCARE_GET_ACTIVITY_ACTIVITY" {
	name ="GET_ACTIVITY_ACTIVITY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_activity_activity 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.activity_activity  (SELECT t.$1 AS id, t.$2 AS activity_type, t.$3 AS method, t.$4 AS status, t.$5 AS created_by_id, t.$6 AS the_date,t.$7 AS created, t.$8 AS send_alert, t.$9 AS alert_sent, t.$10 AS agency_id, t.$11 AS status_change_date, t.$12 AS email_id, t.$13 AS note_id, t.$14 AS shift_id, t.$15 AS carelog_id, t.$16 AS signature_id, t.$17 AS import_id, t.$18 AS change_log_id, t.$19 AS updated, t.$20 AS deleted, t.$21 AS originator_id, t.$22 AS last_updated_by_id, t.$23 AS deleted_by_id, t.$24 AS agency_event_id, t.$25 AS include_in_calendars, t.$26 AS include_in_family_room, t.$27 AS include_in_printed_calendars, t.$28 AS include_in_caregiver_portal, t.$29 AS hospitalization_id, t.$30 AS change_in_condition_id, t.$31 AS safety_task_id, t.$32 AS due_on, t.$33 AS completed_on, t.$34 AS meta, t.$35 AS date_deleted, t.$36 AS franchisor_id, t.$37 AS SYS_CHANGE_VERSION, t.$38 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$38,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_activity_activity.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

