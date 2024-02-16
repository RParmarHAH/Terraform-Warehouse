CREATE OR REPLACE PROCEDURE DISC_PROD.SANDATAEXCHANGE.GET_DFIMPORT_IMPORTVISITS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.SanDataExchange.GET_DfImport_ImportVisits 
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
    COPY INTO DISC_PROD.SanDataExchange.HIST_DfImport_ImportVisits FROM (SELECT t.$1 AS LineId, t.$2 AS VisitKey, t.$3 AS ImportTaskId, t.$4 AS TimesheetId, t.$5 AS State, t.$6 AS RefNo, t.$7 AS TrackingId, t.$8 AS ClientNo, t.$9 AS EmployeeNo, t.$10 AS ContractCode, t.$11 AS BillCode, t.$12 AS PayrollDate, t.$13 AS WeekendDate, t.$14 AS OfficeNo, t.$15 AS SupervisorCode, t.$16 AS IsImported, t.$17 AS ReadTime, t.$18 AS IsValid, t.$19 AS VisitChangeType, t.$20 AS ServiceDate, t.$21 AS HoursDelta, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAEXCHANGE/ (PATTERN => ''.*SanDataExchange_DfImport_ImportVisits.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SanDataExchange.DfImport_ImportVisits AS WITH curr_v AS (SELECT LineId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SanDataExchange.HIST_DfImport_ImportVisits GROUP BY LineId) SELECT t.* FROM SanDataExchange.HIST_DfImport_ImportVisits t INNER JOIN curr_v v ON t.LineId = v.LineId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';