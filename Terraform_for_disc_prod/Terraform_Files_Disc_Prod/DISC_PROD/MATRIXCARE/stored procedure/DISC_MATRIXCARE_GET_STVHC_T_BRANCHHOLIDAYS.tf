resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_BRANCHHOLIDAYS" {
	name ="GET_STVHC_T_BRANCHHOLIDAYS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_BranchHolidays 
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
    COPY INTO MatrixCare.HIST_STVHC_T_BranchHolidays FROM (SELECT t.$1 AS brhol_ID, t.$2 AS brhol_BranchID, t.$3 AS brhol_Name, t.$4 AS brhol_StartDate, t.$5 AS brhol_EndTime, t.$6 AS brhol_Multiplier, t.$7 AS brhol_Addition, t.$8 AS brhol_CreatedDate, t.$9 AS brhol_CreatedUser, t.$10 AS brhol_ModifiedDate, t.$11 AS brhol_ModifiedUser, t.$12 AS brhol_TS, t.$13 AS brhol_PayMultiplier, t.$14 AS brhol_PayAddition, t.$15 AS brhol_PayVisitAddition, t.$16 AS brhol_BillVisitAddition, t.$17 AS InsertDate, t.$18 AS UpdateDate, t.$19 AS DeletedFlag, t.$20 AS SYS_CHANGE_VERSION, CASE WHEN t.$19 = True THEN ''D'' WHEN t.$17 = t.$18 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$19, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_BranchHolidays.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_BranchHolidays AS WITH curr_v AS (SELECT brhol_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_BranchHolidays GROUP BY brhol_ID),EXCLUDE_LIST AS ( SELECT DISTINCT BRHOL_BRANCHID FROM MatrixCare.HIST_STVHC_T_BranchHolidays br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.BRHOL_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_BranchHolidays t INNER JOIN curr_v v ON t.brhol_ID = v.brhol_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.BRHOL_BRANCHID NOT IN (SELECT BRHOL_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

