resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_SCHEDULESTASKS" {
	name ="GET_STVHC_T_SCHEDULESTASKS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_SchedulesTasks 
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
    COPY INTO MatrixCare.HIST_STVHC_T_SchedulesTasks FROM (SELECT t.$1 AS schtsk_ID, t.$2 AS schtsk_SchID, t.$3 AS schtsk_TaskID, t.$4 AS schtsk_Notes, t.$5 AS schtsk_FromTelephony, t.$6 AS schtsk_Active, t.$7 AS schtsk_CreatedDate, t.$8 AS schtsk_CreatedUser, t.$9 AS schtsk_ModifiedDate, t.$10 AS schtsk_ModifiedUser, t.$11 AS schtsk_TS, t.$12 AS schtsk_NumericValue, t.$13 AS InsertDate, t.$14 AS UpdateDate, t.$15 AS DeletedFlag, t.$16 AS SYS_CHANGE_VERSION, CASE WHEN t.$15 = True THEN ''D'' WHEN t.$13 = t.$14 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$15, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_SchedulesTasks.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_SchedulesTasks AS WITH curr_v AS (SELECT schtsk_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_SchedulesTasks GROUP BY schtsk_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_SchedulesTasks t INNER JOIN curr_v v ON t.schtsk_ID = v.schtsk_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

