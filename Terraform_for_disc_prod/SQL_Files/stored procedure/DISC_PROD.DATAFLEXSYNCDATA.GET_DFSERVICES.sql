CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFSERVICES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfServices 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfServices FROM (SELECT t.$1 AS DbName, t.$2 AS Area, t.$3 AS ContractNumber, t.$4 AS FeinNumber, t.$5 AS VendorAgreeNo, t.$6 AS Batch_Totals, t.$7 AS CcuAgreeNo, t.$8 AS DorsHspcNumber, t.$9 AS Location, t.$10 AS CcuContract, t.$11 AS BatchClients, t.$12 AS District, t.$13 AS IdoaFlag, t.$14 AS Name, t.$15 AS GaurName, t.$16 AS GaurContact, t.$17 AS GaurAddress, t.$18 AS GaurCity, t.$19 AS GaurState, t.$20 AS GaurZip, t.$21 AS CaseMgrId, t.$22 AS CreatedDate, t.$23 AS UpdateBatch, t.$24 AS UpdatedTime, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfServices.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfServices AS WITH curr_v AS (SELECT DbName, Area, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfServices GROUP BY DbName, Area) SELECT t.* FROM DataFlexSyncData.HIST_DfServices t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.Area = v.Area AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';