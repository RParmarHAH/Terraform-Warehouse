CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFSCHEDULEAUTHORIZATIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfScheduleAuthorizations 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfScheduleAuthorizations FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS SequenceNo, t.$4 AS AuthorizationDays, t.$5 AS AuthorizationHours, t.$6 AS CreatedDate, t.$7 AS UpdateBatch, t.$8 AS UpdatedTime, t.$9 AS SYS_CHANGE_VERSION, t.$10 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$10,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfScheduleAuthorizations.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfScheduleAuthorizations AS WITH curr_v AS (SELECT DbName, ReferenceNo, SequenceNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfScheduleAuthorizations GROUP BY DbName, ReferenceNo, SequenceNo) SELECT t.* FROM DataFlexSyncData.HIST_DfScheduleAuthorizations t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.SequenceNo = v.SequenceNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';