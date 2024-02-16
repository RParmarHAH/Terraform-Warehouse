resource "snowflake_procedure" "DISC_COSTALSYNCDATA_GET_CV_MONTHLYHOURS" {
	name ="GET_CV_MONTHLYHOURS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.CostalSyncData.GET_CV_MonthlyHours 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.CostalSyncData.HIST_CV_MonthlyHours FROM (SELECT t.$1 AS DB, t.$2 AS OfficeName, t.$3 AS Location_Code, t.$4 AS SupervisorCode, t.$5 AS SupervisorName, t.$6 AS ServiceMonth, t.$7 AS ServiceYear, t.$8 AS AuthDataCouldBeUpdated, t.$9 AS ClientNumber, t.$10 AS ClientName, t.$11 AS ContractCode, t.$12 AS ContractName, t.$13 AS HoursAuthorized, t.$14 AS HoursServed, t.$15 AS ReferralDate, t.$16 AS FirstDateOfService, t.$17 AS FirstDateOfService_ContractCode, t.$18 AS FirstDateOfService_ContractName, t.$19 AS LastDateOfService_ServiceMonth, t.$20 AS Active, t.$21 AS BillRate, t.$22 AS EmployeeId, t.$23 AS PayRate, t.$24 AS PayHours, t.$25 AS TotalPay, t.$26 AS Admit_Date, t.$27 AS Discharge_Date, t.$28 AS Client_Plan_FirstDateOfService, t.$29 AS Client_Plan_LastDateOfService, t.$30 AS NumberOfSchedules, t.$31 AS HoursBilled, t.$32 AS SYS_CHANGE_VERSION, t.$33 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$33,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_CV_MonthlyHours.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_MonthlyHours AS WITH curr_v AS (SELECT DB, ServiceMonth, ServiceYear, ClientNumber, ContractCode, EmployeeId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_CV_MonthlyHours GROUP BY DB, ServiceMonth, ServiceYear, ClientNumber, ContractCode, EmployeeId) SELECT t.* FROM CostalSyncData.HIST_CV_MonthlyHours t INNER JOIN curr_v v ON t.DB = v.DB AND t.ServiceMonth = v.ServiceMonth AND t.ServiceYear = v.ServiceYear AND t.ClientNumber = v.ClientNumber AND t.ContractCode = v.ContractCode AND t.EmployeeId = v.EmployeeId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

