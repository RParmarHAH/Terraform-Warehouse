resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_EDEPT" {
	name ="GET_EDEPT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_EDept 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.EDept (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS percentage, t.$4 AS ecode, t.$5 AS cc1, t.$6 AS cc2, t.$7 AS cc3, t.$8 AS cc4, t.$9 AS cc5, t.$10 AS jobCode, t.$11 AS startDate, t.$12 AS endDate, t.$13 AS guidfield, t.$14 AS lastChange, t.$15 AS lastChangeUser, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EDept.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

