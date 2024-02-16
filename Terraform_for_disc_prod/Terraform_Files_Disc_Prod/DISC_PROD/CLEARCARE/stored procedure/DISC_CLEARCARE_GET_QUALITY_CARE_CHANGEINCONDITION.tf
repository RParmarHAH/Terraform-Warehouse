resource "snowflake_procedure" "DISC_CLEARCARE_GET_QUALITY_CARE_CHANGEINCONDITION" {
	name ="GET_QUALITY_CARE_CHANGEINCONDITION"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ClearCare.GET_quality_care_changeincondition 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.ClearCare.quality_care_changeincondition  (SELECT t.$1 AS id, t.$2 AS created, t.$3 AS updated, t.$4 AS client_id, t.$5 AS description, t.$6 AS due_date, t.$7 AS send_reminder, t.$8 AS status, t.$9 AS deleted, t.$10 AS originator_id, t.$11 AS last_updated_by_id, t.$12 AS deleted_by_id, t.$13 AS caregiver_id, t.$14 AS carelog_id, t.$15 AS agency_id, t.$16 AS franchisor_id, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.stage.AWSAZSTAGEPROD/To_Be_Processed/CLEARCARE/  (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*ClearCare_agencies_quality_care_changeincondition.*[.]csv.gz'') t);

    
    return ''Success'';
END;

 EOT
}

