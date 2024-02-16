resource "snowflake_procedure" "DISC_CLEARCARE_GET_CARELOGS_TASKLOG" {
	name ="GET_CARELOGS_TASKLOG"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_carelogs_tasklog 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.carelogs_tasklog  (SELECT t.$1 AS id, t.$2 AS task_id, t.$3 AS title, t.$4 AS description, t.$5 AS care_log_id, t.$6 AS status, t.$7 AS recorded, t.$8 AS cci_start, t.$9 AS cci_end, t.$10 AS original_tz, t.$11 AS general_comment, t.$12 AS created, t.$13 AS updated, t.$14 AS deleted, t.$15 AS originator_id, t.$16 AS last_updated_by_id, t.$17 AS deleted_by_id, t.$18 AS client_task_instance_id, t.$19 AS duration, t.$20 AS date_deleted, t.$21 AS agency_id, t.$22 AS franchisor_id, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_carelogs_tasklog.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

