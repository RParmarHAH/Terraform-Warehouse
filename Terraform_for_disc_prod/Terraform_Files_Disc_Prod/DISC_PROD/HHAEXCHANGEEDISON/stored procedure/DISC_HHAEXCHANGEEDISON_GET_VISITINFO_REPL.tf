resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_VISITINFO_REPL" {
	name ="GET_VISITINFO_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_VisitInfo_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VisitInfo_REPL (SELECT t.$1 AS AgencyID, t.$2 AS VisitInfoID, t.$3 AS VisitID, t.$4 AS NonBillable, t.$5 AS IsUpdatedByPopup, t.$6 AS CaregiverRate, t.$7 AS CaregiverAdjMinutes, t.$8 AS PayRateID, t.$9 AS IsSkilledVisit, t.$10 AS Comments, t.$11 AS PayrollDate, t.$12 AS IVRCallIn, t.$13 AS IVRCallOut, t.$14 AS PocDuties, t.$15 AS IVRDuties, t.$16 AS TimeSheetReceived, t.$17 AS IsMutualLinkedFailed, t.$18 AS IsTempSchedule, t.$19 AS IsTempCaregiver, t.$20 AS DeletedInvoiceNumber1, t.$21 AS DeletedInvoiceNumber2, t.$22 AS Expense1, t.$23 AS Expense2, t.$24 AS ReasonExpense1, t.$25 AS ReasonExpense2, t.$26 AS VisitAuditVerifiedBy, t.$27 AS VisitAuditVerifiedByOther, t.$28 AS VisitAuditDateTime, t.$29 AS VisitAuditSupervisor, t.$30 AS AbsenceCode, t.$31 AS OverTimeCode, t.$32 AS FullServiceCode, t.$33 AS IsVnsResubmit, t.$34 AS PrimaryServiceCodeID, t.$35 AS VisitType, t.$36 AS ParentVisitID, t.$37 AS ServiceCategoryID, t.$38 AS ServiceTypeID, t.$39 AS OnHoldVisit, t.$40 AS BillVisitWithZeroRate, t.$41 AS ClinicalEDocID, t.$42 AS ClinicalEDocStatus, t.$43 AS IncludeMileageExpense, t.$44 AS POCDutiesWithAdditionalValue, t.$45 AS OverrideMileageExpense, t.$46 AS MileageDistance, t.$47 AS MileageRate, t.$48 AS MileagePayTotal, t.$49 AS OfficeID, t.$50 AS TotalVisitPOCMinutes, t.$51 AS TotalVisitPOCMinutesRounded, t.$52 AS ExcludePayCodeRecalculate, t.$53 AS ExcludePayCodePayDifferential, t.$54 AS AllPOCDuties, t.$55 AS SubmissionUTCDate, t.$56 AS ManualAuthorization, t.$57 AS ExternalInvoiceNumber, t.$58 AS BroadcastType, t.$59 AS BroadcastStatus, t.$60 AS CaregiverRequestCount, t.$61 AS InvoiceLineItemID, t.$62 AS ServiceLocation, t.$63 AS CreatedBy, t.$64 AS CreatedDate, t.$65 AS LastModifiedBy, t.$66 AS LastModifiedDate, t.$67 AS ActionTakenReasonID, t.$68 AS SYS_CHANGE_VERSION, t.$69 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$69,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_VisitInfo_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

