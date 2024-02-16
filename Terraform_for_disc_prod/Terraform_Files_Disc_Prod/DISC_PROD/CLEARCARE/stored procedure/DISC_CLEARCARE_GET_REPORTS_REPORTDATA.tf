resource "snowflake_procedure" "DISC_CLEARCARE_GET_REPORTS_REPORTDATA" {
	name ="GET_REPORTS_REPORTDATA"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_reports_reportdata 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.reports_reportdata  (SELECT t.$1 AS id, t.$2 AS report_name, t.$3 AS report_key,  t.$4 AS agency_id, t.$5 AS created_by_id, t.$6 AS created, t.$7 AS expires, t.$8 AS token, t.$9 AS status, t.$10 AS file, t.$11 AS report_generation_time, t.$12 AS wall_time, t.$13 AS updated, t.$14 AS deleted, t.$15 AS originator_id, t.$16 AS last_updated_by_id, t.$17 AS deleted_by_id, t.$18 AS report_type, t.$19 AS data_file, t.$20 AS franchisor_id, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_reports_reportdata.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

