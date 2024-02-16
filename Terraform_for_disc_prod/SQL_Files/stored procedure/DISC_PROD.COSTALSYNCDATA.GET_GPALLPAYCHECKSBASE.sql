CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_GPALLPAYCHECKSBASE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_GpAllPayChecksBase 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_GpAllPayChecksBase FROM (SELECT t.$1 AS DB, t.$2 AS AuditTrailNumber, t.$3 AS CheckNumber, t.$4 AS CheckDate, t.$5 AS EmployeeId, t.$6 AS EmployeeName, t.$7 AS Department, t.$8 AS GrossPay, t.$9 AS NetPay, t.$10 AS TotalTax, t.$11 AS PayPeriodBeginDate, t.$12 AS PayPeriodEndDate, t.$13 AS VacationAvailable, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_GpAllPayChecksBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.GpAllPayChecksBase AS WITH curr_v AS (SELECT DB, AuditTrailNumber, CheckNumber, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_GpAllPayChecksBase GROUP BY DB, AuditTrailNumber, CheckNumber) SELECT t.* FROM CostalSyncData.HIST_GpAllPayChecksBase t INNER JOIN curr_v v ON t.DB = v.DB AND t.AuditTrailNumber = v.AuditTrailNumber AND t.CheckNumber = v.CheckNumber AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';