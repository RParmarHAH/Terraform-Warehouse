resource "snowflake_procedure" "DISC_CLEARCARE_GET_CAREGIVER_CAREGIVER" {
	name ="GET_CAREGIVER_CAREGIVER"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_caregiver_caregiver 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.caregiver_caregiver  (SELECT t.$1 AS id, t.$2 AS user_id, t.$3 AS agency_id, t.$4 AS date_deactivated, t.$5 AS deactivated, t.$6 AS rate_id, t.$7 AS policy_id, t.$8 AS rate_type, t.$9 AS custom_amount, t.$10 AS employment_type, t.$11 AS location_id, t.$12 AS is_hired, t.$13 AS referrer_id, t.$14 AS care_manager, t.$15 AS custom_field_value_id, t.$16 AS last_carelog_date, t.$17 AS care_management_rate_type, t.$18 AS care_management_rate_id, t.$19 AS care_management_custom_amount, t.$20 AS deactivation_reason, t.$21 AS applicant_date_created, t.$22 AS caregiver_date_created, t.$23 AS caregiver_updated, t.$24 AS rating, t.$25 AS facility_pay_policy_id, t.$26 AS facility_pay_threshold, t.$27 AS created, t.$28 AS updated, t.$29 AS deleted, t.$30 AS originator_id, t.$31 AS last_updated_by_id, t.$32 AS deleted_by_id, t.$33 AS workers_comp_class_code_id, t.$34 AS hours_wanted_weekly, t.$35 AS custom_field_id, t.$36 AS custom_field_content_type_id, t.$37 AS allow_ad_hoc_telephony, t.$38 AS allow_ad_hoc_mobile, t.$39 AS first_carelog_date, t.$40 AS allow_mobile_clockin_with_location_disabled, t.$41 AS date_deleted, t.$42 AS heard_mobile_app_marketing_message, t.$43 AS allow_mobile_use_offline, t.$44 AS cuid, t.$45 AS caregiver_npi, t.$46 AS location_manager_id, t.$47 AS processor_id, t.$48 AS recruiter_id, t.$49 AS scheduler_id, t.$50 AS franchisor_id, t.$51 AS SYS_CHANGE_VERSION, t.$52 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$52,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_caregiver_caregiver.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

