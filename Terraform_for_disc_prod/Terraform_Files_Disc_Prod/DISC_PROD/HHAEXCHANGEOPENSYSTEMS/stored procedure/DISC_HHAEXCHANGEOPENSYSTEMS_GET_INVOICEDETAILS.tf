resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_INVOICEDETAILS" {
	name ="GET_INVOICEDETAILS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_InvoiceDetails 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.InvoiceDetails (SELECT t.$1 AS AgencyID, t.$2 AS OfficeID, t.$3 AS InvoiceDetailID, t.$4 AS InvoiceHeaderID, t.$5 AS VisitID, t.$6 AS VisitDate, t.$7 AS PatientID, t.$8 AS AideID, t.$9 AS ScheduleStartTime, t.$10 AS ScheduleEndTime, t.$11 AS VisitStartTime, t.$12 AS VisitEndTime, t.$13 AS BilledHours, t.$14 AS BilledRate, t.$15 AS OverTimeHours, t.$16 AS OverTimeRate, t.$17 AS TravelTimeHours, t.$18 AS TravelTimeRate, t.$19 AS BilledUnits, t.$20 AS BilledAmount, t.$21 AS thirdparty, t.$22 AS PayerID, t.$23 AS InvServiceCodeID, t.$24 AS InvPayRateID, t.$25 AS InvPayRate, t.$26 AS InvRateType, t.$27 AS AuthorizationNumber, t.$28 AS NonBillable, t.$29 AS PaymentStatus, t.$30 AS PayAmount, t.$31 AS ModifiedDate, t.$32 AS IsDeleted, t.$33 AS SYS_CHANGE_VERSION, t.$34 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$34,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_InvoiceDetails.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

