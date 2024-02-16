resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_SCHEDULEPAYERS" {
	name ="GET_STVHC_T_SCHEDULEPAYERS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_SchedulePayers 
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
    COPY INTO MatrixCare.HIST_STVHC_T_SchedulePayers FROM (SELECT t.$1 AS schcp_ID, t.$2 AS schcp_ClientPayerID, t.$3 AS schcp_PayerID, t.$4 AS schcp_AdmissionID, t.$5 AS schcp_ScheduleID, t.$6 AS schcp_ScheduleExpenseID, t.$7 AS schcp_SeqNo, t.$8 AS schcp_BillSplitTypeID, t.$9 AS schcp_Amount, t.$10 AS schcp_Percent, t.$11 AS schcp_DiscountAmount, t.$12 AS schcp_DiscountPercent, t.$13 AS schcp_CopayerID, t.$14 AS schcp_CopayInvoiceNote, t.$15 AS schcp_Notes, t.$16 AS schcp_Source, t.$17 AS schcp_ExcludeHoliday, t.$18 AS schcp_CreatedDate, t.$19 AS schcp_CreatedUser, t.$20 AS schcp_ModifiedDate, t.$21 AS schcp_ModifiedUser, t.$22 AS schcp_TS, t.$23 AS schcp_InvoiceID, t.$24 AS schcp_CancelDate, t.$25 AS schcp_AddressBookID, t.$26 AS schcp_FeeChartID, t.$27 AS schcp_ChargeAllocationSeqNo, t.$28 AS schcp_TransferFromInvoiceHeaderID, t.$29 AS schcp_TransferToInvoiceHeaderID, t.$30 AS schcp_ManageCOB, t.$31 AS schcp_COBStatus, t.$32 AS InsertDate, t.$33 AS UpdateDate, t.$34 AS DeletedFlag, t.$35 AS SYS_CHANGE_VERSION, CASE WHEN t.$34 = True THEN ''D'' WHEN t.$32 = t.$33 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$34, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_SchedulePayers.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_SchedulePayers AS WITH curr_v AS (SELECT schcp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_SchedulePayers GROUP BY schcp_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_SchedulePayers t INNER JOIN curr_v v ON t.schcp_ID = v.schcp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

