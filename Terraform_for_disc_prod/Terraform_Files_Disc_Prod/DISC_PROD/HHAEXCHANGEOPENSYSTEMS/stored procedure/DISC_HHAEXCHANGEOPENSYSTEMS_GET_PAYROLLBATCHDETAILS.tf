resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_PAYROLLBATCHDETAILS" {
	name ="GET_PAYROLLBATCHDETAILS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_PayrollBatchDetails 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.PayrollBatchDetails (SELECT t.$1 AS AutoID, t.$2 AS BatchID, t.$3 AS BatchNumber, t.$4 AS BatchDate, t.$5 AS CaregiverID, t.$6 AS CaregiverCode, t.$7 AS CaregiverFirstName, t.$8 AS CaregiverLastName, t.$9 AS CaregiverSSN, t.$10 AS AdmissionID, t.$11 AS PatientID, t.$12 AS MRNumber, t.$13 AS VisitID, t.$14 AS VisitDate, t.$15 AS VisitStartTime, t.$16 AS VisitEndTime, t.$17 AS RegularHours, t.$18 AS RegularPayRate, t.$19 AS RegularPayCode, t.$20 AS RegularAmount, t.$21 AS OverTimeHours, t.$22 AS OverTimePayRate, t.$23 AS OverTimeAmount, t.$24 AS HolidayHours, t.$25 AS HolidayPayRate, t.$26 AS HolidayAmount, t.$27 AS PayType, t.$28 AS OriginalPayType, t.$29 AS PayrollWeekEndingDate, t.$30 AS DifferentialHours, t.$31 AS DifferentialRate, t.$32 AS DifferentialAmount, t.$33 AS BillingServiceCode, t.$34 AS ContractName, t.$35 AS ContractID, t.$36 AS SSVCID, t.$37 AS SYS_CHANGE_VERSION, t.$38 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$38,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_PayrollBatchDetails.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

