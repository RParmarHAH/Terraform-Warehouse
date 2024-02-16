resource "snowflake_procedure" "DISC_CLEARCARE_GET_PROFILE_PATIENTCONTACT" {
	name ="GET_PROFILE_PATIENTCONTACT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_profile_patientcontact 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.profile_patientcontact  (SELECT t.$1 AS id, t.$2 AS profile_id, t.$3 AS patient_id, t.$4 AS contact_type, t.$5 AS primary_contact, t.$6 AS emergency_contact, t.$7 AS relation_type, t.$8 AS payer, t.$9 AS poa, t.$10 AS save_me, t.$11 AS provider_id, t.$12 AS family_room_invite_members, t.$13 AS family_room_create_todos, t.$14 AS family_room_schedule_events, t.$15 AS family_room_manage_meds, t.$16 AS family_room_contact_admins_caregivers, t.$17 AS family_room_administrator, t.$18 AS family_room_show_invoices, t.$19 AS created, t.$20 AS updated, t.$21 AS deleted, t.$22 AS originator_id, t.$23 AS last_updated_by_id, t.$24 AS deleted_by_id, t.$25 AS epayer_contact, t.$26 AS family_room_is_accessible, t.$27 AS email_invoices, t.$28 AS family_room_show_auths, t.$29 AS print_on_care_plan, t.$30 AS care_plan_print_order, t.$31 AS date_deleted, t.$32 AS agency_id, t.$33 AS franchisor_id, t.$34 AS SYS_CHANGE_VERSION, t.$35 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$35,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_patientcontact.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

