resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_REFERRALFACILITIESBRANCHES" {
	name ="GET_STVHC_T_REFERRALFACILITIESBRANCHES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ReferralFacilitiesBranches 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ReferralFacilitiesBranches FROM (SELECT t.$1 AS reffacbr_ID, t.$2 AS reffacbr_ReferralFacilitiesID, t.$3 AS reffacbr_BranchID, t.$4 AS reffacbr_CreatedUser, t.$5 AS reffacbr_CreatedDate, t.$6 AS reffacbr_ModifiedUser, t.$7 AS reffacbr_ModifiedDate, t.$8 AS reffacbr_TS, t.$9 AS InsertDate, t.$10 AS UpdateDate, t.$11 AS DeletedFlag, t.$12 AS SYS_CHANGE_VERSION, CASE WHEN t.$11 = True THEN ''D'' WHEN t.$9 = t.$10 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$11, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ReferralFacilitiesBranches.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ReferralFacilitiesBranches AS WITH curr_v AS (SELECT reffacbr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ReferralFacilitiesBranches GROUP BY reffacbr_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT REFFACBR_BRANCHID FROM MatrixCare.HIST_STVHC_T_ReferralFacilitiesBranches  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.REFFACBR_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ReferralFacilitiesBranches t INNER JOIN curr_v v ON t.reffacbr_ID = v.reffacbr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.REFFACBR_BRANCHID NOT IN (SELECT REFFACBR_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

