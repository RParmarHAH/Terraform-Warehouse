CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFPAYMENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfPayments 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfPayments FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS ContractCode, t.$4 AS ClientNumber, t.$5 AS PayDate, t.$6 AS Amount, t.$7 AS CheckNumber, t.$8 AS CreditAmount, t.$9 AS NumbersOfInvoices, t.$10 AS PaymentNo, t.$11 AS AddedDate, t.$12 AS ChangedDate, t.$13 AS AuditNo, t.$14 AS Reserved, t.$15 AS Code, t.$16 AS WriteOffReason, t.$17 AS CreatedDate, t.$18 AS UpdateBatch, t.$19 AS UpdatedTime, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfPayments.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfPayments AS WITH curr_v AS (SELECT DbName, ReferenceNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfPayments GROUP BY DbName, ReferenceNo) SELECT t.* FROM DataFlexSyncData.HIST_DfPayments t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';