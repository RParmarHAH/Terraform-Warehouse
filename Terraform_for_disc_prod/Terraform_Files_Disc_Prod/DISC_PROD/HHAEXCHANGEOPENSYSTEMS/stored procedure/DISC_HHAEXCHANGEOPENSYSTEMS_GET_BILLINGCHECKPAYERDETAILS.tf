resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_BILLINGCHECKPAYERDETAILS" {
	name ="GET_BILLINGCHECKPAYERDETAILS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_BillingCheckPayerDetails 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.BillingCheckPayerDetails (SELECT t.$1 AS AgencyID, t.$2 AS CheckPayerDetailsId, t.$3 AS CheckId, t.$4 AS PayerId, t.$5 AS PayerName, t.$6 AS PatientId, t.$7 AS CreatedBy, t.$8 AS CreatedDate, t.$9 AS CreatedUTCDate, t.$10 AS UpdatedBy, t.$11 AS UpdatedDate, t.$12 AS UpdatedUTCDate, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_BillingCheckPayerDetails.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

