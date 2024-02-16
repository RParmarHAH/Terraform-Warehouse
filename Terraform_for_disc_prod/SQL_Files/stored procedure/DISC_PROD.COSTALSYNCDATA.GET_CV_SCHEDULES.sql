CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_SCHEDULES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_Schedules 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_Schedules FROM (SELECT t.$1 AS Db, t.$2 AS Location_Code, t.$3 AS Location_Name, t.$4 AS STATE_CODE, t.$5 AS Patient_Number, t.$6 AS Nurse_ID, t.$7 AS Schedule_Date, t.$8 AS Schedule_Time, t.$9 AS Duration, t.$10 AS Plan_Code, t.$11 AS ProcCode, t.$12 AS Confirmed_Time, t.$13 AS Confirmed_Duration, t.$14 AS Department__Code, t.$15 AS Department_Name, t.$16 AS Regular_Hours, t.$17 AS Schedule_Number, t.$18 AS Schedule_Status_Code, t.$19 AS Schedule_Status_Desc, t.$20 AS Admission_Number, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Schedules.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_Schedules AS WITH curr_v AS (SELECT Db, Schedule_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Schedules GROUP BY Db, Schedule_Number) SELECT t.* FROM CostalSyncData.HIST_CV_Schedules t INNER JOIN curr_v v ON t.Db = v.Db AND t.Schedule_Number = v.Schedule_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';