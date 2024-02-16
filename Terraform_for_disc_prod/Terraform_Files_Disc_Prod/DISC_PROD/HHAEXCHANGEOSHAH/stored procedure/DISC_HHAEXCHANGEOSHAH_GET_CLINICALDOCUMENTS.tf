resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_CLINICALDOCUMENTS" {
	name ="GET_CLINICALDOCUMENTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_ClinicalDocuments 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.ClinicalDocuments (SELECT t.$1 AS AgencyID, t.$2 AS ClinicalDocID, t.$3 AS HHAVisitID, t.$4 AS PatientID, t.$5 AS VisitInfoID, t.$6 AS VisitDate, t.$7 AS VisitTime, t.$8 AS VisitStartTime, t.$9 AS VisitEndTime, t.$10 AS CaregiverID, t.$11 AS CaregiverCode, t.$12 AS DocumentTypeID, t.$13 AS EntryMode, t.$14 AS AttachmentExists, t.$15 AS DocumentStatus, t.$16 AS VendorID, t.$17 AS AideName, t.$18 AS Comment, t.$19 AS CompletedBy, t.$20 AS CompletedDate, t.$21 AS LastPrintDate, t.$22 AS DocTypeVersionID, t.$23 AS Master485ID, t.$24 AS Reason, t.$25 AS PatientUnableToSign, t.$26 AS PatientSignature, t.$27 AS ClinicianSignature, t.$28 AS Deleted, t.$29 AS DeletedBy, t.$30 AS DeletedDate, t.$31 AS CreatedBy, t.$32 AS CreatedDate, t.$33 AS LastUpdatedBy, t.$34 AS LastUpdatedDate, t.$35 AS SYS_CHANGE_VERSION, t.$36 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$36,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ClinicalDocuments.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

