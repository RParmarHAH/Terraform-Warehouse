CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CLINICALDIAGNOSIS485("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalDiagnosis485 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.ClinicalDiagnosis485 (SELECT t.$1 AS AgencyID, t.$2 AS Diagnosis485ID, t.$3 AS DiagnosisID, t.$4 AS Master485ID, t.$5 AS PatientID, t.$6 AS DiagnosisCode, t.$7 AS Description, t.$8 AS IsPrimaryDiagnosis, t.$9 AS DateType, t.$10 AS OnSetDate, t.$11 AS status, t.$12 AS CreatedBy, t.$13 AS CreatedDate, t.$14 AS UpdatedBy, t.$15 AS UpdatedDate, t.$16 AS ICD, t.$17 AS HistoricalAsOfDate, t.$18 AS Source, t.$19 AS DisplayOrder, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalDiagnosis485.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;
';