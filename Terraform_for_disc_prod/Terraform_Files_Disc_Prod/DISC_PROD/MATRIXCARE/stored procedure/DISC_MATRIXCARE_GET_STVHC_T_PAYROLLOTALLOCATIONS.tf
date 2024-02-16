resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PAYROLLOTALLOCATIONS" {
	name ="GET_STVHC_T_PAYROLLOTALLOCATIONS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PayrollOTAllocations 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollOTAllocations FROM (SELECT t.$1 AS ota_ID, t.$2 AS ota_PeriodShiftID, t.$3 AS ota_AllocationStartTime, t.$4 AS ota_AllocationEndTime, t.$5 AS ota_RuleID, t.$6 AS ota_Multiplier, t.$7 AS ota_TotalAllocatedMinutes, t.$8 AS ota_TotalAllocatedOTAmount, t.$9 AS ota_DraftID, t.$10 AS ota_RuleOTTypeId, t.$11 AS ota_LegacyID, t.$12 AS ota_Seq, t.$13 AS ota_ThresholdMinutes, t.$14 AS ota_OTPayrollDetailsID, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollOTAllocations.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollOTAllocations AS WITH curr_v AS (SELECT ota_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollOTAllocations GROUP BY ota_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollOTAllocations t INNER JOIN curr_v v ON t.ota_ID = v.ota_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

