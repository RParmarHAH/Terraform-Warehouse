resource "snowflake_procedure" "DISC_ASR_GET_ASR_EMPLOYEE_DETAILS" {
	name ="GET_ASR_EMPLOYEE_DETAILS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_EMPLOYEE_DETAILS 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_EMPLOYEE_DETAILS FROM (SELECT A.$1 AS EMPLOYEEID, A.$2 AS PROPERTY_NAME, A.$3 AS PARAMVALUE, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_EmployeeDetails(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_EMPLOYEE_DETAILS AS WITH curr_v AS (SELECT EMPLOYEEID, PROPERTY_NAME, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_EMPLOYEE_DETAILS GROUP BY EMPLOYEEID, PROPERTY_NAME) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_EMPLOYEE_DETAILS t INNER JOIN curr_v v ON t.EMPLOYEEID = v.EMPLOYEEID AND t.PROPERTY_NAME = v.PROPERTY_NAME AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

