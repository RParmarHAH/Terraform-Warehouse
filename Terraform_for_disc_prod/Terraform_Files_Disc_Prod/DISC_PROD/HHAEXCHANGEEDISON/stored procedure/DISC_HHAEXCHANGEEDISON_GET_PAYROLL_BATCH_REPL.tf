resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_PAYROLL_BATCH_REPL" {
	name ="GET_PAYROLL_BATCH_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_Payroll_Batch_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.Payroll_Batch_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS BatchID, t.$3 AS BatchNumber, t.$4 AS WeekStart, t.$5 AS WeekEnd, t.$6 AS TotalHours, t.$7 AS TotalOTHours, t.$8 AS TotalAmount, t.$9 AS TotalOTAmount, t.$10 AS QBExportDate, t.$11 AS AdjAmount, t.$12 AS AdjHours, t.$13 AS BatchStatus, t.$14 AS PriorOTAmount, t.$15 AS PriorHolidayAmount, t.$16 AS TotalHolidayAmount, t.$17 AS PriorOTHours, t.$18 AS PriorHolidayHours, t.$19 AS TotalHolidayHours, t.$20 AS SkillType, t.$21 AS PayrollSetupID, t.$22 AS CurrentExpenseAmount, t.$23 AS PriorExpenseAmount, t.$24 AS CreatedUTCDate, t.$25 AS UpdatedUTCDate, t.$26 AS PayrollDate, t.$27 AS PayrollUTCDate, t.$28 AS MinVisitDate, t.$29 AS MaxVisitDate, t.$30 AS CurrentMileageAmount, t.$31 AS PriorMileageAmount, t.$32 AS CreatedBy, t.$33 AS CreatedDate, t.$34 AS LastModifiedBy, t.$35 AS LastModifiedDate, t.$36 AS TravelTimeTotalHours, t.$37 AS TravelTimeTotalOTHours, t.$38 AS TravelTimeTotalAmount, t.$39 AS TravelTimeTotalOTAmount, t.$40 AS TravelTimeAdjAmount, t.$41 AS TravelTimeAdjHours, t.$42 AS TravelTimePriorOTAmount, t.$43 AS TravelTimePriorOTHours, t.$44 AS TravelTimeTotalHolidayHours, t.$45 AS TravelTimeTotalHolidayAmount, t.$46 AS TravelTimePriorHolidayHours, t.$47 AS TravelTimePriorHolidayAmount, t.$48 AS SYS_CHANGE_VERSION, t.$49 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$49,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_Payroll_Batch_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

