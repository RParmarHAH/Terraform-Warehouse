resource "snowflake_procedure" "DISC_CLEARCARE_GET_PROFILE_PATIENT_AGENCYLOCATION" {
	name ="GET_PROFILE_PATIENT_AGENCYLOCATION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_profile_patient_agencylocation 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.profile_patient_agencylocation  (SELECT t.$1 AS id, t.$2 AS user_id, t.$3 AS agency_id, t.$4 AS address, t.$5 AS address_line_2, t.$6 AS city, t.$7 AS state, t.$8 AS zip, t.$9 AS home_phone, t.$10 AS mobile_phone, t.$11 AS work_phone, t.$12 AS photo, t.$13 AS is_authorized, t.$14 AS authorized_date, t.$15 AS company_name, t.$16 AS middle_name, t.$17 AS agency_admin_id, t.$18 AS patient_id, t.$19 AS caregiver_id, t.$20 AS email, t.$21 AS first_name, t.$22 AS last_name, t.$23 AS timezone, t.$24 AS company_id, t.$25 AS is_company, t.$26 AS email_valid, t.$27 AS send_sms, t.$28 AS carrier_id, t.$29 AS sms_valid, t.$30 AS send_alerts, t.$31 AS title, t.$32 AS fax_phone, t.$33 AS extra_field, t.$34 AS pin, t.$35 AS qb_list_id, t.$36 AS esignature_flag, t.$37 AS send_esig_notification, t.$38 AS esignature_turnon_date, t.$39 AS esignature_admin_name, t.$40 AS import_id, t.$41 AS referral_source_id, t.$42 AS derived_id, t.$43 AS qb_person_id, t.$44 AS qb_add, t.$45 AS external_id, t.$46 AS email_invoices, t.$47 AS geolocation_id, t.$48 AS created, t.$49 AS updated, t.$50 AS kpi_dashboard_state, t.$51 AS unsubscribe_code, t.$52 AS email_confirmed, t.$53 AS email_confirmation_sent, t.$54 AS email_confirmation_required, t.$55 AS email_unsubscribed, t.$56 AS email_unsubscribed_reason, t.$57 AS sms_confirmed, t.$58 AS sms_confirmation_required, t.$59 AS sms_confirmation_sent, t.$60 AS sms_unsubscribed, t.$61 AS sms_unsubscribed_reason, t.$62 AS parent_payer_id, t.$63 AS last_status_id, t.$64 AS last_status_text, t.$65 AS last_contact_date, t.$66 AS mobile_phone_telephony, t.$67 AS work_phone_telephony, t.$68 AS salesforce_contact_id, t.$69 AS pay_holiday_rate, t.$70 AS deleted, t.$71 AS originator_id, t.$72 AS last_updated_by_id, t.$73 AS deleted_by_id, t.$74 AS advance_billing_enabled, t.$75 AS advance_billing_adjustment_mode_enabled, t.$76 AS no_middle_name, t.$77 AS remittance_address_id, t.$78 AS date_deleted, t.$79 AS date_deactivated, t.$80 AS deactivated, t.$81 AS policy_id, t.$82 AS rate_id, t.$83 AS rate_type, t.$84 AS custom_amount, t.$85 AS location_id, t.$86 AS is_client, t.$87 AS referrer_id, t.$88 AS conversion_date, t.$89 AS primary_care_manager_id, t.$90 AS secondary_care_manager_id, t.$91 AS custom_field_value_id, t.$92 AS last_carelog_date, t.$93 AS esignature_client_flag, t.$94 AS esignature_caregiver_flag, t.$95 AS care_management_rate_type, t.$96 AS care_management_rate_id, t.$97 AS care_management_custom_amount, t.$98 AS marketer_id, t.$99 AS scheduler_id, t.$100 AS primary_manager_id, t.$101 AS secondary_manager_id, t.$102 AS deactivation_reason, t.$103 AS prospect_date_created, t.$104 AS client_date_created, t.$105 AS patient_updated, t.$106 AS charge_tax, t.$107 AS invoice_duedate_terms, t.$108 AS in_facility, t.$109 AS auto_clock_in_status, t.$110 AS payer_contact_id, t.$111 AS tax_jurisdiction, t.$112 AS qoc_consent_provided, t.$113 AS payment_portal_payment_methods, t.$114 AS client_billing_type, t.$115 AS custom_field_id, t.$116 AS custom_field_content_type_id, t.$117 AS meta, t.$118 AS name, t.$119 AS use_as_class, t.$120 AS payroll_dept_code, t.$121 AS payroll_branch_id, t.$122 AS is_place, t.$123 AS shift_type, t.$124 AS group_concurrent_invoice, t.$125 AS type_of_care, t.$126 AS mobile_location_geofence_radius, t.$127 AS place_id, t.$128 AS patient_type, t.$129 AS community_room_details, t.$130 AS created_local, t.$131 AS franchisor_id, t.$132 AS SYS_CHANGE_VERSION, t.$133 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$133,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_patient_agencylocation.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

