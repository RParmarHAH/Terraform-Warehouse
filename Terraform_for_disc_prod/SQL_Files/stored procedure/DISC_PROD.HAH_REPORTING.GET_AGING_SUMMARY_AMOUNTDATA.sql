CREATE OR REPLACE PROCEDURE DISC_PROD.HAH_REPORTING.GET_AGING_SUMMARY_AMOUNTDATA("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HAH_Reporting.GET_aging_summary_AmountData 
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
    COPY INTO DISC_PROD.HAH_Reporting.HIST_aging_summary_AmountData FROM (SELECT t.$1 AS LineId, t.$2 AS DfDb, t.$3 AS DataType, t.$4 AS AmountType, t.$5 AS ContractCode, t.$6 AS Period, t.$7 AS ClientNumber, t.$8 AS OfficeNumber, t.$9 AS AdditionalItemName, t.$10 AS AdditionalItem, t.$11 AS PayDate, t.$12 AS CreditApplyDate, t.$13 AS PeriodDate, t.$14 AS BilledAmount, t.$15 AS PaidAmount, t.$16 AS CreditAmount, t.$17 AS KeyHash, t.$18 AS KeyValue, t.$19 AS ServiceArea, t.$20 AS InvoiceBatch, t.$21 AS ClientBillOffice, t.$22 AS MovedToContract, t.$23 AS IdoaRecoup, t.$24 AS RegionCode, t.$25 AS RejectionCode, t.$26 AS WoReason, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/HAH_REPORTING/ (PATTERN => ''.*HAH_Reporting_aging_summary_AmountData.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE HAH_Reporting.aging_summary_AmountData AS WITH curr_v AS (SELECT DfDb, DataType, AmountType, ContractCode, Period, ClientNumber, OfficeNumber, AdditionalItemName, AdditionalItem, PayDate, CreditApplyDate, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM HAH_Reporting.HIST_aging_summary_AmountData GROUP BY DfDb, DataType, AmountType, ContractCode, Period, ClientNumber, OfficeNumber, AdditionalItemName, AdditionalItem, PayDate, CreditApplyDate) SELECT t.* FROM HAH_Reporting.HIST_aging_summary_AmountData t INNER JOIN curr_v v ON t.DfDb = v.DfDb AND t.DataType = v.DataType AND t.AmountType = v.AmountType AND t.ContractCode = v.ContractCode AND t.Period = v.Period AND t.ClientNumber = v.ClientNumber AND t.OfficeNumber = v.OfficeNumber AND t.AdditionalItemName = v.AdditionalItemName AND t.AdditionalItem = v.AdditionalItem AND t.PayDate = v.PayDate AND t.CreditApplyDate = v.CreditApplyDate AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';