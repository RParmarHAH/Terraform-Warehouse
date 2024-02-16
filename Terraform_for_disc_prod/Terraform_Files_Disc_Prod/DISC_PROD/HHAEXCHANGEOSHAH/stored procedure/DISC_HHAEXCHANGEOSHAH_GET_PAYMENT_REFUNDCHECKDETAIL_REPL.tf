resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_PAYMENT_REFUNDCHECKDETAIL_REPL" {
	name ="GET_PAYMENT_REFUNDCHECKDETAIL_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_Payment_RefundCheckDetail_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Payment_RefundCheckDetail_REPL (SELECT t.$1 AS AgencyID, t.$2 AS RefundCheckDetailID, t.$3 AS Type, t.$4 AS ContractID, t.$5 AS PatientID, t.$6 AS RefundCheckHeaderID, t.$7 AS CheckNumber, t.$8 AS RefCheckId, t.$9 AS RefCheckNumber, t.$10 AS Amount, t.$11 AS CreditPatientID, t.$12 AS CreditType, t.$13 AS PostedDate, t.$14 AS CreatedBy, t.$15 AS CreatedDate, t.$16 AS UpdatedBy, t.$17 AS UpdatedDate, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_Payment_RefundCheckDetail_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

