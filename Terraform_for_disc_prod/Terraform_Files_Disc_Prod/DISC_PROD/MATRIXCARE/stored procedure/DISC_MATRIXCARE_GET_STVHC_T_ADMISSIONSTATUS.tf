resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_ADMISSIONSTATUS" {
	name ="GET_STVHC_T_ADMISSIONSTATUS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_AdmissionStatus 
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
    COPY INTO MatrixCare.HIST_STVHC_T_AdmissionStatus FROM (SELECT t.$1 AS admsts_ID, t.$2 AS admsts_AdmSOCIsRequired, t.$3 AS admsts_AdmDischargeInfoIsRequired, t.$4 AS admsts_CreatedDate, t.$5 AS admsts_CreatedUser, t.$6 AS admsts_ModifiedDate, t.$7 AS admsts_ModifiedUser, t.$8 AS admsts_TS, t.$9 AS admsts_Name, t.$10 AS admsts_ListItemType, t.$11 AS admsts_RptGroupID, t.$12 AS admsts_BranchID, t.$13 AS admsts_OverrideID, t.$14 AS admsts_Active, t.$15 AS admsts_Description, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_AdmissionStatus.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_AdmissionStatus AS WITH curr_v AS (SELECT admsts_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_AdmissionStatus GROUP BY admsts_ID),EXCLUDE_LIST AS ( SELECT DISTINCT ADMSTS_BRANCHID FROM MatrixCare.HIST_STVHC_T_AdmissionStatus br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.ADMSTS_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_AdmissionStatus t INNER JOIN curr_v v ON t.admsts_ID = v.admsts_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.ADMSTS_BRANCHID NOT IN (SELECT ADMSTS_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

