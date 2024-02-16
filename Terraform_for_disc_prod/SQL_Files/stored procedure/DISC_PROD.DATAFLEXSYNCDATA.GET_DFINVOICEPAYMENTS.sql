CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFINVOICEPAYMENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfInvoicePayments 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfInvoicePayments FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS ClientNumber, t.$4 AS ContractCode, t.$5 AS Period, t.$6 AS InvoiceNo, t.$7 AS Batch, t.$8 AS SupplementNo, t.$9 AS PaidAmount, t.$10 AS BilledAmount, t.$11 AS CoPay, t.$12 AS PaymentDateTime, t.$13 AS ProviderContract, t.$14 AS Code, t.$15 AS AuditNo, t.$16 AS Voucher, t.$17 AS RunDate, t.$18 AS CPT_HPCS_Code, t.$19 AS AddedDate, t.$20 AS WriteOffAmount, t.$21 AS CheckNumber, t.$22 AS McoPaidAmount, t.$23 AS McoPlugAmount, t.$24 AS WriteOffReason, t.$25 AS ChangedDate, t.$26 AS PayerCode, t.$27 AS CreatedDate, t.$28 AS UpdateBatch, t.$29 AS UpdatedTime, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfInvoicePayments.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfInvoicePayments AS WITH curr_v AS (SELECT DbName, ReferenceNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfInvoicePayments GROUP BY DbName, ReferenceNo) SELECT t.* FROM DataFlexSyncData.HIST_DfInvoicePayments t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';