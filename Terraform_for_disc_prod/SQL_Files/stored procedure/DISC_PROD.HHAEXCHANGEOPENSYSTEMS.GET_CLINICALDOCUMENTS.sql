CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CLINICALDOCUMENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_ClinicalDocuments 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.ClinicalDocuments (SELECT t.$1 AS AgencyID, t.$2 AS ClinicalDocID, t.$3 AS HHAVisitID, t.$4 AS PatientID, t.$5 AS VisitInfoID, t.$6 AS VisitDate, t.$7 AS VisitTime, t.$8 AS VisitStartTime, t.$9 AS VisitEndTime, t.$10 AS CaregiverID, t.$11 AS CaregiverCode, t.$12 AS DocumentTypeID, t.$13 AS EntryMode, t.$14 AS AttachmentExists, t.$15 AS DocumentStatus, t.$16 AS VendorID, t.$17 AS AideName, t.$18 AS Comment, t.$19 AS CompletedBy, t.$20 AS CompletedDate, t.$21 AS LastPrintDate, t.$22 AS DocTypeVersionID, t.$23 AS Master485ID, t.$24 AS Reason, t.$25 AS PatientUnableToSign, t.$26 AS PatientSignature, t.$27 AS ClinicianSignature, t.$28 AS Deleted, t.$29 AS DeletedBy, t.$30 AS DeletedDate, t.$31 AS CreatedBy, t.$32 AS CreatedDate, t.$33 AS LastUpdatedBy, t.$34 AS LastUpdatedDate, t.$35 AS SYS_CHANGE_VERSION, t.$36 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$36,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ClinicalDocuments.*[.]csv.gz'') T);

    return ''Success'';
END;
';