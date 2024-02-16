resource "snowflake_procedure" "DISC_CLEARCARE_GET_PATIENT_PATIENT" {
	name ="GET_PATIENT_PATIENT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_patient_patient 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.patient_patient  (SELECT t.$1 AS id, t.$2 AS user_id, t.$3 AS date_deactivated, t.$4 AS deactivated, t.$5 AS policy_id, t.$6 AS rate_id, t.$7 AS rate_type, t.$8 AS custom_amount, t.$9 AS location_id, t.$10 AS agency_id, t.$11 AS is_client, t.$12 AS referrer_id, t.$13 AS conversion_date, t.$14 AS primary_care_manager_id, t.$15 AS secondary_care_manager_id, t.$16 AS custom_field_value_id, t.$17 AS last_carelog_date, t.$18 AS esignature_client_flag, t.$19 AS esignature_caregiver_flag, t.$20 AS care_management_rate_type, t.$21 AS care_management_rate_id, t.$22 AS care_management_custom_amount, t.$23 AS marketer_id, t.$24 AS scheduler_id, t.$25 AS primary_manager_id, t.$26 AS secondary_manager_id, t.$27 AS deactivation_reason, t.$28 AS prospect_date_created, t.$29 AS client_date_created, t.$30 AS patient_updated, t.$31 AS charge_tax, t.$32 AS invoice_duedate_terms, t.$33 AS in_facility, t.$34 AS auto_clock_in_status, t.$35 AS payer_contact_id, t.$36 AS created, t.$37 AS updated, t.$38 AS tax_jurisdiction, t.$39 AS deleted, t.$40 AS originator_id, t.$41 AS last_updated_by_id, t.$42 AS deleted_by_id, t.$43 AS qoc_consent_provided, t.$44 AS payment_portal_payment_methods, t.$45 AS client_billing_type, t.$46 AS custom_field_id, t.$47 AS custom_field_content_type_id, t.$48 AS meta, t.$49 AS is_place, t.$50 AS shift_type, t.$51 AS group_concurrent_invoice, t.$52 AS type_of_care, t.$53 AS mobile_location_geofence_radius, t.$54 AS place_id, t.$55 AS patient_type, t.$56 AS community_room_details, t.$57 AS date_deleted, t.$58 AS default_community_task_set_id, t.$59 AS add_surcharge, t.$60 AS tasks_build_started, t.$61 AS disable_missed_clock_inout_alerts, t.$62 AS cuid, t.$63 AS tax_jurisdiction_cuid, t.$64 AS a_r_analyst_id, t.$65 AS secondary_marketer_id, t.$66 AS secondary_scheduler_id, t.$67 AS is_auto_clock_in, t.$68 AS franchisor_id, t.$69 AS SYS_CHANGE_VERSION, t.$70 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$70,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_patient_patient.*[.]csv.gz'') t);

   
    return ''Success'';
END;

 EOT
}

