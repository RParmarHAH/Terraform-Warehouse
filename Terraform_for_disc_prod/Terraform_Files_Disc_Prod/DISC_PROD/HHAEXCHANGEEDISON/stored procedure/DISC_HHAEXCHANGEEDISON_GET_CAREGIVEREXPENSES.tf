resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_CAREGIVEREXPENSES" {
	name ="GET_CAREGIVEREXPENSES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_CaregiverExpenses 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CaregiverExpenses (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverExpenseID, t.$3 AS ExpenseTypeID, t.$4 AS ExpenseType, t.$5 AS ExpenseDate, t.$6 AS CaregiverID, t.$7 AS CaregiverCode, t.$8 AS PayerID, t.$9 AS PatientID, t.$10 AS PayerName, t.$11 AS Billable, t.$12 AS Quantity, t.$13 AS Payable, t.$14 AS BilledRate, t.$15 AS BillTotals, t.$16 AS PayRate, t.$17 AS PayTotal, t.$18 AS PayrollBatchID, t.$19 AS PayrollBatchNumber, t.$20 AS BillExportCode, t.$21 AS PayExportCode, t.$22 AS EntryDate, t.$23 AS Description, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_CaregiverExpenses.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

