resource "snowflake_procedure" "DISC_CLEARCARE_GET_CAREGIVER_CAREGIVERPROFESSIONALREFERENCES" {
	name ="GET_CAREGIVER_CAREGIVERPROFESSIONALREFERENCES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_caregiver_caregiverprofessionalreferences 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.caregiver_caregiverprofessionalreferences  (SELECT t.$1 AS id, t.$2 AS caregiver_skills_education_id, t.$3 AS name, t.$4 AS references_phone_number, t.$5 AS created, t.$6 AS updated, t.$7 AS deleted, t.$8 AS originator_id, t.$9 AS last_updated_by_id, t.$10 AS deleted_by_id, t.$11 AS date_deleted, t.$12 AS agency_id, t.$13 AS franchisor_id, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_caregiver_caregiverprofessionalreferences.*[.]csv.gz'') t);

   
    return ''Success'';
END;

 EOT
}

