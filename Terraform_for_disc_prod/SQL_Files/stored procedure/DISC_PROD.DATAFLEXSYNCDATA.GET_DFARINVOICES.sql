CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFARINVOICES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfArInvoices 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfArInvoices FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS InvoiceNumber, t.$4 AS ContractCode, t.$5 AS Period, t.$6 AS SupplementNo, t.$7 AS Office, t.$8 AS Batch, t.$9 AS ServiceArea, t.$10 AS ContractText, t.$11 AS DateCreated, t.$12 AS HoursBilled, t.$13 AS AmountBilled, t.$14 AS LastPayDate, t.$15 AS GrossPaid, t.$16 AS Outstanding, t.$17 AS ClientBilled, t.$18 AS CcuContract, t.$19 AS CreatedDate, t.$20 AS UpdateBatch, t.$21 AS UpdatedTime, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfArInvoices.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfArInvoices AS WITH curr_v AS (SELECT DbName, ReferenceNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfArInvoices GROUP BY DbName, ReferenceNo) SELECT t.* FROM DataFlexSyncData.HIST_DfArInvoices t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NOT t.PERIOD LIKE ANY (''%2121%'',''%2122%'') AND t.CONTRACTCODE NOT IN (''Q'', ''R'', ''Y'');

    return ''Success'';
END;
';