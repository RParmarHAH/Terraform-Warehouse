CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_CLINICALTASKCDE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_ClinicalTaskCde 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_ClinicalTaskCde FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Clinical_Task_Code, t.$8 AS Clinical_Task_Desc, t.$9 AS Discipline_Code, t.$10 AS Clinical_Task_Ctg_Code, t.$11 AS Frequency_Code, t.$12 AS Time_Code, t.$13 AS DDL_Scoring_Option, t.$14 AS Score, t.$15 AS Estimated_Time, t.$16 AS ProcCode, t.$17 AS CB_Lock_Time_Score, t.$18 AS CB_Copy_Aide_Care_Plan, t.$19 AS CB_Require_Comment_No, t.$20 AS CB_APC_Task, t.$21 AS DEX_ROW_ID, t.$22 AS Clinical_Task_Note, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_ClinicalTaskCde.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_ClinicalTaskCde AS WITH curr_v AS (SELECT Db, Clinical_Task_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_ClinicalTaskCde GROUP BY Db, Clinical_Task_Code) SELECT t.* FROM CostalSyncData.HIST_CV_ClinicalTaskCde t INNER JOIN curr_v v ON t.Db = v.Db AND t.Clinical_Task_Code = v.Clinical_Task_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';