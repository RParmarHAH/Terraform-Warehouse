resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_TBLINVOICEDETAILS_REPL" {
	name ="GET_TBLINVOICEDETAILS_REPL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_tblInvoiceDetails_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.tblInvoiceDetails_REPL (SELECT t.$1 AS InvoiceDetailID, t.$2 AS InvoiceHeaderID, t.$3 AS VisitID, t.$4 AS CaregiverID, t.$5 AS VisitStartTime, t.$6 AS VisitEndTime, t.$7 AS BilledHours, t.$8 AS BilledRate, t.$9 AS OverTimeHours, t.$10 AS OverTimeRate, t.$11 AS TravelTimeHours, t.$12 AS TravelTimeRate, t.$13 AS BilledAmount, t.$14 AS VisitDate, t.$15 AS PatientID, t.$16 AS PayerID, t.$17 AS AgencyID, t.$18 AS InvServiceCodeID, t.$19 AS InvContractServiceCode, t.$20 AS InvRateType, t.$21 AS VisitPaymentStatus, t.$22 AS BilledUnits, t.$23 AS AuthorizationNumber, t.$24 AS LastExportedDate, t.$25 AS PatientPaidAmount, t.$26 AS InvoiceDetailID3rdParty, t.$27 AS EBillingHold, t.$28 AS PayerReferenceNumber, t.$29 AS OfficeID, t.$30 AS SubmissionDate, t.$31 AS SubmissionUTCDate, t.$32 AS EbillingHoldReasonText, t.$33 AS DFTAVisit, t.$34 AS ExternalScheduleID, t.$35 AS ExternalInvoiceNumber, t.$36 AS ExternalClaimNumber, t.$37 AS BillingLineItemID, t.$38 AS CreatedBy, t.$39 AS CreatedDate, t.$40 AS CreatedUTCDate, t.$41 AS UpdatedBy, t.$42 AS UpdatedDate, t.$43 AS UpdatedUTCDate, t.$44 AS SYS_CHANGE_VERSION, t.$45 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$45,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_tblInvoiceDetails_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

