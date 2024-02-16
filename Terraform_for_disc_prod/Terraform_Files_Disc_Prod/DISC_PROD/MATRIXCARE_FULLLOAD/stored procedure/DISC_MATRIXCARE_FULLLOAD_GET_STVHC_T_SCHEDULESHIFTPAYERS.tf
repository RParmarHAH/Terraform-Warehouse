resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_SCHEDULESHIFTPAYERS" {
	name ="GET_STVHC_T_SCHEDULESHIFTPAYERS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ScheduleShiftPayers 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ScheduleShiftPayers FROM (SELECT t.$1 AS schsp_ID, t.$2 AS schsp_SchedulePayerID, t.$3 AS schsp_ClientPayerID, t.$4 AS schsp_ScheduleShiftID, t.$5 AS schsp_InvoiceDetailsID, t.$6 AS schsp_BillFlag, t.$7 AS schsp_BillSplitTypeID, t.$8 AS schsp_PayerSeqNo, t.$9 AS schsp_AllocatedAmount, t.$10 AS schsp_Amount, t.$11 AS schsp_Percent, t.$12 AS schsp_BenefitDate, t.$13 AS schsp_CreatedDate, t.$14 AS schsp_CreatedUser, t.$15 AS schsp_ModifiedDate, t.$16 AS schsp_ModifiedUser, t.$17 AS schsp_ChargeAllocationSeqNo, t.$18 AS schsp_DraftID, t.$19 AS schsp_BatchID, t.$20 AS schsp_ManageCOB, t.$21 AS schsp_TransferFromInvoiceHeaderID, t.$22 AS schsp_TransferFromInvoiceDetailID, t.$23 AS InsertDate, t.$24 AS UpdateDate, t.$25 AS DeletedFlag, t.$26 AS SYS_CHANGE_VERSION, CASE WHEN t.$25 = True THEN ''D'' WHEN t.$23 = t.$24 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$25, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ScheduleShiftPayers.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ScheduleShiftPayers AS WITH curr_v AS (SELECT schsp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ScheduleShiftPayers GROUP BY schsp_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ScheduleShiftPayers t INNER JOIN curr_v v ON t.schsp_ID = v.schsp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

