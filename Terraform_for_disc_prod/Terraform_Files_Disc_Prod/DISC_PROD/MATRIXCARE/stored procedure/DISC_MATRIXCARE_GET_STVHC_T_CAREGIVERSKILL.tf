resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_CAREGIVERSKILL" {
	name ="GET_STVHC_T_CAREGIVERSKILL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_CaregiverSkill 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverSkill FROM (SELECT t.$1 AS carsk_ID, t.$2 AS carsk_CaregiverID, t.$3 AS carsk_SkillGroupID, t.$4 AS carsk_CreatedDate, t.$5 AS carsk_CreatedUser, t.$6 AS carsk_ModifiedDate, t.$7 AS carsk_ModifiedUser, t.$8 AS carsk_TS, t.$9 AS InsertDate, t.$10 AS UpdateDate, t.$11 AS DeletedFlag, t.$12 AS SYS_CHANGE_VERSION, CASE WHEN t.$11 = True THEN ''D'' WHEN t.$9 = t.$10 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$11, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverSkill.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverSkill AS WITH curr_v AS (SELECT carsk_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverSkill GROUP BY carsk_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverSkill t INNER JOIN curr_v v ON t.carsk_ID = v.carsk_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

