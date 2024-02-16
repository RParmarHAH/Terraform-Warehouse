resource "snowflake_procedure" "DISC_EMPEONEDISON_GET_EDEP" {
	name ="GET_EDEP"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.GET_EDep 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonEdison.EDep (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS dependentID, t.$4 AS lastName, t.$5 AS firstName, t.$6 AS middleName, t.$7 AS address1, t.$8 AS address2, t.$9 AS city, t.$10 AS state, t.$11 AS zip, t.$12 AS country, t.$13 AS telephone, t.$14 AS relationship, t.$15 AS sex, t.$16 AS birthDate, t.$17 AS smoker, t.$18 AS ssn, t.$19 AS guidfield, t.$20 AS lastChange, t.$21 AS lastChangeUser, t.$22 AS systemOfRecord, t.$23 AS systemOfRecordIdentifier, t.$24 AS disabled, t.$25 AS student, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/EmpeonEdison_dbo_EDep.csv.gz(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;

 EOT
}

