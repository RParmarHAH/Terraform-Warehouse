resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_DIAGNOSIS" {
	name ="GET_STVHC_T_DIAGNOSIS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_Diagnosis 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Diagnosis FROM (SELECT t.$1 AS diag_ID, t.$2 AS diag_Code, t.$3 AS diag_Description, t.$4 AS diag_DiagnosisCategory, t.$5 AS diag_EffectiveStartDate, t.$6 AS diag_EffectiveEndDate, t.$7 AS diag_SurgicalProcedure, t.$8 AS diag_CreatedDate, t.$9 AS diag_CreatedUser, t.$10 AS diag_ModifiedDate, t.$11 AS diag_ModifiedUser, t.$12 AS diag_TS, t.$13 AS diag_DiagnosisID, t.$14 AS diag_SurgicalProcedureID, t.$15 AS diag_LongDescription, t.$16 AS diag_Version, t.$17 AS diag_Active, t.$18 AS InsertDate, t.$19 AS UpdateDate, t.$20 AS DeletedFlag, t.$21 AS SYS_CHANGE_VERSION, CASE WHEN t.$20 = True THEN ''D'' WHEN t.$18 = t.$19 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$20, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Diagnosis[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Diagnosis AS WITH curr_v AS (SELECT diag_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Diagnosis GROUP BY diag_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_Diagnosis t INNER JOIN curr_v v ON t.diag_ID = v.diag_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

