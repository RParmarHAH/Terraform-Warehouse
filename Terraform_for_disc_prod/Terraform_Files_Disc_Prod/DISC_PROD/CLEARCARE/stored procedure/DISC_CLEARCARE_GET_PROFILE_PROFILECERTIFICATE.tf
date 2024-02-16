resource "snowflake_procedure" "DISC_CLEARCARE_GET_PROFILE_PROFILECERTIFICATE" {
	name ="GET_PROFILE_PROFILECERTIFICATE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_profile_profilecertificate 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.profile_profilecertificate  (SELECT t.$1 AS id, t.$2 AS profile_id, t.$3 AS agency_certificate_id, t.$4 AS created, t.$5 AS updated, t.$6 AS deleted, t.$7 AS active, t.$8 AS number, t.$9 AS notes, t.$10 AS expiration_date, t.$11 AS alert_date, t.$12 AS alert_profile, t.$13 AS issued, t.$14 AS issued_by, t.$15 AS confirmed, t.$16 AS confirmed_by, t.$17 AS compact, t.$18 AS confirmed_by_profile_id, t.$19 AS deleted_by_id, t.$20 AS updated_by_id, t.$21 AS originator_id, t.$22 AS date_deleted, t.$23 AS franchisor_id, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_profile_profilecertificate.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

