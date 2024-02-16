resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_ACTIVITYCATEGORIES" {
	name ="GET_STVHC_T_ACTIVITYCATEGORIES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ActivityCategories 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ActivityCategories FROM (SELECT t.$1 AS actcat_ID, t.$2 AS actcat_Active, t.$3 AS actcat_CreatedDate, t.$4 AS actcat_CreatedUser, t.$5 AS actcat_ModifiedDate, t.$6 AS actcat_ModifiedUser, t.$7 AS actcat_TS, t.$8 AS actcat_Name, t.$9 AS actcat_ListItemType, t.$10 AS actcat_RptGroupID, t.$11 AS actcat_BranchID, t.$12 AS actcat_OverrideID, t.$13 AS actcat_Description, t.$14 AS actcat_DisplayOnCalendar, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ActivityCategories.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ActivityCategories AS WITH curr_v AS (SELECT actcat_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ActivityCategories GROUP BY actcat_ID),EXCLUDE_LIST AS ( SELECT DISTINCT ACTCAT_BRANCHID FROM MatrixCare.HIST_STVHC_T_ActivityCategories br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = br.ACTCAT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ActivityCategories t INNER JOIN curr_v v ON t.actcat_ID = v.actcat_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.ACTCAT_BRANCHID NOT IN (SELECT ACTCAT_BRANCHID FROM EXCLUDE_LIST) ; 

    return ''Success'';
END;

 EOT
}

