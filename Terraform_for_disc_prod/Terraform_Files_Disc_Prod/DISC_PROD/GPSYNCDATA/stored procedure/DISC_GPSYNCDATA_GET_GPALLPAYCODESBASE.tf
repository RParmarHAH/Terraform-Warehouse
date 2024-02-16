resource "snowflake_procedure" "DISC_GPSYNCDATA_GET_GPALLPAYCODESBASE" {
	name ="GET_GPALLPAYCODESBASE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GpSyncData.GET_GpAllPayCodesBase 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.GpSyncData.HIST_GpAllPayCodesBase FROM (SELECT t.$1 AS DB, t.$2 AS PAY_CODE, t.$3 AS DESCRIPTION, t.$4 AS INACTIVE, t.$5 AS PAY_TYPE, t.$6 AS PAY_RATE, t.$7 AS PAY_UNIT, t.$8 AS PAY_PERIOD, t.$9 AS LAST_PAY_DATE, t.$10 AS BASED_ON_CODE, t.$11 AS SYS_CHANGE_VERSION, t.$12 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$12,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_GpAllPayCodesBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.GpAllPayCodesBase AS WITH curr_v AS (SELECT DB, PAY_CODE, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_GpAllPayCodesBase GROUP BY DB, PAY_CODE) SELECT t.* FROM GpSyncData.HIST_GpAllPayCodesBase t INNER JOIN curr_v v ON t.DB = v.DB AND t.PAY_CODE = v.PAY_CODE AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

