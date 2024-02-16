resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_REFERRALJOIN" {
	name ="GET_STVHC_T_REFERRALJOIN"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ReferralJoin 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ReferralJoin FROM (SELECT t.$1 AS refjoin_ID, t.$2 AS refjoin_ReferralByID, t.$3 AS refjoin_ReferralFacilityID, t.$4 AS refjoin_Notes, t.$5 AS refjoin_CreatedDate, t.$6 AS refjoin_CreatedUser, t.$7 AS refjoin_ModifiedDate, t.$8 AS refjoin_ModifiedUser, t.$9 AS refjoin_TS, t.$10 AS refjoin_StartDate, t.$11 AS refjoin_EndDate, t.$12 AS refjoin_ReferralRatingID, t.$13 AS refjoin_BranchID, t.$14 AS InsertDate, t.$15 AS UpdateDate, t.$16 AS DeletedFlag, t.$17 AS SYS_CHANGE_VERSION, CASE WHEN t.$16 = True THEN ''D'' WHEN t.$14 = t.$15 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$16, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ReferralJoin.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ReferralJoin AS WITH curr_v AS (SELECT refjoin_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ReferralJoin GROUP BY refjoin_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT REFJOIN_BRANCHID FROM MatrixCare.HIST_STVHC_T_ReferralJoin  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.REFJOIN_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ReferralJoin t INNER JOIN curr_v v ON t.refjoin_ID = v.refjoin_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.REFJOIN_BRANCHID NOT IN (SELECT REFJOIN_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

