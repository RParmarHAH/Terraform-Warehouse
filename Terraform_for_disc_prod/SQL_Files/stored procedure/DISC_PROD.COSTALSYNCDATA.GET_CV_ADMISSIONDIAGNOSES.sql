CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_ADMISSIONDIAGNOSES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_AdmissionDiagnoses 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_AdmissionDiagnoses FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Admission_Number, t.$8 AS Sequence_Number, t.$9 AS ICD_Code, t.$10 AS Line_Number_Int, t.$11 AS Onset_Date, t.$12 AS DDL_Status, t.$13 AS Resolution_Date, t.$14 AS EOF9_1, t.$15 AS EOF9_2, t.$16 AS EOF9_3, t.$17 AS EOF9_4, t.$18 AS EOF9_5, t.$19 AS EOF9_6, t.$20 AS EOF9_7, t.$21 AS EOF9_8, t.$22 AS EOF9_9, t.$23 AS CB_SQL_Upgrade_01, t.$24 AS DEX_ROW_ID, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_AdmissionDiagnoses.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_AdmissionDiagnoses AS WITH curr_v AS (SELECT Db, Admission_Number, Sequence_Number, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_AdmissionDiagnoses GROUP BY Db, Admission_Number, Sequence_Number) SELECT t.* FROM CostalSyncData.HIST_CV_AdmissionDiagnoses t INNER JOIN curr_v v ON t.Db = v.Db AND t.Admission_Number = v.Admission_Number AND t.Sequence_Number = v.Sequence_Number AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';