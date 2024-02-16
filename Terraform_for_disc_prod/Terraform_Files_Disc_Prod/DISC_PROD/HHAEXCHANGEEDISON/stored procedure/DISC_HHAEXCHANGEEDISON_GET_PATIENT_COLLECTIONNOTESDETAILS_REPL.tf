resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_PATIENT_COLLECTIONNOTESDETAILS_REPL" {
	name ="GET_PATIENT_COLLECTIONNOTESDETAILS_REPL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_Patient_CollectionNotesDetails_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.Patient_CollectionNotesDetails_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS CollectionNoteDetailID, t.$3 AS CollectionNoteHeaderID, t.$4 AS PatientID, t.$5 AS VisitID, t.$6 AS ContractID, t.$7 AS FollowupDate, t.$8 AS CollectionRepID, t.$9 AS CollectionFollowUpRepID, t.$10 AS InvoiceNumber, t.$11 AS ARNotesReasonID, t.$12 AS CollectionStatusID, t.$13 AS ClaimStatusID, t.$14 AS ReasonForNonPaymentID, t.$15 AS Note, t.$16 AS CreatedBy, t.$17 AS UpdatedBy, t.$18 AS CreatedDate, t.$19 AS UpdatedDate, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_Patient_CollectionNotesDetails_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

