resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_PAYROLL_DETAILS_REPL" {
	name ="GET_PAYROLL_DETAILS_REPL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_Payroll_Details_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.Payroll_Details_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS PayrollDetailID, t.$3 AS BatchID, t.$4 AS HeaderID, t.$5 AS PatientID, t.$6 AS VisitID, t.$7 AS CaregiverID, t.$8 AS VisitDate, t.$9 AS VisitTime, t.$10 AS VisitStartTime, t.$11 AS VisitEndTime, t.$12 AS ContractServiceCode, t.$13 AS RegularHours, t.$14 AS PayAmount, t.$15 AS OTHours, t.$16 AS OTAmount, t.$17 AS PayRateID, t.$18 AS PayRate, t.$19 AS PayRateCode, t.$20 AS OTPayRateID, t.$21 AS OTPayRate, t.$22 AS OTPayRateCode, t.$23 AS ContractServiceCodeID, t.$24 AS RateType, t.$25 AS InServiceID, t.$26 AS InvoiceDetailID, t.$27 AS PayrollWeekID, t.$28 AS HolidayHours, t.$29 AS HolidayAmount, t.$30 AS HolidayPayRateID, t.$31 AS HolidayPayRate, t.$32 AS HolidayPayRateCode, t.$33 AS PayerID, t.$34 AS DifferentialHours, t.$35 AS DifferentialRate, t.$36 AS DifferentialAmount, t.$37 AS HolidayRateType, t.$38 AS WageParity, t.$39 AS InvoiceRateType, t.$40 AS PayrollSetupID, t.$41 AS OfficeID, t.$42 AS Payrate2, t.$43 AS OTPayrate2, t.$44 AS HolidayPayrate2, t.$45 AS CreatedUTCDate, t.$46 AS UpdatedUTCDate, t.$47 AS CaregiverVacationID, t.$48 AS CreatedBy, t.$49 AS CreatedDate, t.$50 AS UpdatedBy, t.$51 AS UpdatedDate, t.$52 AS SYS_CHANGE_VERSION, t.$53 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$53,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_Payroll_Details_REPL.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

