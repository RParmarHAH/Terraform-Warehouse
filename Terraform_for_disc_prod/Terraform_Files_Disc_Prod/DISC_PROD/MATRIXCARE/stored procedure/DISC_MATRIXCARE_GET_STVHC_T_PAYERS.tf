resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PAYERS" {
	name ="GET_STVHC_T_PAYERS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_Payers 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Payers FROM (SELECT t.$1 AS pay_ID, t.$2 AS pay_BranchID, t.$3 AS pay_ClientID, t.$4 AS pay_Name, t.$5 AS pay_Address1, t.$6 AS pay_Address2, t.$7 AS pay_City, t.$8 AS pay_StateOrProvince, t.$9 AS pay_PostalCode, t.$10 AS pay_County, t.$11 AS pay_Country, t.$12 AS pay_Active, t.$13 AS pay_ContactSalut, t.$14 AS pay_ContactTitle, t.$15 AS pay_ContactFirstName, t.$16 AS pay_ContactLastName, t.$17 AS pay_Phone, t.$18 AS pay_PhoneType, t.$19 AS pay_Notes, t.$20 AS pay_PayerTypeID, t.$21 AS pay_NPI, t.$22 AS pay_BillTypeID, t.$23 AS pay_AgencyProviderNum, t.$24 AS pay_ExcludeFromBatch, t.$25 AS pay_PaymentTypeID, t.$26 AS pay_RegionID, t.$27 AS pay_AuthRequired, t.$28 AS pay_AnsiISAFI01, t.$29 AS pay_AnsiISAFI02, t.$30 AS pay_AnsiISAFI03, t.$31 AS pay_AnsiISAFI04, t.$32 AS pay_AnsiISAFI05_1, t.$33 AS pay_AnsiISAFI06, t.$34 AS pay_AnsiISAFI05_2, t.$35 AS pay_AnsiISAFI07, t.$36 AS pay_AnsiISAFI10, t.$37 AS pay_AnsiISAFI11, t.$38 AS pay_AnsiISAFI12, t.$39 AS pay_AnsiISAFI13, t.$40 AS pay_AnsiISAFI14, t.$41 AS pay_AnsiISAFI15, t.$42 AS pay_AnsiGSF479, t.$43 AS pay_AnsiGSF28, t.$44 AS pay_AnsiGSF455, t.$45 AS pay_AnsiGSF480, t.$46 AS pay_AnsiSTF143, t.$47 AS pay_AnsiSTF329, t.$48 AS pay_AnsiSTF1705, t.$49 AS pay_AnsiBHTF1005, t.$50 AS pay_AnsiHeaderREFF128, t.$51 AS pay_AnsiHeaderREFF127, t.$52 AS pay_AnsiLoop1000ANM1F98, t.$53 AS pay_AnsiLoop1000BNM1F98, t.$54 AS pay_AnsiLoop1000ANM1F66, t.$55 AS pay_AnsiLoop1000BNM1F66, t.$56 AS pay_AnsiReceiverName, t.$57 AS pay_AnsiIDType1, t.$58 AS pay_AnsiIDType2, t.$59 AS pay_AnsiIDType3, t.$60 AS pay_AnsiPhysIDType1, t.$61 AS pay_AnsiPhysIDType2, t.$62 AS pay_AnsiPhysIDType3, t.$63 AS pay_InvoiceTotalRound, t.$64 AS pay_InvoiceTotalRoundDecimal, t.$65 AS pay_InvoiceLineRound, t.$66 AS pay_InvoiceLineRoundDecimal, t.$67 AS pay_EdiTypeID, t.$68 AS pay_CreatedDate, t.$69 AS pay_CreatedUser, t.$70 AS pay_ModifiedDate, t.$71 AS pay_ModifiedUser, t.$72 AS pay_TS, t.$73 AS pay_StatusID, t.$74 AS pay_LegacyID, t.$75 AS pay_LegacyBranchID, t.$76 AS pay_Email, t.$77 AS pay_ERNID, t.$78 AS pay_Itemize1500Billing, t.$79 AS pay_AllowMassEmail, t.$80 AS pay_AuthorizationConflictsAllow, t.$81 AS pay_AuthorizationConflictsOverride, t.$82 AS pay_DailyBenefit12am, t.$83 AS pay_ShowDFPSplit, t.$84 AS pay_ShowDFPBalance, t.$85 AS pay_ShowDFPDailyBenefit, t.$86 AS pay_ShowDFPVisit, t.$87 AS pay_UseClientForInsured, t.$88 AS pay_InvDetailProviderTypeID, t.$89 AS pay_UseBillContactForSign, t.$90 AS pay_UseBillProviderForFacility, t.$91 AS pay_BillByShift, t.$92 AS pay_StampAuth, t.$93 AS pay_DXVersionDefault, t.$94 AS pay_ContactSalutationID, t.$95 AS pay_InvBreakByAuth, t.$96 AS pay_InvBreakByHCPCS, t.$97 AS pay_InvoiceUnitFlag, t.$98 AS pay_InvoiceFromToType, t.$99 AS pay_ShowInvFromDtOnly, t.$100 AS pay_ElectPmtGatewayCustProfileID, t.$101 AS pay_ElectPmtDfltCustPmtProfileID, t.$102 AS pay_InvParm_DisplayBrLogo, t.$103 AS pay_InvParm_DisplayCrBalances, t.$104 AS pay_InvParm_DisplayCarFistNameOnly, t.$105 AS pay_InvParm_DisplayRecentPmts, t.$106 AS pay_InvParm_DisplayOutstandingInv, t.$107 AS pay_InvParm_DisplayDepositBalances, t.$108 AS pay_InvParm_PmtWithinDays, t.$109 AS pay_1500OthrPvdrType, t.$110 AS pay_AuthorizationFromPhysicanOrder, t.$111 AS pay_485Box1UsePolicyNumber, t.$112 AS pay_InvParm_DisplaySchTime, t.$113 AS pay_AnsiISAFI65, t.$114 AS pay_DeliveryMethod, t.$115 AS pay_AnsiSBR1032, t.$116 AS pay_AnsiLoop2310A_Enable, t.$117 AS pay_AnsiLoop2310B_Enable, t.$118 AS pay_AnsiLoop2310C_Enable, t.$119 AS pay_AnsiCLM1359, t.$120 AS pay_AnsiCLM1351, t.$121 AS pay_AnsiCLM1331, t.$122 AS pay_AnsiCLM1325, t.$123 AS pay_AnsiCLM1073_1, t.$124 AS pay_EDIPostingTypeID, t.$125 AS pay_AnsiLoop2300REF_9F_Enable, t.$126 AS pay_EDIAdditionalID, t.$127 AS pay_EDIAdditionalIDType, t.$128 AS pay_InvParm_PayerInvGroupBy, t.$129 AS pay_AnsiLoop2010BBNM1F1035_1, t.$130 AS pay_AnsiLoop2010BBNM1F66, t.$131 AS pay_AnsiLoop2010BBNM1F67, t.$132 AS pay_InvParm_DisplaySchNote, t.$133 AS pay_InvoiceGroupingTypeID, t.$134 AS pay_WeeklyBenefitStart, t.$135 AS pay_MonthlyBenefitStart, t.$136 AS pay_AnsiLoop1000ANM1F1035_1, t.$137 AS pay_AnsiLoop1000ANM1F67, t.$138 AS pay_AnsiLoop1000BNM1F67, t.$139 AS pay_AnsiGSF142, t.$140 AS pay_AnsiGSF124, t.$141 AS pay_AnsiLoop2000C_Enable, t.$142 AS pay_ContAllowAdj, t.$143 AS pay_InvBreakByPOC, t.$144 AS pay_EDI837_TerminateSegmentWithLineFeed, t.$145 AS pay_InvParm_DisplayRatesCharges, t.$146 AS pay_Features, t.$147 AS InsertDate, t.$148 AS UpdateDate, t.$149 AS DeletedFlag, t.$150 AS SYS_CHANGE_VERSION, CASE WHEN t.$149 = True THEN ''D'' WHEN t.$147 = t.$148 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$149, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Payers.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Payers AS WITH curr_v AS (SELECT pay_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Payers GROUP BY pay_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PAY_BRANCHID FROM MatrixCare.HIST_STVHC_T_Payers br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PAY_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Payers t INNER JOIN curr_v v ON t.pay_ID = v.pay_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PAY_BRANCHID NOT IN (SELECT PAY_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

