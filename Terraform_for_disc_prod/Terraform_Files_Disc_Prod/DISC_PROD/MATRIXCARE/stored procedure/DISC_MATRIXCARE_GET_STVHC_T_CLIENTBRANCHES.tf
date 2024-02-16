resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_CLIENTBRANCHES" {
	name ="GET_STVHC_T_CLIENTBRANCHES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ClientBranches 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ClientBranches FROM (SELECT t.$1 AS clibr_ID, t.$2 AS clibr_ClientID, t.$3 AS clibr_Branch_ID, t.$4 AS clibr_CreatedUser, t.$5 AS clibr_CreatedDate, t.$6 AS clibr_ModifiedUser, t.$7 AS clibr_ModifiedDate, t.$8 AS clibr_TS, t.$9 AS InsertDate, t.$10 AS UpdateDate, t.$11 AS DeletedFlag, t.$12 AS SYS_CHANGE_VERSION, CASE WHEN t.$11 = True THEN ''D'' WHEN t.$9 = t.$10 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$11, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientBranches.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientBranches AS WITH curr_v AS (SELECT clibr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientBranches GROUP BY clibr_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT CLIBR_BRANCH_ID FROM MatrixCare.HIST_STVHC_T_ClientBranches br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CLIBR_BRANCH_ID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientBranches t INNER JOIN curr_v v ON t.clibr_ID = v.clibr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CLIBR_BRANCH_ID NOT IN (SELECT CLIBR_BRANCH_ID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

