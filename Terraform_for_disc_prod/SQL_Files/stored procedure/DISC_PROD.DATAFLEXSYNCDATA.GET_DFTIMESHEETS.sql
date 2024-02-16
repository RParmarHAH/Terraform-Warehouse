CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFTIMESHEETS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfTimeSheets 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfTimeSheets FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS WeekendDate, t.$4 AS ClientNumber, t.$5 AS EmployeeNumber, t.$6 AS ContractCode, t.$7 AS PayrollDate, t.$8 AS BillCode, t.$9 AS Reviewed, t.$10 AS Submitted, t.$11 AS Mileage, t.$12 AS MileageBilled, t.$13 AS HourValues, t.$14 AS BilledFlag, t.$15 AS BilledSupplementNo, t.$16 AS HighSupplementNo, t.$17 AS PaidFlag, t.$18 AS CreatedDate, t.$19 AS UpdateBatch, t.$20 AS UpdatedTime, t.$21 AS OffceNo, t.$22 AS SupervisorCode, t.$23 AS ChangedBy, t.$24 AS ChangedTime, t.$25 AS AuditTrailNo, t.$26 AS SeqenceNo, t.$27 AS TrackingId, t.$28 AS IsEvv, t.$29 AS TimesheetType, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfTimeSheets.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfTimeSheets AS WITH curr_v AS (SELECT DbName, ReferenceNo, WeekendDate, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfTimeSheets GROUP BY DbName, ReferenceNo, WeekendDate) SELECT t.* FROM DataFlexSyncData.HIST_DfTimeSheets t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.WeekendDate = v.WeekendDate AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';