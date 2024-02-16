resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_INREVIEWVISITS" {
	name ="GET_INREVIEWVISITS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_InReviewVisits 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.InReviewVisits (SELECT t.$1 AS AgencyID, t.$2 AS OfficeID, t.$3 AS PatientID, t.$4 AS AideID, t.$5 AS VisitID, t.$6 AS VisitDate, t.$7 AS ChhaID, t.$8 AS IVRCallIn, t.$9 AS IVRCallOut, t.$10 AS IVRCallInRounded, t.$11 AS IVRCallOutRounded, t.$12 AS NotRoundingVisitTime, t.$13 AS VisitStartTime, t.$14 AS VisitEndTime, t.$15 AS ScheduledTime, t.$16 AS IsMissedVisit, t.$17 AS IsBilled, t.$18 AS IsConfirmed, t.$19 AS IsException, t.$20 AS ExceptionCode, t.$21 AS ManualEdit, t.$22 AS TimeSheetReceived, t.$23 AS InvoiceHeaderID, t.$24 AS InvoiceDate, t.$25 AS LastExportedDate, t.$26 AS BilledHours, t.$27 AS CallInDeviceTypeID, t.$28 AS CallOutDeviceTypeID, t.$29 AS CallInPhoneNumber, t.$30 AS CallOutPhoneNumber, t.$31 AS CallInGPSCoordinates, t.$32 AS CallOutGPSCoordinates, t.$33 AS VisitAuditVerifiedBy, t.$34 AS VisitAuditVerifiedByOther, t.$35 AS VisitAuditDateTime, t.$36 AS VisitAuditSupervisor, t.$37 AS ValidatePaperDutySheet, t.$38 AS vDisciplineID, t.$39 AS DisciplineType, t.$40 AS CoordinatorID, t.$41 AS PatientTeamID, t.$42 AS PatientBranchID, t.$43 AS PatientLocationID, t.$44 AS UpdateReasonID, t.$45 AS IVRVerification, t.$46 AS VisitType, t.$47 AS VisitTypeText, t.$48 AS SYS_CHANGE_VERSION, t.$49 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$49,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT, PATTERN => ''.*edisonhomedb_dbo_InReviewVisits.*[.]csv.gz'')T); 

    return ''Success'';
END;

 EOT
}

