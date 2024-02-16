resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_TRANSACTIONS_REPL" {
	name ="GET_TRANSACTIONS_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_Transactions_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Transactions_REPL (SELECT t.$1 AS AgencyID, t.$2 AS Seq, t.$3 AS TransactionDate, t.$4 AS TransactionNumber, t.$5 AS TransactionType, t.$6 AS TransactionID, t.$7 AS VisitID, t.$8 AS PayerID, t.$9 AS DebitAmount, t.$10 AS CreditAmount, t.$11 AS Notes, t.$12 AS CreatedDate, t.$13 AS VisitDate, t.$14 AS CheckDate, t.$15 AS DepositDate, t.$16 AS ServiceCode, t.$17 AS BilledHours, t.$18 AS BilledUnits, t.$19 AS Patientid, t.$20 AS PostedDate, t.$21 AS RateType, t.$22 AS ServiceCodeID, t.$23 AS CareiverID, t.$24 AS DisciplineID, t.$25 AS InvoiceNumber, t.$26 AS TTHours, t.$27 AS OTHours, t.$28 AS OfficeID, t.$29 AS ChargeType, t.$30 AS OtherChargeID, t.$31 AS VisitAdjustmentReasonText, t.$32 AS RefundCheckHeaderID, t.$33 AS TransactionUTCDate, t.$34 AS CreditRefNumber, t.$35 AS OtherAdjustment, t.$36 AS SYS_CHANGE_VERSION, t.$37 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$37,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/HHAEXCHANGEOSHAH_dbo_Transactions_REPL.csv.gz(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) T);

    return ''Success'';
END;

 EOT
}

