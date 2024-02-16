resource "snowflake_procedure" "DISC_EMPEONPREFERRED_GET_EMEDICALRECORDS" {
	name ="GET_EMEDICALRECORDS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.GET_EMedicalRecords 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.EMedicalRecords (SELECT t.$1 AS medicalRecordId, t.$2 AS co, t.$3 AS id, t.$4 AS dateCompleted, t.$5 AS expirationDate, t.$6 AS notes, t.$7 AS lastChange, t.$8 AS lastChangeUser, t.$9 AS classCode, t.$10 AS type, t.$11 AS isActive, t.$12 AS provider, t.$13 AS declined, t.$14 AS result, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_EMedicalRecords.*[.]csv.gz'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE EmpeonPreferred.EMedicalRecords AS WITH curr_v AS (SELECT medicalRecordId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmpeonPreferred.EMedicalRecords GROUP BY medicalRecordId) SELECT t.* FROM EmpeonPreferred.EMedicalRecords t INNER JOIN curr_v v ON t.medicalRecordId = v.medicalRecordId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

