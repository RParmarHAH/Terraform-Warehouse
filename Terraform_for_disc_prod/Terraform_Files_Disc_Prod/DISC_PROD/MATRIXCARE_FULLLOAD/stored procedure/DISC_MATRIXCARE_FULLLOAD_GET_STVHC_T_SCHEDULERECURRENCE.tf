resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_SCHEDULERECURRENCE" {
	name ="GET_STVHC_T_SCHEDULERECURRENCE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ScheduleRecurrence 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ScheduleRecurrence FROM (SELECT t.$1 AS schrec_ID, t.$2 AS schrec_Description, t.$3 AS schrec_OccurrenceDuration, t.$4 AS schrec_OccurrenceStartTime, t.$5 AS schrec_PatternDayOfMonth, t.$6 AS schrec_PatternDaysOfWeek, t.$7 AS schrec_PatternFrequency, t.$8 AS schrec_PatternInterval, t.$9 AS schrec_PatternMonthOfYear, t.$10 AS schrec_PatternOccurrenceOfDayInMonth, t.$11 AS schrec_PatternType, t.$12 AS schrec_RangeEndDate, t.$13 AS schrec_RangeLimit, t.$14 AS schrec_RangeMaxOccurrences, t.$15 AS schrec_RangeMaxFrequency, t.$16 AS schrec_RangeStartDate, t.$17 AS schrec_RootAppointment, t.$18 AS schrec_OriginalStartDateTime, t.$19 AS schrec_OriginatedFromID, t.$20 AS schrec_OriginType, t.$21 AS schrec_TimeZoneID, t.$22 AS schrec_CreatedDate, t.$23 AS schrec_CreatedUser, t.$24 AS schrec_ModifiedDate, t.$25 AS schrec_ModifiedUser, t.$26 AS schrec_TS, t.$27 AS schrec_FirstDayOfWeek, t.$28 AS schrec_LastGenDate, t.$29 AS InsertDate, t.$30 AS UpdateDate, t.$31 AS DeletedFlag, t.$32 AS SYS_CHANGE_VERSION, CASE WHEN t.$31 = True THEN ''D'' WHEN t.$29 = t.$30 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$31, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ScheduleRecurrence.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ScheduleRecurrence AS WITH curr_v AS (SELECT schrec_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ScheduleRecurrence GROUP BY schrec_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ScheduleRecurrence t INNER JOIN curr_v v ON t.schrec_ID = v.schrec_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

