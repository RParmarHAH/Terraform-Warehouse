CREATE OR REPLACE PROCEDURE DISC_PROD.BI_REPOSITORY.GET_EXTERNALIDS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.BI_Repository.GET_ExternalIDs 
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
    COPY INTO BI_Repository.HIST_ExternalIDs FROM (SELECT t.$1 AS SysID, t.$2 AS LocSys, t.$3 AS Typ, t.$4 AS DBName, t.$5 AS IntID, t.$6 AS IntIDStr, t.$7 AS LstNam, t.$8 AS FstNam, t.$9 AS MdlNam, t.$10 AS ExtSysID, t.$11 AS ExtIDTyp, t.$12 AS ExtID, t.$13 AS EffBegDat, t.$14 AS EffEndDat, t.$15 AS Updated, t.$16 AS Ignore, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/BI_REPOSITORY/ (PATTERN => ''.*BI_Repository_dbo_ExternalIDs.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE BI_Repository.ExternalIDs AS WITH curr_v AS (SELECT SysID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM BI_Repository.HIST_ExternalIDs GROUP BY SysID) SELECT t.* FROM BI_Repository.HIST_ExternalIDs t INNER JOIN curr_v v ON t.SysID = v.SysID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';