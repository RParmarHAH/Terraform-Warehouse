CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFHOLIDAYS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfHolidays 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfHolidays FROM (SELECT t.$1 AS DbName, t.$2 AS HolidayDate, t.$3 AS Description, t.$4 AS BillCode, t.$5 AS CreatedDate, t.$6 AS UpdateBatch, t.$7 AS UpdatedTime, t.$8 AS SYS_CHANGE_VERSION, t.$9 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$9,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfHolidays.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfHolidays AS WITH curr_v AS (SELECT DbName, HolidayDate, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfHolidays GROUP BY DbName, HolidayDate) SELECT t.* FROM DataFlexSyncData.HIST_DfHolidays t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.HolidayDate = v.HolidayDate AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';