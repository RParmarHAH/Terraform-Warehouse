resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_CLIENTDATESTATUS" {
	name ="GET_STVHC_T_CLIENTDATESTATUS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ClientDateStatus 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ClientDateStatus FROM (SELECT t.$1 AS clidstat_ID, t.$2 AS clidstat_Name, t.$3 AS clidstat_Active, t.$4 AS clidstat_CreatedDate, t.$5 AS clidstat_CreatedUser, t.$6 AS clidstat_ModifiedDate, t.$7 AS clidstat_ModifiedUser, t.$8 AS clidstat_TS, t.$9 AS clidstat_ListItemType, t.$10 AS clidstat_RptGroupID, t.$11 AS clidstat_BranchID, t.$12 AS clidstat_OverrideID, t.$13 AS clidstat_Description, t.$14 AS InsertDate, t.$15 AS UpdateDate, t.$16 AS DeletedFlag, t.$17 AS SYS_CHANGE_VERSION, CASE WHEN t.$16 = True THEN ''D'' WHEN t.$14 = t.$15 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$16, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientDateStatus.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientDateStatus AS WITH curr_v AS (SELECT clidstat_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientDateStatus GROUP BY clidstat_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT CLIDSTAT_BRANCHID FROM MatrixCare.HIST_STVHC_T_ClientDateStatus br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CLIDSTAT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientDateStatus t INNER JOIN curr_v v ON t.clidstat_ID = v.clidstat_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.CLIDSTAT_BRANCHID,-1) NOT IN (SELECT CLIDSTAT_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

