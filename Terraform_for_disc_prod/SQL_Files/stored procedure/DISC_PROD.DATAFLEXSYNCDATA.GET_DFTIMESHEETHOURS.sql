CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFTIMESHEETHOURS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfTimeSheetHours 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfTimeSheetHours FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS WeekendDate, t.$4 AS ServiceDate, t.$5 AS ServiceDayOfWeek, t.$6 AS ServiceHours, t.$7 AS Billed, t.$8 AS StartTime, t.$9 AS EndTime, t.$10 AS CreatedDate, t.$11 AS UpdateBatch, t.$12 AS UpdatedTime, t.$13 AS Paid, t.$14 AS SYS_CHANGE_VERSION, t.$15 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$15,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfTimeSheetHours.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfTimeSheetHours AS WITH curr_v AS (SELECT DbName, ReferenceNo, WeekendDate, ServiceDate, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfTimeSheetHours GROUP BY DbName, ReferenceNo, WeekendDate, ServiceDate), Exclude_List AS (SELECT DISTINCT F.ReferenceNo,F.DBNAME,F.WeekendDate FROM DataFlexSyncData.HIST_DfTimeSheetHours F INNER JOIN DataFlexSyncData.HIST_DfTimeSheetS TS ON f.DbName = ts.DbName AND f.ReferenceNo = ts.ReferenceNo AND f.WeekendDate = ts.WeekendDate INNER JOIN util.Migrated_Branch_By_SourceSystem EXC WHERE EXC.OFFICE_NUMBER = TS.OFFCENO AND F.DBNAME = SYSTEM_CODE AND EXC.SOURCE_SYSTEM_ID = 3 AND SERVICEDATE >= EXC.CUTTOFF_DATE) SELECT t.* FROM DataFlexSyncData.HIST_DfTimeSheetHours t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.WeekendDate = v.WeekendDate AND t.ServiceDate = v.ServiceDate AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE WHERE IFNULL(T.ReferenceNo,''0'') || IFNULL(T.DBNAME,'''') || IFNULL(T.WeekendDate,'''')NOT IN (SELECT IFNULL(ReferenceNo,''0'') || IFNULL(DBNAME,'''') || IFNULL(WeekendDate,'''') FROM Exclude_List);

    return ''Success'';
END;
';