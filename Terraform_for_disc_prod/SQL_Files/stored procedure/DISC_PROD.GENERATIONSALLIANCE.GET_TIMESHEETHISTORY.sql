CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_TIMESHEETHISTORY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_TimesheetHistory 
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
    COPY INTO GENERATIONSALLIANCE.TimesheetHistory FROM (SELECT t.$1 AS ID, t.$2 AS PayperiodID, t.$3 AS DateTime, t.$4 AS Function, t.$5 AS UserName, t.$6 AS rec_Added, t.$7 AS rec_Updated, t.$8 AS rec_Deleted, t.$9 AS chkBillePaid, t.$10 AS chkRecvd, t.$11 AS TotalProcessed, t.$12 AS chkConfirmedOnly, t.$13 AS chkIncAvailableShift, t.$14 AS chkSplitMidnight, t.$15 AS rec_ExpenseCount, t.$16 AS rec_Countbilledorpaid, t.$17 AS rec_DeletedExpenseCount, t.$18 AS STATUS, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_TimesheetHistory.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.TimesheetHistory AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.TimesheetHistory GROUP BY ID) SELECT t.* FROM GENERATIONSALLIANCE.TimesheetHistory t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';