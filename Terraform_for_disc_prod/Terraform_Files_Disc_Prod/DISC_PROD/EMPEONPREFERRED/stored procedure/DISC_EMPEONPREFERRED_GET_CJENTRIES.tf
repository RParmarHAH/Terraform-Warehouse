resource "snowflake_procedure" "DISC_EMPEONPREFERRED_GET_CJENTRIES" {
	name ="GET_CJENTRIES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.GET_CJEntries 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.CJEntries (SELECT t.$1 AS co, t.$2 AS process, t.$3 AS entryDate, t.$4 AS gl1, t.$5 AS gl2, t.$6 AS gl3, t.$7 AS gl4, t.$8 AS gl5, t.$9 AS gl6, t.$10 AS cd, t.$11 AS det, t.$12 AS detCode, t.$13 AS amount, t.$14 AS hours, t.$15 AS guidfield, t.$16 AS lastChange, t.$17 AS calendarId, t.$18 AS lastChangeUser, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_CJEntries.*[.]csv.gz'')T);

    
    return ''Success'';
END;

 EOT
}

