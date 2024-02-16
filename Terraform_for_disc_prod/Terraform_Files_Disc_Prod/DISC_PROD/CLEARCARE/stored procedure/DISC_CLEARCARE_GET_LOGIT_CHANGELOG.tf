resource "snowflake_procedure" "DISC_CLEARCARE_GET_LOGIT_CHANGELOG" {
	name ="GET_LOGIT_CHANGELOG"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_logit_changelog 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.logit_changelog  (SELECT t.$1 AS id, t.$2 AS agency_id, t.$3 AS profile_id, t.$4 AS content_type_id, t.$5 AS object_id, t.$6 AS the_changes, t.$7 AS cc_timestamp, t.$8 AS change_type, t.$9 AS static_name, t.$10 AS created, t.$11 AS updated, t.$12 AS deleted, t.$13 AS originator_id, t.$14 AS last_updated_by_id, t.$15 AS deleted_by_id, t.$16 AS cc_user_id, t.$17 AS franchisor_id, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_logit_changelog.*[.]csv.gz'') t);

   
    return ''Success'';
END;

 EOT
}

