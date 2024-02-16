resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_UNBILLEDCONFLICTDETAILS_REPL" {
	name ="GET_UNBILLEDCONFLICTDETAILS_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_UnbilledConflictDetails_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.UnbilledConflictDetails_REPL (SELECT t.$1 AS AgencyID, t.$2 AS UnbilledConflictDetailID, t.$3 AS PatientID, t.$4 AS PatientName, t.$5 AS AdmissionID, t.$6 AS PayerID, t.$7 AS PayerName, t.$8 AS AgencyName, t.$9 AS CaregiverID, t.$10 AS CaregiverName, t.$11 AS CaregiverCode, t.$12 AS CaregiverSSN, t.$13 AS VisitID, t.$14 AS AgencyPhoneNumber, t.$15 AS VisitDate, t.$16 AS VisitStartTime, t.$17 AS VisitEndTime, t.$18 AS BilledHours, t.$19 AS BilledMinutes, t.$20 AS BilledDate, t.$21 AS ScheduledHours, t.$22 AS ScheduledMinutes, t.$23 AS ConflictingHours, t.$24 AS ConflictPatientID, t.$25 AS ConflictPatientName, t.$26 AS ConflictAdmissionID, t.$27 AS ConflictPayerID, t.$28 AS ConflictPayerName, t.$29 AS ConflictAgencyID, t.$30 AS ConflictAgencyName, t.$31 AS ConflictCaregiverID, t.$32 AS ConflictCaregiverName, t.$33 AS ConflictCaregiverCode, t.$34 AS ConflictCaregiverSSN, t.$35 AS ConflictVisitID, t.$36 AS ConflictAgencyPhoneNumber, t.$37 AS ConflictVisitDate, t.$38 AS ConflictVisitStartTime, t.$39 AS ConflictVisitEndTime, t.$40 AS ConflictScheduledStartTime, t.$41 AS ConflictScheduledEndTime, t.$42 AS ConflictStatus, t.$43 AS Note, t.$44 AS NoteCreatedDate, t.$45 AS NoteCreatedBy, t.$46 AS CaregiverLastName, t.$47 AS CaregiverFirstName, t.$48 AS ScheduledTime, t.$49 AS Createdby, t.$50 AS CreatedDate, t.$51 AS LastModifiedBy, t.$52 AS LastModifiedDate, t.$53 AS SYS_CHANGE_VERSION, t.$54 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$54,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_UnbilledConflictDetails_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

