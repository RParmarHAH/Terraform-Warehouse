resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_REFERRALFACILITYDOCUMENTSHARELEVELS" {
	name ="GET_STVHC_T_REFERRALFACILITYDOCUMENTSHARELEVELS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ReferralFacilityDocumentShareLevels 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ReferralFacilityDocumentShareLevels FROM (SELECT t.$1 AS reffacdocslvl_ID, t.$2 AS reffacdocslvl_Name, t.$3 AS reffacdocslvl_PermissionName, t.$4 AS reffacdocslvl_Active, t.$5 AS reffacdocslvl_CreatedDate, t.$6 AS reffacdocslvl_CreatedUser, t.$7 AS reffacdocslvl_ModifiedDate, t.$8 AS reffacdocslvl_ModifiedUser, t.$9 AS reffacdocslvl_TS, t.$10 AS reffacdocslvl_ListItemType, t.$11 AS reffacdocslvl_RptGroupID, t.$12 AS reffacdocslvl_BranchID, t.$13 AS reffacdocslvl_OverrideID, t.$14 AS reffacdocslvl_Description, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ReferralFacilityDocumentShareLevels.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ReferralFacilityDocumentShareLevels AS WITH curr_v AS (SELECT reffacdocslvl_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ReferralFacilityDocumentShareLevels GROUP BY reffacdocslvl_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT REFFACDOCSLVL_BRANCHID FROM MatrixCare.HIST_STVHC_T_ReferralFacilityDocumentShareLevels  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.REFFACDOCSLVL_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ReferralFacilityDocumentShareLevels t INNER JOIN curr_v v ON t.reffacdocslvl_ID = v.reffacdocslvl_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.REFFACDOCSLVL_BRANCHID,-1) NOT IN (SELECT REFFACDOCSLVL_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

