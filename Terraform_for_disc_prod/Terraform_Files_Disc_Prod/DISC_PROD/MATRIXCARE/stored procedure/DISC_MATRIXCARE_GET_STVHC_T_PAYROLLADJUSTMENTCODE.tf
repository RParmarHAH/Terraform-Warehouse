resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PAYROLLADJUSTMENTCODE" {
	name ="GET_STVHC_T_PAYROLLADJUSTMENTCODE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PayrollAdjustmentCode 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollAdjustmentCode FROM (SELECT t.$1 AS prollac_ID, t.$2 AS prollac_Active, t.$3 AS prollac_CreatedDate, t.$4 AS prollac_CreatedUser, t.$5 AS prollac_ModifiedDate, t.$6 AS prollac_ModifiedUser, t.$7 AS prollac_TS, t.$8 AS prollac_Name, t.$9 AS prollac_ListItemType, t.$10 AS prollac_RptGroupID, t.$11 AS prollac_BranchID, t.$12 AS prollac_Description, t.$13 AS prollac_OverrideID, t.$14 AS prollac_PayrollCode, t.$15 AS prollac_DeductEarn, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollAdjustmentCode.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollAdjustmentCode AS WITH curr_v AS (SELECT prollac_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollAdjustmentCode GROUP BY prollac_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PROLLAC_BRANCHID FROM MatrixCare.HIST_STVHC_T_PayrollAdjustmentCode  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PROLLAC_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollAdjustmentCode t INNER JOIN curr_v v ON t.prollac_ID = v.prollac_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PROLLAC_BRANCHID NOT IN (SELECT PROLLAC_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

