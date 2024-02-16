resource "snowflake_procedure" "DISC_CLEARCARE_GET_CAREGIVER_CAREGIVERCERTIFICATION" {
	name ="GET_CAREGIVER_CAREGIVERCERTIFICATION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_caregiver_caregivercertification 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.caregiver_caregivercertification  (SELECT t.$1 AS id, t.$2 AS caregiver_skills_education_id, t.$3 AS type, t.$4 AS notes, t.$5 AS expiration_date, t.$6 AS alert_date, t.$7 AS alert_caregiver, t.$8 AS custom_type, t.$9 AS active, t.$10 AS agency_certification_id, t.$11 AS created, t.$12 AS updated, t.$13 AS deleted, t.$14 AS originator_id, t.$15 AS last_updated_by_id, t.$16 AS deleted_by_id, t.$17 AS date_deleted, t.$18 AS agency_id, t.$19 AS franchisor_id, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_caregiver_caregivercertification.*[.]csv.gz'') t);

   
    return ''Success'';
END;

 EOT
}

