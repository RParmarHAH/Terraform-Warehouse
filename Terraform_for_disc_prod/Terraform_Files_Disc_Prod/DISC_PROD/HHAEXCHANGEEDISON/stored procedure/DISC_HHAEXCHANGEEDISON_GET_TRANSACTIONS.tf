resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_TRANSACTIONS" {
	name ="GET_TRANSACTIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_Transactions 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.Transactions (SELECT t.$1 AS AgencyID, t.$2 AS Seq, t.$3 AS TransactionID, t.$4 AS TransactionDate, t.$5 AS TransactionNumber, t.$6 AS TransactionType, t.$7 AS PatientID, t.$8 AS VisitID, t.$9 AS ContractID, t.$10 AS DebitAmount, t.$11 AS CreditAmount, t.$12 AS Notes, t.$13 AS VisitDate, t.$14 AS CheckDate, t.$15 AS DepositDate, t.$16 AS ServiceCode, t.$17 AS BilledHours, t.$18 AS BilledUnits, t.$19 AS CurrentCheckDate, t.$20 AS CurrentDepositDate, t.$21 AS PatientLastName, t.$22 AS PatientFirstName, t.$23 AS CaregiverCode, t.$24 AS CaregiverFirstName, t.$25 AS CaregiverLastName, t.$26 AS AdmissionID, t.$27 AS OfficeID, t.$28 AS ServiceCodeID, t.$29 AS ModifiedDate, t.$30 AS BilledHoursNumeric, t.$31 AS SYS_CHANGE_VERSION, t.$32 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$32,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/edisonhomedb_dbo_Transactions.csv.gz(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;

 EOT
}

