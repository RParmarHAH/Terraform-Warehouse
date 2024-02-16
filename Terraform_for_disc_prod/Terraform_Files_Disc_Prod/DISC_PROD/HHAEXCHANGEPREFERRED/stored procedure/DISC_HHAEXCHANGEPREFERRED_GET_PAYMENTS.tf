resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_PAYMENTS" {
	name ="GET_PAYMENTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_Payments 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.Payments (SELECT t.$1 AS AgencyID, t.$2 AS PaymentID, t.$3 AS InvoiceDetailID, t.$4 AS PatientID, t.$5 AS VisitID, t.$6 AS Contract, t.$7 AS VisitDate, t.$8 AS BilledHours, t.$9 AS Billedamount, t.$10 AS ServiceCode, t.$11 AS InvoiceDate, t.$12 AS InvoiceNumber, t.$13 AS PaidDate, t.$14 AS CheckDate, t.$15 AS CheckNumber, t.$16 AS PaidAmount, t.$17 AS Adjustment, t.$18 AS TTAdjustment, t.$19 AS WriteOff, t.$20 AS OtherAdjustment, t.$21 AS Credits, t.$22 AS PayerReferenceNumber, t.$23 AS ThirdPartyAmount, t.$24 AS BankCode, t.$25 AS PaymentBatchID, t.$26 AS CheckID, t.$27 AS CreatedDate, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_Payments.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

