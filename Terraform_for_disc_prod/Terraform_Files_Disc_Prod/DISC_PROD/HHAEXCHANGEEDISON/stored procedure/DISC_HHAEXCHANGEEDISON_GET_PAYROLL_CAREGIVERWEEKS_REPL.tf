resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_PAYROLL_CAREGIVERWEEKS_REPL" {
	name ="GET_PAYROLL_CAREGIVERWEEKS_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_Payroll_CaregiverWeeks_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.Payroll_CaregiverWeeks_REPL (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverWeekID, t.$3 AS PayrollWeekID, t.$4 AS BatchID, t.$5 AS CaregiverID, t.$6 AS CalculatedOT, t.$7 AS PayrollSetupID, t.$8 AS OfficeID, t.$9 AS CreatedBy, t.$10 AS CreatedDate, t.$11 AS UpdatedBy, t.$12 AS UpdatedDate, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_Payroll_CaregiverWeeks_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

