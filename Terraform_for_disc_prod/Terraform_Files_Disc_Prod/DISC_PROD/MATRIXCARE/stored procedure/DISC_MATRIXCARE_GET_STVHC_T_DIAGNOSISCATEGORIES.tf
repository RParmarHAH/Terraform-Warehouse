resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_DIAGNOSISCATEGORIES" {
	name ="GET_STVHC_T_DIAGNOSISCATEGORIES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_DiagnosisCategories 
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
    COPY INTO MatrixCare.HIST_STVHC_T_DiagnosisCategories FROM (SELECT t.$1 AS diagc_ID, t.$2 AS diagc_Name, t.$3 AS diagc_Active, t.$4 AS diagc_CreatedDate, t.$5 AS diagc_CreatedUser, t.$6 AS diagc_ModifiedDate, t.$7 AS diagc_ModifiedUser, t.$8 AS diagc_TS, t.$9 AS diagc_Description, t.$10 AS InsertDate, t.$11 AS UpdateDate, t.$12 AS DeletedFlag, t.$13 AS SYS_CHANGE_VERSION, CASE WHEN t.$12 = True THEN ''D'' WHEN t.$10 = t.$11 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$12, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_DiagnosisCategories.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_DiagnosisCategories AS WITH curr_v AS (SELECT diagc_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_DiagnosisCategories GROUP BY diagc_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_DiagnosisCategories t INNER JOIN curr_v v ON t.diagc_ID = v.diagc_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

