resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_PATIENTCALENDARNOTES" {
	name ="GET_PATIENTCALENDARNOTES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_PatientCalendarNotes 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.PatientCalendarNotes (SELECT t.$1 AS AgencyID, t.$2 AS PatientNoteID, t.$3 AS PatientID, t.$4 AS ReasonID, t.$5 AS NoteDate, t.$6 AS StartDate, t.$7 AS FromDate, t.$8 AS ToDate, t.$9 AS PatientNote, t.$10 AS NoteType, t.$11 AS UrgentMessage, t.$12 AS CreatedDate, t.$13 AS CreatedBy, t.$14 AS UpdatedDate, t.$15 AS UpdatedBy, t.$16 AS Status, t.$17 AS FromPayerID, t.$18 AS ToPayerID, t.$19 AS VisitID, t.$20 AS VisitDate, t.$21 AS Scheduled, t.$22 AS Priority, t.$23 AS Internal, t.$24 AS CaregiverID, t.$25 AS VisitNoteID, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_PatientCalendarNotes.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

