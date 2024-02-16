resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PAYROLLADJUSTMENT" {
	name ="GET_STVHC_T_PAYROLLADJUSTMENT"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PayrollAdjustment 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollAdjustment FROM (SELECT t.$1 AS prolla_ID, t.$2 AS prolla_BranchID, t.$3 AS prolla_ScheduleID, t.$4 AS prolla_PayrollAdjCode, t.$5 AS prolla_PayDate, t.$6 AS prolla_Unit, t.$7 AS prolla_Rate, t.$8 AS prolla_Status, t.$9 AS prolla_RecalcOvertime, t.$10 AS prolla_Notes, t.$11 AS prolla_CreatedDate, t.$12 AS prolla_CreatedUser, t.$13 AS prolla_ModifiedDate, t.$14 AS prolla_ModifiedUser, t.$15 AS prolla_TS, t.$16 AS prolla_OriginalPayDate, t.$17 AS InsertDate, t.$18 AS UpdateDate, t.$19 AS DeletedFlag, t.$20 AS SYS_CHANGE_VERSION, CASE WHEN t.$19 = True THEN ''D'' WHEN t.$17 = t.$18 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$19, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollAdjustment[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollAdjustment AS WITH curr_v AS (SELECT prolla_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollAdjustment GROUP BY prolla_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PROLLA_BRANCHID FROM MatrixCare.HIST_STVHC_T_PayrollAdjustment  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PROLLA_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollAdjustment t INNER JOIN curr_v v ON t.prolla_ID = v.prolla_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PROLLA_BRANCHID NOT IN (SELECT PROLLA_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

