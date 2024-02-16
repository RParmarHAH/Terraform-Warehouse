CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_DISCIPLINES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_Disciplines 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_Disciplines FROM (SELECT t.$1 AS Db, t.$2 AS Entry_Date, t.$3 AS Update_Date, t.$4 AS Discipline_Order_Number, t.$5 AS Patient_Number, t.$6 AS Admission_Number, t.$7 AS Sequence_Number, t.$8 AS Discipline_Sequence, t.$9 AS Cert_Tran_Number, t.$10 AS Discipline_Code, t.$11 AS Statrt_Date, t.$12 AS End__Date, t.$13 AS Minimum_Visit, t.$14 AS Maximum_Visit, t.$15 AS Nurse_ID, t.$16 AS DDL_Discipline_Type, t.$17 AS Requirement_Hours, t.$18 AS Requirement_Visits, t.$19 AS CB_Original, t.$20 AS DEX_ROW_ID, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_Disciplines.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_Disciplines AS WITH curr_v AS (SELECT Db, Patient_Number, Admission_Number, Sequence_Number, Discipline_Sequence, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_Disciplines GROUP BY Db, Patient_Number, Admission_Number, Sequence_Number, Discipline_Sequence) SELECT t.* FROM CostalSyncData.HIST_CV_Disciplines t INNER JOIN curr_v v ON t.Db = v.Db AND t.Patient_Number = v.Patient_Number AND t.Admission_Number = v.Admission_Number AND t.Sequence_Number = v.Sequence_Number AND t.Discipline_Sequence = v.Discipline_Sequence AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';