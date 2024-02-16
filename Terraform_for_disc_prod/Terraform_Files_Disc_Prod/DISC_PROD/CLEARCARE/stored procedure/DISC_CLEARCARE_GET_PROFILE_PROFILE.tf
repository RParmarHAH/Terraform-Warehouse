resource "snowflake_procedure" "DISC_CLEARCARE_GET_PROFILE_PROFILE" {
	name ="GET_PROFILE_PROFILE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_profile_profile 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.profile_profile  (SELECT t.$1 AS id, t.$2 AS user_id, t.$3 AS agency_id, t.$4 AS address, t.$5 AS address_line_2, t.$6 AS city, t.$7 AS state, t.$8 AS zip, t.$9 AS home_phone, t.$10 AS mobile_phone, t.$11 AS work_phone, t.$12 AS photo, t.$13 AS is_authorized, t.$14 AS authorized_date, t.$15 AS company_name, t.$16 AS middle_name, t.$17 AS agency_admin_id, t.$18 AS patient_id, t.$19 AS caregiver_id, t.$20 AS email, t.$21 AS first_name, t.$22 AS last_name, t.$23 AS timezone, t.$24 AS company_id, t.$25 AS is_company, t.$26 AS email_valid, t.$27 AS send_sms, t.$28 AS carrier_id, t.$29 AS sms_valid, t.$30 AS send_alerts, t.$31 AS title, t.$32 AS fax_phone, t.$33 AS extra_field, t.$34 AS pin, t.$35 AS qb_list_id, t.$36 AS esignature_flag, t.$37 AS send_esig_notification, t.$38 AS esignature_turnon_date, t.$39 AS esignature_admin_name, t.$40 AS import_id, t.$41 AS referral_source_id, t.$42 AS derived_id, t.$43 AS qb_person_id, t.$44 AS qb_add, t.$45 AS external_id, t.$46 AS email_invoices, t.$47 AS geolocation_id, t.$48 AS created, t.$49 AS updated, t.$50 AS kpi_dashboard_state, t.$51 AS unsubscribe_code, t.$52 AS email_confirmed, t.$53 AS email_confirmation_sent, t.$54 AS email_confirmation_required, t.$55 AS email_unsubscribed, t.$56 AS email_unsubscribed_reason, t.$57 AS sms_confirmed, t.$58 AS sms_confirmation_required, t.$59 AS sms_confirmation_sent, t.$60 AS sms_unsubscribed, t.$61 AS sms_unsubscribed_reason, t.$62 AS parent_payer_id, t.$63 AS last_status_id, t.$64 AS last_status_text, t.$65 AS last_contact_date, t.$66 AS mobile_phone_telephony, t.$67 AS work_phone_telephony, t.$68 AS salesforce_contact_id, t.$69 AS pay_holiday_rate, t.$70 AS deleted, t.$71 AS originator_id, t.$72 AS last_updated_by_id, t.$73 AS deleted_by_id, t.$74 AS advance_billing_enabled, t.$75 AS advance_billing_adjustment_mode_enabled, t.$76 AS no_middle_name, t.$77 AS remittance_address_id, t.$78 AS franchisor_id, t.$79 AS SYS_CHANGE_VERSION, t.$80 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$80,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_profile.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

