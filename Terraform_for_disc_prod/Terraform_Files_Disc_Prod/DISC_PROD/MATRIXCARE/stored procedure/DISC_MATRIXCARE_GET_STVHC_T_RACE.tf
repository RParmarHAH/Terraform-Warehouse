resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_RACE" {
	name ="GET_STVHC_T_RACE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_Race 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Race FROM (SELECT t.$1 AS rce_ID, t.$2 AS rce_Name, t.$3 AS rce_ListItemType, t.$4 AS rce_RptGroupID, t.$5 AS rce_BranchID, t.$6 AS rce_OverrideID, t.$7 AS rce_Active, t.$8 AS rce_CreatedDate, t.$9 AS rce_CreatedUser, t.$10 AS rce_ModifiedDate, t.$11 AS rce_ModifiedUser, t.$12 AS rce_TS, t.$13 AS rce_Description, t.$14 AS InsertDate, t.$15 AS UpdateDate, t.$16 AS DeletedFlag, t.$17 AS SYS_CHANGE_VERSION, CASE WHEN t.$16 = True THEN ''D'' WHEN t.$14 = t.$15 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$16, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Race.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Race AS WITH curr_v AS (SELECT rce_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Race GROUP BY rce_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT RCE_BRANCHID FROM MatrixCare.HIST_STVHC_T_Race  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.RCE_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Race t INNER JOIN curr_v v ON t.rce_ID = v.rce_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.RCE_BRANCHID,-1) NOT IN (SELECT RCE_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

