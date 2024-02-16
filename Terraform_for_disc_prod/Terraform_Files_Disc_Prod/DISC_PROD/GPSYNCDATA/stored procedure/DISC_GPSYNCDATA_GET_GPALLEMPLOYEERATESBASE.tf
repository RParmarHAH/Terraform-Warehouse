resource "snowflake_procedure" "DISC_GPSYNCDATA_GET_GPALLEMPLOYEERATESBASE" {
	name ="GET_GPALLEMPLOYEERATESBASE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GpSyncData.GET_GpAllEmployeeRatesBase 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.GpSyncData.HIST_GpAllEmployeeRatesBase FROM (SELECT t.$1 AS DB, t.$2 AS EMPLOYEE_ID, t.$3 AS PAY_CODE, t.$4 AS PAY_RATE, t.$5 AS INACTIVE, t.$6 AS LAST_PAID_DATE, t.$7 AS SYS_CHANGE_VERSION, t.$8 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$8,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_GpAllEmployeeRatesBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.GpAllEmployeeRatesBase AS WITH curr_v AS (SELECT DB, EMPLOYEE_ID, PAY_CODE, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_GpAllEmployeeRatesBase GROUP BY DB, EMPLOYEE_ID, PAY_CODE) SELECT t.* FROM GpSyncData.HIST_GpAllEmployeeRatesBase t INNER JOIN curr_v v ON t.DB = v.DB AND t.EMPLOYEE_ID = v.EMPLOYEE_ID AND t.PAY_CODE = v.PAY_CODE AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

