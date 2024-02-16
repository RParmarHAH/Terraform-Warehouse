resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_DELETEDINVOICE" {
	name ="GET_DELETEDINVOICE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_DeletedInvoice 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.DeletedInvoice (SELECT t.$1 AS AgencyID, t.$2 AS DeletedInvoiceId, t.$3 AS PatientID, t.$4 AS VisitID, t.$5 AS VisitDate, t.$6 AS ScheduledStartTime, t.$7 AS ScheduledEndTime, t.$8 AS IVRCallIn, t.$9 AS IVRCallOut, t.$10 AS VisitStartTime, t.$11 AS VisitEndTime, t.$12 AS Duties, t.$13 AS ApprovedTravelTimeHours, t.$14 AS MissedVisit, t.$15 AS TimesheetRequired, t.$16 AS TimesheetReceived, t.$17 AS PrimaryBillTo, t.$18 AS PrimaryServiceCode, t.$19 AS PrimaryContractHours, t.$20 AS PrimaryBillType, t.$21 AS Discipline, t.$22 AS SecondaryBillTo, t.$23 AS SecondaryServiceCode, t.$24 AS SecondaryContractHours, t.$25 AS SecondaryBillType, t.$26 AS Billed, t.$27 AS BilledHours, t.$28 AS TravelTimeHours, t.$29 AS OverTimeHours, t.$30 AS Billedamount, t.$31 AS InvoiceNumber, t.$32 AS InvoiceDate, t.$33 AS BatchNumber, t.$34 AS BillingExported, t.$35 AS BillingExportDate, t.$36 AS CaregiverID, t.$37 AS Payrate, t.$38 AS Paid, t.$39 AS PaidDate, t.$40 AS PayrollBatchNumber, t.$41 AS PayrollExported, t.$42 AS PayrollExportDate, t.$43 AS PaidAmount, t.$44 AS PaidHours, t.$45 AS ThirdPartyAmount, t.$46 AS DeletedDate, t.$47 AS SYS_CHANGE_VERSION, t.$48 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$48,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_DeletedInvoice.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

