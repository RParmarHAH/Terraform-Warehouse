resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_ACTIVITYENTITIES" {
	name ="GET_STVHC_T_ACTIVITYENTITIES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ActivityEntities 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ActivityEntities FROM (SELECT t.$1 AS actent_ID, t.$2 AS actent_RecordType, t.$3 AS actent_RecordID, t.$4 AS actent_ActivitiesID, t.$5 AS actent_Notify, t.$6 AS actent_Print, t.$7 AS actent_Dismiss, t.$8 AS actent_ReminderDismissedBy, t.$9 AS actent_ReminderDismissDate, t.$10 AS actent_FollowupDate, t.$11 AS actent_CreatedDate, t.$12 AS actent_CreatedUser, t.$13 AS actent_ModifiedDate, t.$14 AS actent_ModifiedUser, t.$15 AS actent_TS, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ActivityEntities.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ActivityEntities AS WITH curr_v AS (SELECT actent_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ActivityEntities GROUP BY actent_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ActivityEntities t INNER JOIN curr_v v ON t.actent_ID = v.actent_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

