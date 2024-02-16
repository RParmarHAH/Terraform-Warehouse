resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_SERVICECODE" {
	name ="GET_STVHC_T_SERVICECODE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ServiceCode 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ServiceCode FROM (SELECT t.$1 AS svcc_ID, t.$2 AS svcc_Name, t.$3 AS svcc_BillCodeID, t.$4 AS svcc_IsExpense, t.$5 AS svcc_IsMultiple, t.$6 AS svcc_OtherCode, t.$7 AS svcc_DefaultCost, t.$8 AS svcc_DefaultPayUnitFlag, t.$9 AS svcc_DefaultBillUnitFlag, t.$10 AS svcc_CategoryID, t.$11 AS svcc_PayrollCode, t.$12 AS svcc_DefaultReimbursment, t.$13 AS svcc_WC, t.$14 AS svcc_ShiftPay, t.$15 AS svcc_OTPay, t.$16 AS svcc_BillExcludeHoliday, t.$17 AS svcc_PayExcludeHoliday, t.$18 AS svcc_IsCat, t.$19 AS svcc_CommissionRate, t.$20 AS svcc_BonusPoints, t.$21 AS svcc_Active, t.$22 AS svcc_RevenueCode, t.$23 AS svcc_Pay, t.$24 AS svcc_POCFirstBillableFlag, t.$25 AS svcc_ExpenseTypeID, t.$26 AS svcc_CreatedDate, t.$27 AS svcc_CreatedUser, t.$28 AS svcc_ModifiedDate, t.$29 AS svcc_ModifiedUser, t.$30 AS svcc_TS, t.$31 AS svcc_ListItemType, t.$32 AS svcc_RptGroupID, t.$33 AS svcc_BranchID, t.$34 AS svcc_OverrideID, t.$35 AS svcc_Description, t.$36 AS svcc_TaxGroupID, t.$37 AS svcc_LegacyID, t.$38 AS svcc_LegacyBranchID, t.$39 AS svcc_AcctID, t.$40 AS svcc_UploadTelephony, t.$41 AS svcc_TelephonyTaskID, t.$42 AS svcc_IncludeEFT, t.$43 AS svcc_ProjectedAvgBillVisit, t.$44 AS svcc_ProjectedAvgPayVisit, t.$45 AS svcc_ProjectedAvgPayHourly, t.$46 AS svcc_ProjectedAvgBillHourly, t.$47 AS svcc_IsCopy, t.$48 AS svcc_IsWorking, t.$49 AS svcc_DeductEarn, t.$50 AS svcc_LiveInRptHrs, t.$51 AS svcc_AcctCode, t.$52 AS svcc_DisplayOnClientPortal, t.$53 AS svcc_DisplayOnCaregiverPortal, t.$54 AS svcc_TherapyCountingType, t.$55 AS svcc_MedicareDiscipline, t.$56 AS svcc_DocType, t.$57 AS svcc_IsMultipleService, t.$58 AS InsertDate, t.$59 AS UpdateDate, t.$60 AS DeletedFlag, t.$61 AS SYS_CHANGE_VERSION, CASE WHEN t.$60 = True THEN ''D'' WHEN t.$58 = t.$59 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$60, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ServiceCode.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ServiceCode AS WITH curr_v AS ( SELECT svcc_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ServiceCode GROUP BY svcc_ID) , EXCLUDE_LIST AS ( SELECT DISTINCT SVCC_BRANCHID FROM MatrixCare.HIST_STVHC_T_ServiceCode br INNER JOIN UTIL.Migrated_Branch_By_SourceSystem BR_EX ON BR_eX.OFFIcE_NUMBER = BR.SVCC_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ServiceCode T INNER JOIN curr_v v ON t.svcc_ID = v.svcc_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.SVCC_BRANCHID,1) NOT IN ( SELECT SVCC_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

