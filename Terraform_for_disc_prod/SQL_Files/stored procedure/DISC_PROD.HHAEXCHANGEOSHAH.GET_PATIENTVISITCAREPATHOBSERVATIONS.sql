CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PATIENTVISITCAREPATHOBSERVATIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_PatientVisitCarePathObservations 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.PatientVisitCarePathObservations (SELECT t.$1 AS AgencyID, t.$2 AS VisitFeedbackDetailID, t.$3 AS PatientID, t.$4 AS VisitID, t.$5 AS LanguageID, t.$6 AS QuestionID, t.$7 AS DiagnosisQuestionID, t.$8 AS Observations, t.$9 AS Response, t.$10 AS Alert, t.$11 AS Status, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_PatientVisitCarePathObservations.*[.]csv.gz'') T);

    return ''Success'';
END;
';