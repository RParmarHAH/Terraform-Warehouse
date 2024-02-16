resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_SCHEDULEEXPENSES" {
	name ="GET_STVHC_T_SCHEDULEEXPENSES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ScheduleExpenses 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ScheduleExpenses FROM (SELECT t.$1 AS schexp_ID, t.$2 AS schexp_schID, t.$3 AS schexp_expID, t.$4 AS schexp_ClientPayerID, t.$5 AS schexp_PayerID, t.$6 AS schexp_CostUnits, t.$7 AS schexp_CostRateOverrideAmt, t.$8 AS schexp_CostRateOverrideModifiedUser, t.$9 AS schexp_CostRateOverrideModifiedDate, t.$10 AS schexp_BillUnits, t.$11 AS schexp_BillRateUnitFlag, t.$12 AS schexp_BillRateOverrideAmt, t.$13 AS schexp_BillRateOverrideModifiedUser, t.$14 AS schexp_BillRateOverrideModifiedDate, t.$15 AS schexp_BillRateID, t.$16 AS schexp_BillRate, t.$17 AS schexp_PayUnits, t.$18 AS schexp_PayRateUnitFlag, t.$19 AS schexp_PayRateOverrideAmt, t.$20 AS schexp_PayRateOverrideModifiedUser, t.$21 AS schexp_PayRateOverrideModifiedDate, t.$22 AS schexp_Notes, t.$23 AS schexp_PayDate, t.$24 AS schexp_RevenueCode, t.$25 AS schexp_Paycode, t.$26 AS schexp_PayReviewFlag, t.$27 AS schexp_PayrollBatchID, t.$28 AS schexp_NotesDate, t.$29 AS schexp_BillingStatus, t.$30 AS schexp_CreatedDate, t.$31 AS schexp_CreatedUser, t.$32 AS schexp_ModifiedDate, t.$33 AS schexp_ModifiedUser, t.$34 AS schexp_TS, t.$35 AS schexp_TotalCharge, t.$36 AS schexp_BillOTUnits, t.$37 AS schexp_BillOTMulti, t.$38 AS schexp_OriginalPayDate, t.$39 AS schexp_TotalBillable, t.$40 AS schexp_TotalBilled, t.$41 AS schexp_TotalPaid, t.$42 AS schexp_InvoiceDetailDescription, t.$43 AS InsertDate, t.$44 AS UpdateDate, t.$45 AS DeletedFlag, t.$46 AS SYS_CHANGE_VERSION, CASE WHEN t.$45 = True THEN ''D'' WHEN t.$43 = t.$44 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$45, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ScheduleExpenses.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ScheduleExpenses AS WITH curr_v AS (SELECT schexp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ScheduleExpenses GROUP BY schexp_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ScheduleExpenses t INNER JOIN curr_v v ON t.schexp_ID = v.schexp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

