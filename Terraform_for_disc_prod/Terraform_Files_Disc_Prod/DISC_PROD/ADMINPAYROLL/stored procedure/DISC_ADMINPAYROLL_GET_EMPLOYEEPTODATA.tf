resource "snowflake_procedure" "DISC_ADMINPAYROLL_GET_EMPLOYEEPTODATA" {
	name ="GET_EMPLOYEEPTODATA"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADMINPAYROLL"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.AdminPayroll.GET_EmployeePtoData 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-12-15		Komal Dhokai			Updated TargetSQL
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_${var.SF_ENVIRONMENT}.AdminPayroll.HIST_EmployeePtoData FROM (SELECT t.$1 AS Key, t.$2 AS CompanyCode, t.$3 AS EmployeeId, t.$4 AS TimeStamp, t.$5 AS DataJson, t.$6 AS SYS_CHANGE_VERSION, t.$7 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$7,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/ADMINPAYROLL/ (PATTERN => ''.*AdminPayroll_pto_EmployeePtoData.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.AdminPayroll.EmployeePtoData AS WITH curr_v AS (SELECT Key, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.AdminPayroll.HIST_EmployeePtoData GROUP BY Key) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.AdminPayroll.HIST_EmployeePtoData t INNER JOIN curr_v v ON t.Key = v.Key AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

