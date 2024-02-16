CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_AGENCY_AGENCYADMIN("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_agency_agencyadmin 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.agency_agencyadmin  (SELECT t.$1 AS id, t.$2 AS user_id, t.$3 AS agency_id, t.$4 AS group_id, t.$5 AS hide_all_rates, t.$6 AS alert_unsuccessful_login, t.$7 AS send_invoice_replies, t.$8 AS super_admin, t.$9 AS account_owner, t.$10 AS updated, t.$11 AS created, t.$12 AS can_rate_caregivers, t.$13 AS my_agency_dashboard_id, t.$14 AS email_signature, t.$15 AS livedash_defaults, t.$16 AS deleted, t.$17 AS originator_id, t.$18 AS last_updated_by_id, t.$19 AS deleted_by_id, t.$20 AS read_only_access_to_accounting, t.$21 AS workers_comp_class_code_id, t.$22 AS pay_method, t.$23 AS pay_rate, t.$24 AS hours_per_week, t.$25 AS send_ach_alerts, t.$26 AS status_io_subscriber_id, t.$27 AS individual_rate_policy_and_service_auth_pages, t.$28 AS search_preferences, t.$29 AS date_deleted, t.$30 AS franchisor_id, t.$31 AS SYS_CHANGE_VERSION, t.$32 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$32,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_agency_agencyadmin.*[.]csv.gz'') t);

    return ''Success'';
END;
';