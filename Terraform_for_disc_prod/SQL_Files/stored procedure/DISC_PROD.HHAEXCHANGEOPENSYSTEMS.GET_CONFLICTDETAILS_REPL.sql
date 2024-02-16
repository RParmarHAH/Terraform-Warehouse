CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CONFLICTDETAILS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_ConflictDetails_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.ConflictDetails_REPL (SELECT t.$1 AS AgencyID, t.$2 AS ConflictDetailID, t.$3 AS PatientID, t.$4 AS PatientName, t.$5 AS AdmissionID, t.$6 AS PayerID, t.$7 AS PayerName, t.$8 AS AgencyName, t.$9 AS CaregiverID, t.$10 AS CaregiverName, t.$11 AS CaregiverCode, t.$12 AS CaregiverSSN, t.$13 AS VisitID, t.$14 AS AgencyPhoneNumber, t.$15 AS VisitDate, t.$16 AS VisitStartTime, t.$17 AS VisitEndTime, t.$18 AS BilledHours, t.$19 AS BilledMinutes, t.$20 AS BilledDate, t.$21 AS ScheduledHours, t.$22 AS ScheduledMinutes, t.$23 AS ConflictingHours, t.$24 AS ConflictPatientID, t.$25 AS ConflictPatientName, t.$26 AS ConflictAdmissionID, t.$27 AS ConflictPayerID, t.$28 AS ConflictPayerName, t.$29 AS ConflictAgencyName, t.$30 AS ConflictCaregiverID, t.$31 AS ConflictCaregiverName, t.$32 AS ConflictCaregiverCode, t.$33 AS ConflictVisitID, t.$34 AS ConflictAgencyPhoneNumber, t.$35 AS ConflictVisitDate, t.$36 AS ConflictVisitStartTime, t.$37 AS ConflictVisitEndTime, t.$38 AS ConflictStatus, t.$39 AS Note, t.$40 AS NoteCreatedDate, t.$41 AS NoteCreatedBy, t.$42 AS CaregiverLastName, t.$43 AS CaregiverFirstName, t.$44 AS ScheduledTime, t.$45 AS ConflictScheduledTime, t.$46 AS OverlapMinutes, t.$47 AS VisitTime, t.$48 AS ConflictVisitTime, t.$49 AS OfficeID, t.$50 AS OfficeName, t.$51 AS ConflictOfficeID, t.$52 AS ConflictOfficeName, t.$53 AS OfficePatientCode, t.$54 AS OfficeCaregiverCode, t.$55 AS ConflictOfficePatientCode, t.$56 AS ConflictOfficeCaregiverCode, t.$57 AS Createdby, t.$58 AS CreatedDate, t.$59 AS LastUpdatedBy, t.$60 AS LastUpdatedDate, t.$61 AS SYS_CHANGE_VERSION, t.$62 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$62,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ConflictDetails_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;
';