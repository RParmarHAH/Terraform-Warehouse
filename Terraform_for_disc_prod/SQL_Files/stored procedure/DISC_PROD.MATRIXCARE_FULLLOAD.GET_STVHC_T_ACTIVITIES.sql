CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE_FULLLOAD.GET_STVHC_T_ACTIVITIES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_Activities 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Activities FROM (SELECT t.$1 AS act_ID, t.$2 AS act_BranchID, t.$3 AS act_StartTime, t.$4 AS act_EndTime, t.$5 AS act_ActivityCategoryID, t.$6 AS act_ActivityTypeID, t.$7 AS act_ActivityResultID, t.$8 AS act_Subject, t.$9 AS act_Notes, t.$10 AS act_ActivityShareLevelID, t.$11 AS act_RecurrenceId, t.$12 AS act_IsRecurringAppointmentRoot, t.$13 AS act_CreatedDate, t.$14 AS act_CreatedUser, t.$15 AS act_ModifiedDate, t.$16 AS act_ModifiedUser, t.$17 AS act_TS, t.$18 AS act_FollowupDate, t.$19 AS act_LegacyID, t.$20 AS act_Dismiss, t.$21 AS act_ReminderNotes, t.$22 AS act_AssociatedCosts, t.$23 AS act_LetterID, t.$24 AS act_DisplayOnCalendar, t.$25 AS act_StartOffset, t.$26 AS act_EndOffset, t.$27 AS act_TimeZoneID, t.$28 AS InsertDate, t.$29 AS UpdateDate, t.$30 AS DeletedFlag, t.$31 AS SYS_CHANGE_VERSION, CASE WHEN t.$30 = True THEN ''D'' WHEN t.$28 = t.$29 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$30, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Activities.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Activities AS WITH curr_v AS (SELECT act_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Activities GROUP BY act_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT ACT_BRANCHID FROM MatrixCare.HIST_STVHC_T_Activities br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = br.ACT_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Activities t INNER JOIN curr_v v ON t.act_ID = v.act_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.ACT_BRANCHID NOT IN (SELECT ACT_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';