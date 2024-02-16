resource "snowflake_procedure" "DISC_CLEARCARE_GET_BILLING_CLIENTAUTHORIZATION" {
	name ="GET_BILLING_CLIENTAUTHORIZATION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_billing_clientauthorization 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.billing_clientauthorization  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS client_id, t.$5 AS payer_contact_id, t.$6 AS parent_payer_id, t.$7 AS authorization_id, t.$8 AS start_date, t.$9 AS end_date, t.$10 AS initial_hours, t.$11 AS live_in, t.$12 AS period, t.$13 AS status, t.$14 AS bill_rate_id, t.$15 AS notes, t.$16 AS service_id, t.$17 AS insurance_id, t.$18 AS referrer_id, t.$19 AS procedure_code, t.$20 AS modifier1, t.$21 AS icd9_code_id, t.$22 AS bill_amount, t.$23 AS bill_rate_name, t.$24 AS modifier2, t.$25 AS modifier3, t.$26 AS modifier4, t.$27 AS based_on, t.$28 AS initial_visits, t.$29 AS bill_rate_method, t.$30 AS bill_pro_rate, t.$31 AS agency_id, t.$32 AS referring_provider_id, t.$33 AS split_payers, t.$34 AS split_payer_profile_id, t.$35 AS split_units, t.$36 AS split_range, t.$37 AS split_limit, t.$38 AS split_units_type, t.$39 AS split_limit_total, t.$40 AS total_hours, t.$41 AS remaining_hours, t.$42 AS bill_mileage_rate, t.$43 AS revenue_code, t.$44 AS revenue_code_desc, t.$45 AS hipps_code, t.$46 AS type_of_bill, t.$47 AS type_of_admission, t.$48 AS source_of_admission, t.$49 AS patient_status, t.$50 AS treatment_authorization_codes, t.$51 AS show_instead_of_client_name_in_box_58, t.$52 AS person_relationship, t.$53 AS policy_group, t.$54 AS deleted, t.$55 AS originator_id, t.$56 AS last_updated_by_id, t.$57 AS deleted_by_id, t.$58 AS icd9_code_2_id, t.$59 AS icd9_code_3_id, t.$60 AS icd9_code_4_id, t.$61 AS leave_box_76_empty, t.$62 AS icd10_code_id, t.$63 AS icd10_code_2_id, t.$64 AS icd10_code_3_id, t.$65 AS icd10_code_4_id, t.$66 AS bill_expenses, t.$67 AS account_number, t.$68 AS display_in_family_room, t.$69 AS employment, t.$70 AS auto_accident, t.$71 AS other_accident, t.$72 AS remarks, t.$73 AS insurance_plan_or_program_name, t.$74 AS service_facility_location_info_id, t.$75 AS is_other_plan, t.$76 AS other_insured_name, t.$77 AS other_policy_number, t.$78 AS other_plan_name, t.$79 AS date_deleted, t.$80 AS franchisor_id, t.$81 AS SYS_CHANGE_VERSION, t.$82 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$82,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_billing_clientauthorization.*[.]csv.gz'') t);

   
    return ''Success'';
END;

 EOT
}

