resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_EREMITTANCEPREVIEW" {
	name ="GET_EREMITTANCEPREVIEW"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_ERemittancePreview 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.ERemittancePreview (SELECT t.$1 AS AgencyID, t.$2 AS CheckInfoID, t.$3 AS PaymentId, t.$4 AS ContractName, t.$5 AS VendorName, t.$6 AS ReceivedDate, t.$7 AS CheckNumber, t.$8 AS CheckDate, t.$9 AS ClaimNumber, t.$10 AS InvoiceNumber, t.$11 AS PatientNumber, t.$12 AS PatientName, t.$13 AS BilledAmount, t.$14 AS PaidAmount, t.$15 AS PatientRespAmount, t.$16 AS PatientRefNumber, t.$17 AS AdjustmentCode, t.$18 AS AdjustmentAmount, t.$19 AS AdjustmentDescription, t.$20 AS RejectedAmount, t.$21 AS ClaimStatus, t.$22 AS ServiceDate, t.$23 AS RemarkCode, t.$24 AS InterestAmt, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_ERemittancePreview.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

