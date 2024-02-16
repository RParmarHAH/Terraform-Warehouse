CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_CLNCPTSKCDE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_CLNCPTSKCDE 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_CLNCPTSKCDE FROM (SELECT t.$1 AS Db, t.$2 AS CP_Clinical_Note_Number, t.$3 AS Clinical_Task_Ctg_Code, t.$4 AS Clinical_Task_Code, t.$5 AS CP_Task_Memo, t.$6 AS Discipline_Code, t.$7 AS Frequency_Code, t.$8 AS Time_Code, t.$9 AS Number_Of_Times, t.$10 AS Estimated_Time, t.$11 AS Actual_Time, t.$12 AS DDL_CP_Task_Status, t.$13 AS CP_Task_Status_Date, t.$14 AS CB_Completed, t.$15 AS CB_Yes, t.$16 AS CB_No, t.$17 AS Line_Number_Int, t.$18 AS Reason_Code, t.$19 AS NoteText, t.$20 AS TimeDetails, t.$21 AS Entry_User, t.$22 AS Entry_Date, t.$23 AS Update_User, t.$24 AS Update_Date, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_CLNCPTSKCDE.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_CLNCPTSKCDE AS WITH curr_v AS (SELECT Db, CP_Clinical_Note_Number, Clinical_Task_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_CLNCPTSKCDE GROUP BY Db, CP_Clinical_Note_Number, Clinical_Task_Code) SELECT t.* FROM CostalSyncData.HIST_CV_CLNCPTSKCDE t INNER JOIN curr_v v ON t.Db = v.Db AND t.CP_Clinical_Note_Number = v.CP_Clinical_Note_Number AND t.Clinical_Task_Code = v.Clinical_Task_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';