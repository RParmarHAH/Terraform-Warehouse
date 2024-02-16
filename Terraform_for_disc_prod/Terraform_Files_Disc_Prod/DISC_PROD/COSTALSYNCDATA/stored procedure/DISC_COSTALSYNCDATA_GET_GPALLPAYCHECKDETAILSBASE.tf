resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_GPALLPAYCHECKDETAILSBASE" {
	name ="GET_GPALLPAYCHECKDETAILSBASE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_GpAllPayCheckDetailsBase 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_GpAllPayCheckDetailsBase FROM (SELECT t.$1 AS lineId, t.$2 AS DB, t.$3 AS AuditTrailNumber, t.$4 AS EmployeeId, t.$5 AS CheckNumber, t.$6 AS CheckDate, t.$7 AS Department, t.$8 AS PayCodeType, t.$9 AS PayCode, t.$10 AS JobTitleCode, t.$11 AS PayPeriodBeginDate, t.$12 AS PayPeriodEndDate, t.$13 AS Units, t.$14 AS Rate, t.$15 AS Amount, t.$16 AS StateCode, t.$17 AS SutaState, t.$18 AS EmployeeClass, t.$19 AS GpRowId, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_GpAllPayCheckDetailsBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GpAllPayCheckDetailsBase AS WITH curr_v AS (SELECT lineId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_GpAllPayCheckDetailsBase GROUP BY lineId) SELECT t.* FROM CostalSyncData.HIST_GpAllPayCheckDetailsBase t INNER JOIN curr_v v ON t.lineId = v.lineId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

