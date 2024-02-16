resource "snowflake_procedure" "DISC_AXXESS_GET_AXXESS_EMPLOYEEINFO" {
	name ="GET_AXXESS_EMPLOYEEINFO"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AXXESS.GET_AXXESS_EMPLOYEEINFO 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_EMPLOYEEINFO ( SELECT EI.$1 AS EMPLOYEE_ID, EI.$2 AS SSN, EI.$3 AS FIRST_NAME, EI.$4 AS LAST_NAME,EI.$5 AS HIRE_DATE,EI.$6 AS TERMINATION_DATE, EI.$7 AS GENDER, EI.$8 AS DATE_OF_BIRTH, EI.$9 AS EMPLOYMENT_TYPE, EI.$10 AS TITLE_TYPE, EI.$11 AS ACTIVE_STATUS, EI.$12 AS ADDRESS_LINE_1, EI.$13 AS ADDRESS_CITY, EI.$14 AS ADDRESS_ZIPCODE, EI.$15 AS ADDRESS_STATECODE, EI.$16 AS WORKING_LOCATION_STATECODE, EI.$17 AS IS_CASE_MANAGER, EI.$18 AS COMMENTS, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/EmployeeInfo(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) EI );

    return ''Success'';
END;

 EOT
}

