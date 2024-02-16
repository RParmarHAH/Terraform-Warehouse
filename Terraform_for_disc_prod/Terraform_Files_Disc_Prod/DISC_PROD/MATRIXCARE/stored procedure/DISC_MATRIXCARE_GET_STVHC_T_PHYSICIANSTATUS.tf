resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PHYSICIANSTATUS" {
	name ="GET_STVHC_T_PHYSICIANSTATUS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PhysicianStatus 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PhysicianStatus FROM (SELECT t.$1 AS phys_ID, t.$2 AS phys_Name, t.$3 AS phys_ShowOrHide, t.$4 AS phys_ListItemType, t.$5 AS phys_RptGroupID, t.$6 AS phys_BranchID, t.$7 AS phys_OverrideID, t.$8 AS phys_Active, t.$9 AS phys_CreatedDate, t.$10 AS phys_CreatedUser, t.$11 AS phys_ModifiedDate, t.$12 AS phys_ModifiedUser, t.$13 AS phys_TS, t.$14 AS phys_Description, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PhysicianStatus.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PhysicianStatus AS WITH curr_v AS (SELECT phys_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PhysicianStatus GROUP BY phys_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PHYS_BRANCHID FROM MatrixCare.HIST_STVHC_T_PhysicianStatus  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PHYS_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PhysicianStatus t INNER JOIN curr_v v ON t.phys_ID = v.phys_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.PHYS_BRANCHID,-1) NOT IN (SELECT PHYS_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

