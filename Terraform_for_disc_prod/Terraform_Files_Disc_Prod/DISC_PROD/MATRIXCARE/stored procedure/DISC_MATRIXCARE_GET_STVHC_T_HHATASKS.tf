resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_HHATASKS" {
	name ="GET_STVHC_T_HHATASKS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_HHATasks 
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
    COPY INTO MatrixCare.HIST_STVHC_T_HHATasks FROM (SELECT t.$1 AS hhat_ID, t.$2 AS hhat_hhac_ID, t.$3 AS hhat_Name, t.$4 AS hhat_Active, t.$5 AS hhat_CreatedDate, t.$6 AS hhat_CreatedUser, t.$7 AS hhat_ModifiedDate, t.$8 AS hhat_ModifiedUser, t.$9 AS hhat_TS, t.$10 AS hhat_ListItemType, t.$11 AS hhat_BranchID, t.$12 AS hhat_RptGroupID, t.$13 AS hhat_OverrideID, t.$14 AS hhat_Description, t.$15 AS hhat_TelephonyTaskID, t.$16 AS hhat_Sequence, t.$17 AS hhat_TelephonyEnabled, t.$18 AS hhat_MeasureType, t.$19 AS hhat_UnitType, t.$20 AS InsertDate, t.$21 AS UpdateDate, t.$22 AS DeletedFlag, t.$23 AS SYS_CHANGE_VERSION, CASE WHEN t.$22 = True THEN ''D'' WHEN t.$20 = t.$21 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$22, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_HHATasks.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_HHATasks AS WITH curr_v AS (SELECT hhat_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_HHATasks GROUP BY hhat_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT HHAT_BRANCHID FROM MatrixCare.HIST_STVHC_T_HHATasks br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.HHAT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_HHATasks t INNER JOIN curr_v v ON t.hhat_ID = v.hhat_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.HHAT_BRANCHID NOT IN (SELECT HHAT_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

