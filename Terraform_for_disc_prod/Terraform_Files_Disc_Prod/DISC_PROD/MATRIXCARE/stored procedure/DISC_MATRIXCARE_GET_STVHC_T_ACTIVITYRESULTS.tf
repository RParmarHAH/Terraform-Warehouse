resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_ACTIVITYRESULTS" {
	name ="GET_STVHC_T_ACTIVITYRESULTS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ActivityResults 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ActivityResults FROM (SELECT t.$1 AS actrslt_ID, t.$2 AS actrslt_ActivityCategoryID, t.$3 AS actrslt_Active, t.$4 AS actrslt_CreatedDate, t.$5 AS actrslt_CreatedUser, t.$6 AS actrslt_ModifiedDate, t.$7 AS actrslt_ModifiedUser, t.$8 AS actrslt_TS, t.$9 AS actrslt_Name, t.$10 AS actrslt_ListItemType, t.$11 AS actrslt_RptGroupID, t.$12 AS actrslt_BranchID, t.$13 AS actrslt_OverrideID, t.$14 AS actrslt_Description, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ActivityResults.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ActivityResults AS WITH curr_v AS (SELECT actrslt_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ActivityResults GROUP BY actrslt_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT ACTRSLT_BRANCHID FROM MatrixCare.HIST_STVHC_T_ActivityResults br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = br.ACTRSLT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ActivityResults t INNER JOIN curr_v v ON t.actrslt_ID = v.actrslt_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.ACTRSLT_BRANCHID NOT IN (SELECT ACTRSLT_BRANCHID FROM EXCLUDE_LIST);

    return ''Success'';
END;

 EOT
}

