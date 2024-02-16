resource "snowflake_procedure" "DISC_HHAEXCHANGEEDISON_GET_PAYROLL_ADJUSTMENTS_REPL" {
	name ="GET_PAYROLL_ADJUSTMENTS_REPL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.GET_Payroll_Adjustments_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.Payroll_Adjustments_REPL (SELECT t.$1 AS AgencyID, t.$2 AS AdjustmentID, t.$3 AS PayrollDetailID, t.$4 AS BatchID, t.$5 AS WeekStartDate, t.$6 AS WeekEndDate, t.$7 AS HeaderID, t.$8 AS PatientID, t.$9 AS VisitID, t.$10 AS CaregiverID, t.$11 AS VisitDate, t.$12 AS VisitTime, t.$13 AS VisitStartTime, t.$14 AS VisitEndTime, t.$15 AS RegularHours, t.$16 AS PayAmount, t.$17 AS OTHours, t.$18 AS OTAmount, t.$19 AS PayRateID, t.$20 AS PayRate, t.$21 AS PayRateCode, t.$22 AS OTPayRateID, t.$23 AS OTPayRate, t.$24 AS OTPayRateCode, t.$25 AS AdmissionID, t.$26 AS PatientName, t.$27 AS CaregiverCode, t.$28 AS CaregiverName, t.$29 AS InvoiceDate, t.$30 AS BatchNumber, t.$31 AS AgencyName, t.$32 AS PayerID, t.$33 AS PayerName, t.$34 AS InserviceID, t.$35 AS RateType, t.$36 AS InvoiceDetailID, t.$37 AS PayrollWeekID, t.$38 AS ContractServiceCodeID, t.$39 AS ContractServiceCode, t.$40 AS HolidayHours, t.$41 AS HolidayAmount, t.$42 AS HolidayPayRateID, t.$43 AS HolidayPayRate, t.$44 AS HolidayPayRateCode, t.$45 AS DifferentialHours, t.$46 AS DifferentialRate, t.$47 AS DifferentialAmount, t.$48 AS PayrollAdjustmentID, t.$49 AS HolidayRateType, t.$50 AS WageParity, t.$51 AS InvoiceRateType, t.$52 AS PayrollSetupID, t.$53 AS OfficeID, t.$54 AS Payrate2, t.$55 AS OTPayrate2, t.$56 AS HolidayPayrate2, t.$57 AS CaregiverVacationID, t.$58 AS CreatedBy, t.$59 AS CreatedDate, t.$60 AS UpdatedBy, t.$61 AS UpdatedDate, t.$62 AS CreatedUTCDate, t.$63 AS UpdatedUTCDate, t.$64 AS SYS_CHANGE_VERSION, t.$65 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$65,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_Payroll_Adjustments_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;

 EOT
}

