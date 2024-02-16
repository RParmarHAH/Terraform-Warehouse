resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_INVOICEDETAILS" {
	name ="GET_STVHC_T_INVOICEDETAILS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_InvoiceDetails 
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
    COPY INTO MatrixCare.HIST_STVHC_T_InvoiceDetails FROM (SELECT t.$1 AS invd_ID, t.$2 AS invd_InvhID, t.$3 AS invd_SchedulePayerID, t.$4 AS invd_ServiceCodeID, t.$5 AS invd_ScheduleExpenseID, t.$6 AS invd_ScheduleID, t.$7 AS invd_BranchID, t.$8 AS invd_PayerID, t.$9 AS invd_ClientID, t.$10 AS invd_RateSource, t.$11 AS invd_RateID, t.$12 AS invd_ChargeRate, t.$13 AS invd_InvoiceRate, t.$14 AS invd_ChargeUnits, t.$15 AS invd_ChargeUnitFlag, t.$16 AS invd_InvoiceUnits, t.$17 AS invd_InvoiceUnitFlag, t.$18 AS invd_ChargeFlag, t.$19 AS invd_SplitType, t.$20 AS invd_BenefitDate, t.$21 AS invd_PmtAllowance, t.$22 AS invd_SplitPercent, t.$23 AS invd_Description, t.$24 AS invd_BillCodeID, t.$25 AS invd_BillCode, t.$26 AS invd_SchShfID, t.$27 AS invd_ShiftNo, t.$28 AS invd_HolidayID, t.$29 AS invd_HolidayAdd, t.$30 AS invd_HolidayMult, t.$31 AS invd_ServiceDateFrom, t.$32 AS invd_ServiceDateTo, t.$33 AS invd_RevCode, t.$34 AS invd_HCPCS, t.$35 AS invd_1500POS, t.$36 AS invd_1500TOS, t.$37 AS invd_1500Diag, t.$38 AS invd_1500EPSDT, t.$39 AS invd_1500EMG, t.$40 AS invd_1500COB, t.$41 AS invd_1500LocalUse, t.$42 AS invd_UB_FL49, t.$43 AS invd_NonCovered, t.$44 AS invd_TotalCharges, t.$45 AS invd_DiscountAmount, t.$46 AS invd_DiscountPercent, t.$47 AS invd_CreatedDate, t.$48 AS invd_CreatedUser, t.$49 AS invd_ModifiedDate, t.$50 AS invd_ModifiedUser, t.$51 AS invd_TS, t.$52 AS invd_DisplayRate, t.$53 AS invd_BatchTaxGrpID, t.$54 AS invd_TotalTaxPercent, t.$55 AS invd_TotalTaxFixedAmt, t.$56 AS invd_AcctExtDate, t.$57 AS invd_Round, t.$58 AS invd_RoundDecimal, t.$59 AS invd_OTMulti, t.$60 AS invd_OTUnit, t.$61 AS invd_IncludeEFT, t.$62 AS invd_ServiceUTCDateFrom, t.$63 AS invd_ServiceUTCDateTo, t.$64 AS invd_AllocatedAmt, t.$65 AS invd_1500BillingModifierID1, t.$66 AS invd_1500BillingModifierID2, t.$67 AS invd_1500BillingModifierID3, t.$68 AS invd_1500BillingModifierID4, t.$69 AS invd_ProviderNPI, t.$70 AS invd_OtherIDType, t.$71 AS invd_OtherID, t.$72 AS invd_AuthorizationID, t.$73 AS invd_AuthDetailID, t.$74 AS invd_AuthCode, t.$75 AS invd_DefDaysRem, t.$76 AS invd_IncludeTaxes, t.$77 AS invd_AdmissionID, t.$78 AS invd_DetailsType, t.$79 AS invd_Balance, t.$80 AS invd_AdjustedChargeTotal, t.$81 AS invd_TotalRevAdjustments, t.$82 AS invd_TotalNonRevAdjustments, t.$83 AS invd_TotalPayments, t.$84 AS invd_RegionID, t.$85 AS invd_InvoiceGroupID, t.$86 AS invd_InvoiceGroupCount, t.$87 AS invd_ScheduleNote, t.$88 AS invd_NoCalcUnits, t.$89 AS invd_NoCalcUnitFlag, t.$90 AS invd_NoCalcDateFrom, t.$91 AS invd_NoCalcDateTo, t.$92 AS invd_TaxPortion, t.$93 AS invd_DisplayUnits, t.$94 AS invd_DisplayUnitFlag, t.$95 AS invd_DisplayDateFrom, t.$96 AS invd_DisplayDateTo, t.$97 AS invd_TotalTaxes, t.$98 AS invd_ContractRate, t.$99 AS invd_ContractRateSource, t.$100 AS invd_ContractRateID, t.$101 AS invd_1500DiagLabel, t.$102 AS invd_ScheduleShiftPayersID, t.$103 AS invd_TransferFromInvoiceDetailID, t.$104 AS invd_TransferToInvoiceDetailID, t.$105 AS invd_DraftID, t.$106 AS invd_OTRate, t.$107 AS invd_OTCalcType, t.$108 AS invd_PayrollBatchID, t.$109 AS invd_OTRateSource, t.$110 AS invd_OTUnitsSubtract, t.$111 AS invd_ChargeTotalWOTax, t.$112 AS invd_AllocatedChargeWOTax, t.$113 AS invd_ChargeTotal, t.$114 AS invd_DisplayTotal, t.$115 AS invd_ContractTotal, t.$116 AS invd_DisplayOTRate, t.$117 AS invd_DisplayOTUnits, t.$118 AS invd_LineItemTypeOverride, t.$119 AS invd_LineItemType, t.$120 AS InsertDate, t.$121 AS UpdateDate, t.$122 AS DeletedFlag, t.$123 AS SYS_CHANGE_VERSION, CASE WHEN t.$122 = True THEN ''D'' WHEN t.$120 = t.$121 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$122, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_InvoiceDetails.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_InvoiceDetails AS WITH curr_v AS (SELECT invd_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_InvoiceDetails GROUP BY invd_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT INVD_BRANCHID FROM MatrixCare.HIST_STVHC_T_InvoiceDetails br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.INVD_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_InvoiceDetails t INNER JOIN curr_v v ON t.invd_ID = v.invd_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.INVD_BRANCHID NOT IN (SELECT INVD_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

