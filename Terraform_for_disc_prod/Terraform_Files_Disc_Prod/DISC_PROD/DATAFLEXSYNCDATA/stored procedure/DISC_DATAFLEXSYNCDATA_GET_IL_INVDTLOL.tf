resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_IL_INVDTLOL" {
	name ="GET_IL_INVDTLOL"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_IL_INVDTLOL 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_IL_INVDTLOL FROM (SELECT t.$1 AS RECORD_NUMBER, t.$2 AS INVOICE_NO, t.$3 AS DATEFROM, t.$4 AS DATETO, t.$5 AS HOURS, t.$6 AS AMOUNT, t.$7 AS AMOUNT_PAID, t.$8 AS BILLCODE, t.$9 AS CLIENT_NUMBER, t.$10 AS BILLING_NUMBER, t.$11 AS OLDRECNUM, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_archive_IL_INVDTLOL.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.IL_INVDTLOL AS WITH curr_v AS (SELECT RECORD_NUMBER, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_IL_INVDTLOL GROUP BY RECORD_NUMBER), exclude_list as (select det.RECORD_NUMBER from DataFlexSyncData.HIST_IL_INVDTLOL det inner join DATAFLEXSYNCDATA.HIST_DFINVOICES inv on ''IL'' = inv.dbname and det.invoice_no = inv.invoiceno inner join util.Migrated_Branch_By_SourceSystem exc on exc.OFFICE_NUMBER = inv.office  and det.datefrom >= exc.CUTTOFF_DATE and exc.system_code = inv.dbname and EXC.SOURCE_SYSTEM_ID = 3) SELECT t.* FROM DataFlexSyncData.HIST_IL_INVDTLOL t INNER JOIN curr_v v ON t.RECORD_NUMBER = v.RECORD_NUMBER AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE where t.RECORD_NUMBER not in (select RECORD_NUMBER from exclude_list);

    return ''Success'';
END;

 EOT
}

