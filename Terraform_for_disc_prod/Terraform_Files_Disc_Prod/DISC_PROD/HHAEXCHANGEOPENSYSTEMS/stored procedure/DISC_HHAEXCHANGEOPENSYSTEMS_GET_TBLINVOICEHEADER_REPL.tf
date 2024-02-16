resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_TBLINVOICEHEADER_REPL" {
	name ="GET_TBLINVOICEHEADER_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_tblInvoiceHeader_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.tblInvoiceHeader_REPL (SELECT t.$1 AS AgencyID, t.$2 AS InvoiceHeaderID, t.$3 AS BatchID, t.$4 AS PatientID, t.$5 AS CoordinatorID, t.$6 AS PaymentStatus, t.$7 AS InvoiceAmount, t.$8 AS inhVisitFrom, t.$9 AS inhVisitTo, t.$10 AS inhHours, t.$11 AS inhOTHours, t.$12 AS inhTTHours, t.$13 AS VendorInvoiceNumber, t.$14 AS PayerRefNo, t.$15 AS Memo, t.$16 AS inhBilledUnits, t.$17 AS PatientPaidAmount, t.$18 AS Rebilled, t.$19 AS InvoiceDate, t.$20 AS LastPrintedUTCDate, t.$21 AS OfficeID, t.$22 AS CreatedBy, t.$23 AS CreatedDate, t.$24 AS LastModifiedBy, t.$25 AS LastModifiedDate, t.$26 AS CreatedUTCDate, t.$27 AS UpdatedUTCDate, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_tblInvoiceHeader_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

