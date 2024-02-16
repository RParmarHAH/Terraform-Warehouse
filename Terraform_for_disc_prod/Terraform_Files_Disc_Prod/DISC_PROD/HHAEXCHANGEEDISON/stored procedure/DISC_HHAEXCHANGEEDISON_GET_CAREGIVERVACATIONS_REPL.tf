resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_CAREGIVERVACATIONS_REPL" {
	name ="GET_CAREGIVERVACATIONS_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_CaregiverVacations_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CaregiverVacations_REPL (SELECT t.$1 AS AgencyID, t.$2 AS CaregiverVacationID, t.$3 AS CaregiverID, t.$4 AS StartDate, t.$5 AS EndDate, t.$6 AS Notes, t.$7 AS CaregiverAbsenceTypesID, t.$8 AS PayrollBatchID, t.$9 AS PayRateID, t.$10 AS OfficeID, t.$11 AS ApplyAbsenceHoursToPayroll, t.$12 AS PTOApproved, t.$13 AS PTOHours, t.$14 AS CreatedBy, t.$15 AS CreatedDate, t.$16 AS UpdatedBy, t.$17 AS UpdatedDate, t.$18 AS CreatedUTCDate, t.$19 AS UpdatedUTCDate, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_CaregiverVacations_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

