CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_REFERRAL_SOURCES_REFERRALSOURCE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_referral_sources_referralsource 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.referral_sources_referralsource  (SELECT t.$1 AS id, t.$2 AS agency_id, t.$3 AS client_count, t.$4 AS prospect_count, t.$5 AS caregiver_count, t.$6 AS applicant_count, t.$7 AS unique_key, t.$8 AS created, t.$9 AS updated, t.$10 AS referral_source_type_id, t.$11 AS lifetime_value, t.$12 AS owner_id, t.$13 AS activity_alert_days, t.$14 AS activity_alert_days_modified, t.$15 AS web_address, t.$16 AS deleted, t.$17 AS originator_id, t.$18 AS last_updated_by_id, t.$19 AS deleted_by_id, t.$20 AS community_count, t.$21 AS date_deleted, t.$22 AS franchisor_id, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_referral_sources_referralsource.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';