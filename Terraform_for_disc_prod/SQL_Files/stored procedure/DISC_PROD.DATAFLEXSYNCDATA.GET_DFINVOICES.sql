CREATE OR REPLACE PROCEDURE DISC_PROD.DATAFLEXSYNCDATA.GET_DFINVOICES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.DataFlexSyncData.GET_DfInvoices 
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
    COPY INTO DISC_PROD.DataFlexSyncData.HIST_DfInvoices FROM (SELECT t.$1 AS DbName, t.$2 AS InvoiceNo, t.$3 AS Period, t.$4 AS ClientNumber, t.$5 AS ContractCode, t.$6 AS InvoiceType, t.$7 AS SupplementNo, t.$8 AS HoursBilled, t.$9 AS AmountBilled, t.$10 AS PaymentReceived, t.$11 AS CreditedAmount, t.$12 AS OutsandingAmount, t.$13 AS InvoiceCreatedDate, t.$14 AS ServiceArea, t.$15 AS Status, t.$16 AS PayerCode, t.$17 AS Batch, t.$18 AS Office, t.$19 AS TempFinal, t.$20 AS CreatedDate, t.$21 AS UpdateBatch, t.$22 AS UpdatedTime, t.$23 AS MovedTo, t.$24 AS ShortDesc, t.$25 AS LastPayDate, t.$26 AS LastCheckNo, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfInvoices.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfInvoices AS WITH curr_v AS (SELECT DbName, InvoiceNo, Period, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfInvoices GROUP BY DbName, InvoiceNo, Period), exclude_list as (select inv.dbname, inv.invoiceno,inv.period from DataFlexSyncData.HIST_DfInvoiceDetails det inner join DATAFLEXSYNCDATA.HIST_DFINVOICES inv on det.dbname = inv.dbname and det.invoiceno = inv.invoiceno inner join util.Migrated_Branch_By_SourceSystem exc on exc.OFFICE_NUMBER = inv.office  and det.datefrom >= exc.CUTTOFF_DATE and exc.system_code = inv.dbname and EXC.SOURCE_SYSTEM_ID = 3) SELECT t.* FROM DataFlexSyncData.HIST_DfInvoices t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.InvoiceNo = v.InvoiceNo AND t.Period = v.Period AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE where t.invoiceno || t.period || T.dbname not in (select invoiceno || period || dbname from exclude_list);

    return ''Success'';
END;
';