CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFCLIENTADDRESSES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfClientAddresses 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfClientAddresses FROM (SELECT t.$1 AS DbName, t.$2 AS ClientNumber, t.$3 AS AddressType, t.$4 AS SeqNo, t.$5 AS Description, t.$6 AS Name, t.$7 AS AddressLine1, t.$8 AS AddressLine2, t.$9 AS City, t.$10 AS State, t.$11 AS Zip, t.$12 AS PhoneNumber, t.$13 AS CreatedDate, t.$14 AS UpdateBatch, t.$15 AS UpdatedTime, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfClientAddresses.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfClientAddresses AS WITH curr_v AS (SELECT DbName, ClientNumber, AddressType, SeqNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfClientAddresses GROUP BY DbName, ClientNumber, AddressType, SeqNo) SELECT t.* FROM DataFlexSyncData.HIST_DfClientAddresses t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ClientNumber = v.ClientNumber AND t.AddressType = v.AddressType AND t.SeqNo = v.SeqNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';