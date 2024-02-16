CREATE OR REPLACE PROCEDURE DISC_PROD.CLEARCARE.GET_PROFILE_CONTACT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ClearCare.GET_profile_contact 
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
    INSERT OVERWRITE INTO DISC_PROD.ClearCare.profile_contact  (SELECT t.$1 AS id, t.$2 AS profile_id, t.$3 AS contact_type, t.$4 AS relation_type, t.$5 AS first_name, t.$6 AS last_name, t.$7 AS address, t.$8 AS address_line_2, t.$9 AS email, t.$10 AS city, t.$11 AS state, t.$12 AS zip, t.$13 AS country, t.$14 AS phone_number_1, t.$15 AS phone_number_2, t.$16 AS note, t.$17 AS is_primary_contact, t.$18 AS is_emergency_contact, t.$19 AS is_poa, t.$20 AS deleted_by_id, t.$21 AS last_updated_by_id, t.$22 AS originator_id, t.$23 AS created, t.$24 AS updated, t.$25 AS deleted, t.$26 AS agency_id, t.$27 AS franchisor_id, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_contact.*[.]csv.gz'') t);

    
    return ''Success'';
END;
';