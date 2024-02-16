CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_CV_PATIENTCERTIFICATIONDIAGNOSES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_CV_PatientCertificationDiagnoses 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_CV_PatientCertificationDiagnoses FROM (SELECT t.$1 AS Db, t.$2 AS RecStat, t.$3 AS Entry_User, t.$4 AS Entry_Date, t.$5 AS Update_User, t.$6 AS Update_Date, t.$7 AS Patient_Number, t.$8 AS Admission_Number, t.$9 AS Cert_Tran_Number, t.$10 AS Diagnosis_Sequence, t.$11 AS ICD_Code, t.$12 AS Onset_Date, t.$13 AS EOF, t.$14 AS DEX_ROW_ID, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_PatientCertificationDiagnoses.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.CV_PatientCertificationDiagnoses AS WITH curr_v AS (SELECT Db, Cert_Tran_Number, Diagnosis_Sequence, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_PatientCertificationDiagnoses GROUP BY Db, Cert_Tran_Number, Diagnosis_Sequence) SELECT t.* FROM CostalSyncData.HIST_CV_PatientCertificationDiagnoses t INNER JOIN curr_v v ON t.Db = v.Db AND t.Cert_Tran_Number = v.Cert_Tran_Number AND t.Diagnosis_Sequence = v.Diagnosis_Sequence AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';