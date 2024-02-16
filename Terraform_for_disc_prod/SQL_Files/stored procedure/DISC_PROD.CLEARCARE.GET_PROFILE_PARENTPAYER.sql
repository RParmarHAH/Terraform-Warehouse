CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_PROFILE_PARENTPAYER("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_profile_parentpayer 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.profile_parentpayer  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS agency_id, t.$5 AS payee_id, t.$6 AS invoice_type, t.$7 AS multi_client_invoice, t.$8 AS invoice_duedate_terms, t.$9 AS provider_npi, t.$10 AS qualifier, t.$11 AS payer_id, t.$12 AS default_mileage_rate, t.$13 AS one_authorization_per_invoice, t.$14 AS health_plan_id, t.$15 AS parent_payer_in_box_38, t.$16 AS show_carelog_start_and_end_in_description, t.$17 AS pays_expenses, t.$18 AS pays_tax, t.$19 AS box_23_on_multipage_invoices, t.$20 AS deleted, t.$21 AS originator_id, t.$22 AS last_updated_by_id, t.$23 AS deleted_by_id, t.$24 AS plan_type, t.$25 AS box_31_custom_name, t.$26 AS track_in_n_minute_units, t.$27 AS laim_submission_method, t.$28 AS requires_care_logs, t.$29 AS business_entity_id, t.$30 AS business_entity_medicaid_id, t.$31 AS user_id, t.$32 AS encrypted_password, t.$33 AS sftp_url, t.$34 AS sftp_user_id, t.$35 AS encrypted_sftp_password, t.$36 AS evv_mandated, t.$37 AS evv_provider, t.$38 AS claim_line_item_content, t.$39 AS line_items_per_claim, t.$40 AS billing_provider_taxonomy_code, t.$41 AS interchange_receiver_id, t.$42 AS interchange_receiver_id_qualifier, t.$43 AS interchange_sender_id, t.$44 AS interchange_sender_id_qualifier, t.$45 AS payer_identifier, t.$46 AS payer_type, t.$47 AS receiver_primary_identifier, t.$48 AS claim_plan_type, t.$49 AS payer_provider, t.$50 AS date_deleted, t.$51 AS franchisor_id, t.$52 AS SYS_CHANGE_VERSION, t.$53 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$53,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_parentpayer.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';