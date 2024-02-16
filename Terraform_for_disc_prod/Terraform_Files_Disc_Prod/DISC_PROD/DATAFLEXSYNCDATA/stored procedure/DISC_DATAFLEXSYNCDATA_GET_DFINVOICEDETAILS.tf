resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_DFINVOICEDETAILS" {
	name ="GET_DFINVOICEDETAILS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_DfInvoiceDetails 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_DfInvoiceDetails FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS InvoiceNo, t.$4 AS DateFrom, t.$5 AS DateTo, t.$6 AS Hours, t.$7 AS Amount, t.$8 AS AmountPaid, t.$9 AS BillCode, t.$10 AS ClientNumber, t.$11 AS EmployeeNo1, t.$12 AS EmployeeNo2, t.$13 AS EmployeeNo3, t.$14 AS ContractCode, t.$15 AS PreAuthNumber, t.$16 AS StartTime, t.$17 AS CreatedDate, t.$18 AS UpdateBatch, t.$19 AS UpdatedTime, t.$20 AS DataSource, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfInvoiceDetails.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfInvoiceDetails AS WITH curr_v AS (SELECT DbName, ReferenceNo, InvoiceNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfInvoiceDetails GROUP BY DbName, ReferenceNo, InvoiceNo), exclude_list as (select det.referenceno,det.invoiceno from DataFlexSyncData.HIST_DfInvoiceDetails det inner join DATAFLEXSYNCDATA.HIST_DFINVOICES inv on det.dbname = inv.dbname and det.invoiceno = inv.invoiceno inner join util.Migrated_Branch_By_SourceSystem exc on exc.OFFICE_NUMBER = inv.office  and det.datefrom >= exc.CUTTOFF_DATE and exc.system_code = inv.dbname and EXC.SOURCE_SYSTEM_ID = 3) SELECT t.* FROM DataFlexSyncData.HIST_DfInvoiceDetails t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.InvoiceNo = v.InvoiceNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE where t.referenceno || t.invoiceno not in (select referenceno || invoiceno from exclude_list);

    return ''Success'';
END;

 EOT
}

