resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_CCODEGROUP" {
	name ="GET_CCODEGROUP"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_CCodeGroup 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.CCodeGroup (SELECT t.$1 AS co, t.$2 AS codeGroup, t.$3 AS description, t.$4 AS includeNewCodes, t.$5 AS includeEarnings, t.$6 AS includeDeductions, t.$7 AS includeTaxes, t.$8 AS includeDirDep, t.$9 AS codegroupguid, t.$10 AS lastChange, t.$11 AS lastChangeUser, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_CCodeGroup.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

