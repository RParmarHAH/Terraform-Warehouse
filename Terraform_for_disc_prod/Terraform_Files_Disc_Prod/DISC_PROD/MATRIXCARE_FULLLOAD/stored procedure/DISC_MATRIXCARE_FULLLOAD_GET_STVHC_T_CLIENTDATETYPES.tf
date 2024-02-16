resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_CLIENTDATETYPES" {
	name ="GET_STVHC_T_CLIENTDATETYPES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ClientDateTypes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ClientDateTypes FROM (SELECT t.$1 AS clidttyp_ID, t.$2 AS clidttyp_Name, t.$3 AS clidttyp_Warn, t.$4 AS clidttyp_Active, t.$5 AS clidttyp_CreatedDate, t.$6 AS clidttyp_CreatedUser, t.$7 AS clidttyp_ModifiedDate, t.$8 AS clidttyp_ModifiedUser, t.$9 AS clidttyp_TS, t.$10 AS clidttyp_ListItemType, t.$11 AS clidttyp_RptGroupID, t.$12 AS clidttyp_BranchID, t.$13 AS clidttyp_OverrideID, t.$14 AS clidttyp_Description, t.$15 AS clidttyp_ReminderItem, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientDateTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientDateTypes AS WITH curr_v AS (SELECT clidttyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientDateTypes GROUP BY clidttyp_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT CLIDTTYP_BRANCHID FROM MatrixCare.HIST_STVHC_T_ClientDateTypes br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CLIDTTYP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientDateTypes t INNER JOIN curr_v v ON t.clidttyp_ID = v.clidttyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CLIDTTYP_BRANCHID NOT IN (SELECT CLIDTTYP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

