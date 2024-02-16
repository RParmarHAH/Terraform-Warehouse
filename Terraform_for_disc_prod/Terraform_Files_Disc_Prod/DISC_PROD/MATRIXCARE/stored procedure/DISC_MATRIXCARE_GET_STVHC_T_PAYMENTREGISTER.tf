resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PAYMENTREGISTER" {
	name ="GET_STVHC_T_PAYMENTREGISTER"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PaymentRegister 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PaymentRegister FROM (SELECT t.$1 AS pmtreg_ID, t.$2 AS pmtreg_BranchID, t.$3 AS pmtreg_Number, t.$4 AS pmtreg_Amount, t.$5 AS pmtreg_NetPayment, t.$6 AS pmtreg_PayerID, t.$7 AS pmtreg_Dated, t.$8 AS pmtreg_DepositDate, t.$9 AS pmtreg_Memo, t.$10 AS pmtreg_PaymentRegisterStatusID, t.$11 AS pmtreg_ClientID, t.$12 AS pmtreg_PeriodDatesID, t.$13 AS pmtreg_PaymentRegisterTypeID, t.$14 AS pmtreg_OrderID, t.$15 AS pmtreg_AuthorizationNumber, t.$16 AS pmtreg_TransactionNumber, t.$17 AS pmtreg_CreatedDate, t.$18 AS pmtreg_CreatedUser, t.$19 AS pmtreg_ModifiedDate, t.$20 AS pmtreg_ModifiedUser, t.$21 AS pmtreg_TS, t.$22 AS pmtReg_AcctExtID, t.$23 AS pmtReg_AcctExtDate, t.$24 AS pmtreg_DepositBalance, t.$25 AS pmtreg_AvailableToPost, t.$26 AS pmtReg_EdiID, t.$27 AS pmtreg_ElectPmtCustID, t.$28 AS pmtreg_ElectPmtCustPmtID, t.$29 AS InsertDate, t.$30 AS UpdateDate, t.$31 AS DeletedFlag, t.$32 AS SYS_CHANGE_VERSION, CASE WHEN t.$31 = True THEN ''D'' WHEN t.$29 = t.$30 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$31, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PaymentRegister[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PaymentRegister AS WITH curr_v AS (SELECT pmtreg_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PaymentRegister GROUP BY pmtreg_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PMTREG_BRANCHID FROM MatrixCare.HIST_STVHC_T_PaymentRegister  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PMTREG_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PaymentRegister t INNER JOIN curr_v v ON t.pmtreg_ID = v.pmtreg_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PMTREG_BRANCHID NOT IN (SELECT PMTREG_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

