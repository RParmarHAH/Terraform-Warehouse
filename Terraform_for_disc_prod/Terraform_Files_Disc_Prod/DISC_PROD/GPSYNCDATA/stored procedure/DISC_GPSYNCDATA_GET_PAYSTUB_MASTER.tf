resource "snowflake_procedure" "DISC_GPSYNCDATA_GET_PAYSTUB_MASTER" {
	name ="GET_PAYSTUB_MASTER"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GpSyncData.GET_PayStub_Master 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.GpSyncData.HIST_PayStub_Master FROM (SELECT t.$1 AS CheckId, t.$2 AS BatchId, t.$3 AS AuditTrailNumber, t.$4 AS DB, t.$5 AS CheckNumber, t.$6 AS PayType, t.$7 AS EmployeeId, t.$8 AS OfficeNumber, t.$9 AS IsAdmin, t.$10 AS EmployeeType, t.$11 AS Status, t.$12 AS GenerateDate, t.$13 AS PayDate, t.$14 AS PeriodStart, t.$15 AS PeriodEnd, t.$16 AS LastName, t.$17 AS FirstName, t.$18 AS FullName, t.$19 AS Address1, t.$20 AS Address2, t.$21 AS City, t.$22 AS State, t.$23 AS Zip, t.$24 AS SSN, t.$25 AS CompanyName, t.$26 AS CompanyAddress1, t.$27 AS CompanyAddress2, t.$28 AS CompanyCity, t.$29 AS CompanyState, t.$30 AS CompanyZip, t.$31 AS NetWages, t.$32 AS GrossWages, t.$33 AS NetWagesYTD, t.$34 AS GrossWagesYTD, t.$35 AS VacationHours, t.$36 AS SickHours, t.$37 AS WorkState, t.$38 AS SutaState, t.$39 AS Department, t.$40 AS Reimbursements, t.$41 AS UnionDues, t.$42 AS OtherDeductions, t.$43 AS TotalUnits, t.$44 AS TotalTaxes, t.$45 AS TotalDeductions, t.$46 AS Comments, t.$47 AS CheckMessage, t.$48 AS EmployeeFedFilingStatus, t.$49 AS EmployeeStateFilingStatus, t.$50 AS EmployeeFedAllow, t.$51 AS EmployeeStateAllow, t.$52 AS GpTransPeriodStart, t.$53 AS GpTransPeriodEnd, t.$54 AS ShortenedEmployeeId, t.$55 AS SanTraxId, t.$56 AS SYS_CHANGE_VERSION, t.$57 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$57,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_PayStub_Master.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.PayStub_Master AS WITH curr_v AS (SELECT CheckId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_PayStub_Master GROUP BY CheckId) SELECT t.* FROM GpSyncData.HIST_PayStub_Master t INNER JOIN curr_v v ON t.CheckId = v.CheckId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

