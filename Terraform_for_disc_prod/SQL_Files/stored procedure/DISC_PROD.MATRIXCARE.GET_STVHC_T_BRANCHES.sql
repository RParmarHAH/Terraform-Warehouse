CREATE OR REPLACE PROCEDURE DISC_PROD.MATRIXCARE.GET_STVHC_T_BRANCHES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.MatrixCare.GET_STVHC_T_Branches 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Branches FROM (SELECT t.$1 AS br_ID, t.$2 AS br_FormalName, t.$3 AS br_Name, t.$4 AS br_LocationID, t.$5 AS br_ParBranchID, t.$6 AS br_Address1, t.$7 AS br_Address2, t.$8 AS br_City, t.$9 AS br_StateOrProvince, t.$10 AS br_PostalCode, t.$11 AS br_County, t.$12 AS br_Country, t.$13 AS br_UTCOffsetHours, t.$14 AS br_AgencyLicenseNumber, t.$15 AS br_SchedulingWeekStartDay, t.$16 AS br_DefaultTravelTime, t.$17 AS br_SchedulingConflictsOverride, t.$18 AS br_SchedulingScheduleConflictsAllow, t.$19 AS br_SchedulingScheduleConflictsOverride, t.$20 AS br_SchedulingAvailabilityConflictsAllow, t.$21 AS br_SchedulingAvailabilityConflictsOverride, t.$22 AS br_SchedulingDNUConflictsAllow, t.$23 AS br_SchedulingDNUConflictsOverride, t.$24 AS br_SchedulingAuthorizationConflictsAllow, t.$25 AS br_SchedulingAuthorizationConflictsOverride, t.$26 AS br_SchedulingCaregiverExpirationsAllow, t.$27 AS br_SchedulingCaregiverExpirationsOverride, t.$28 AS br_ScheduleListMaxDays, t.$29 AS br_RemitAddress1, t.$30 AS br_RemitAddress2, t.$31 AS br_RemitCity, t.$32 AS br_RemitStateOrProvince, t.$33 AS br_RemitPostalCode, t.$34 AS br_RemitCounty, t.$35 AS br_RemitCountry, t.$36 AS br_RemitPostalCodeID, t.$37 AS br_RemitPhone, t.$38 AS br_RemitFax, t.$39 AS br_RemitContactName, t.$40 AS br_RemitEmail, t.$41 AS br_EDIAdditionalID, t.$42 AS br_EDIAdditionalIDType, t.$43 AS br_OasisIFEnabledFlag, t.$44 AS br_NPI, t.$45 AS br_FedTaxID, t.$46 AS br_Taxonomy, t.$47 AS br_Shift1Desc, t.$48 AS br_Shift2Desc, t.$49 AS br_Shift3Desc, t.$50 AS br_Shift4Desc, t.$51 AS br_Shift5Desc, t.$52 AS br_Shift6Desc, t.$53 AS br_OTDayRateType, t.$54 AS br_OTDayHours, t.$55 AS br_OTDayMultiplier, t.$56 AS br_OTWeekRateType, t.$57 AS br_OTWeekHours, t.$58 AS br_OTWeekMultiplier, t.$59 AS br_PayrollCompanyCode, t.$60 AS br_MappingToolsID, t.$61 AS br_UseMapPoint, t.$62 AS br_MapPointUserName, t.$63 AS br_MapPointPassword, t.$64 AS br_ReplicationServerID, t.$65 AS br_ReplicationUserName, t.$66 AS br_CreatedDate, t.$67 AS br_CreatedUser, t.$68 AS br_ModifiedDate, t.$69 AS br_ModifiedUser, t.$70 AS br_TS, t.$71 AS br_DBA, t.$72 AS br_CompanyID, t.$73 AS br_CompanyAgreementStartDate, t.$74 AS br_CompanyAgreementExpirationDate, t.$75 AS br_BusinessType, t.$76 AS br_PotentialClients, t.$77 AS br_DateEstablished, t.$78 AS br_InvoiceNote, t.$79 AS br_InvoiceTagLine, t.$80 AS br_InvoiceDueDays, t.$81 AS br_BankAccountType, t.$82 AS br_TimeZoneID, t.$83 AS br_SchedulingWeekStartTime, t.$84 AS br_SchedulingCheckForOvertime, t.$85 AS br_SchedulingCheckForOvertimeOverride, t.$86 AS br_BankAccountNumber, t.$87 AS br_BankRoutingNumber, t.$88 AS br_PayrollDivisionCode, t.$89 AS br_LegacyBranchID, t.$90 AS br_AcctSystem, t.$91 AS br_AcctAccrual, t.$92 AS br_AcctName, t.$93 AS br_PCEFileExtractPrefix, t.$94 AS br_PCEUseCompanyCode, t.$95 AS br_PCECompanyCodeChars, t.$96 AS br_PCEUseBatchID, t.$97 AS br_PCEBatchIDNums, t.$98 AS br_PCEFileExtension, t.$99 AS br_PCEDefaultPath, t.$100 AS br_FedTaxIDType, t.$101 AS br_OTWeekEarnCode, t.$102 AS br_TelephonyLoginName, t.$103 AS br_TelephonyUploadRunInterval, t.$104 AS br_TelephonyDownloadRunInterval, t.$105 AS br_TelephonyUploadRange, t.$106 AS br_TelephonyLogXmlDown, t.$107 AS br_TelephonyLogXmlUp, t.$108 AS br_TelephonyPassword, t.$109 AS br_TelephonyAccountId, t.$110 AS br_DefaultServiceCodeId, t.$111 AS br_DefaultMileageId, t.$112 AS br_OTDayEarnCode, t.$113 AS br_EmailSenderAddress, t.$114 AS br_EmailHostName, t.$115 AS br_EmailHostPort, t.$116 AS br_EmailHostUsesSSL, t.$117 AS br_EmailHostUserName, t.$118 AS br_EmailHostPassword, t.$119 AS br_EmailHostDomain, t.$120 AS br_OASIS_Medicare_Payer_ID, t.$121 AS br_OASIS_Medicaid_Payer_ID, t.$122 AS br_OASIS_M0016_Branch_ID, t.$123 AS br_TelephonySetC, t.$124 AS br_CompanyUri, t.$125 AS br_OASIS_IgnoreFatalEdits, t.$126 AS br_AvgEpisodeDays, t.$127 AS br_AcctExtractOnClose, t.$128 AS br_AcctExtractGrpGLDate, t.$129 AS br_PCELimitBatchIDInFile, t.$130 AS br_PCEBatchIDInFileNums, t.$131 AS br_TelephonyTypeID, t.$132 AS br_OASISExtractDefaultPath, t.$133 AS br_OASIS_HHA_Agency_Id, t.$134 AS br_OTDayDeductEarn, t.$135 AS br_OTWeekDeductEarn, t.$136 AS br_IncludePrevPayDates, t.$137 AS br_TelephonyLogLevel, t.$138 AS br_ElectronicPmtProcessEnabled, t.$139 AS br_ElectronicPaymentProcessingTypesID, t.$140 AS br_ElectronicPmtProcessLogin, t.$141 AS br_ElectronicPmtProcessPassword, t.$142 AS br_ElectronicPmtCustInfoMgtLogin, t.$143 AS br_ElectronicPmtCustInfoMgtPassword, t.$144 AS br_ElectronicPmtValidation, t.$145 AS br_TelephonyTimeSource, t.$146 AS br_InvParm_DisplayBrLogo, t.$147 AS br_InvParm_DisplayCrBalances, t.$148 AS br_InvParm_DisplayCarFistNameOnly, t.$149 AS br_InvParm_DisplayRecentPmts, t.$150 AS br_InvParm_DisplayOutstandingInv, t.$151 AS br_InvParm_DisplayDepositBalances, t.$152 AS br_InvParm_PmtWithinDays, t.$153 AS br_PayrollExtractTypeID, t.$154 AS br_485Box5Default, t.$155 AS br_TelephonyTimeBeforeArrivalLimit, t.$156 AS br_TelephonyTimeAfterArrivalLimit, t.$157 AS br_TelephonyTimeBeforeDepartureLimit, t.$158 AS br_TelephonyTimeAfterDepartureLimit, t.$159 AS br_TelephonyCreateNewSchOnNoMatch, t.$160 AS br_TelephonyRoundUp, t.$161 AS br_TelephonyRoundIncrement, t.$162 AS br_TelephonyEmailDestTypeOnMissedVisit, t.$163 AS br_TelephonyEmailAddrOnMissedVisit, t.$164 AS br_TelephonyParentID, t.$165 AS br_MinWage, t.$166 AS br_TelephonyNotificationMaxHoursAgo, t.$167 AS br_FTPPayrollSettings, t.$168 AS br_TreatmentWeekStartDay, t.$169 AS br_BillTypeID, t.$170 AS br_OAReqForClients, t.$171 AS br_TelephonyServiceChangeFlagBehavior, t.$172 AS br_TelephonyCheckInResetThreshold, t.$173 AS br_InvParm_DisplaySchTime, t.$174 AS br_AutoPost, t.$175 AS br_InvParm_DisplaySchNote, t.$176 AS br_AddressVerification, t.$177 AS br_TelephonyEmailFromAddrOnMissedVisit, t.$178 AS br_MgmtInterfPassword, t.$179 AS br_Aalic, t.$180 AS br_AllowSMSTextMessaging, t.$181 AS br_SchedulingSkillGroupCheckAllow, t.$182 AS br_SchedulingSkillGroupCheckOverride, t.$183 AS br_TimeAndAttendLocationThreshold, t.$184 AS br_TimeAndAttendLocationMinAccuracy, t.$185 AS br_TimeAndAttendPortalEnabled, t.$186 AS br_AdministratorEmail, t.$187 AS br_PCE_FileNameSuffix, t.$188 AS br_SchedulingCGStatusConflictsAllow, t.$189 AS br_SchedulingCGStatusConflictsOverride, t.$190 AS br_MaxWeekHours, t.$191 AS br_SchedulingCheckForMaxHours, t.$192 AS br_SchedulingCheckForMaxHoursOverride, t.$193 AS br_EDISFLAdditionalID, t.$194 AS br_EDISFLAdditionalIDType, t.$195 AS br_PayrollTravelTimeThreshold, t.$196 AS br_OperationsFeatures, t.$197 AS br_BillPayKey, t.$198 AS br_BillPayLocationID, t.$199 AS br_IsHolidayOTEligible, t.$200 AS br_InvoiceEmailBody, t.$201 AS InsertDate, t.$202 AS UpdateDate, t.$203 AS DeletedFlag, t.$204 AS br_ElectronicProcessingMerchantID, t.$205 AS br_FtpEftSettings, t.$206 AS SYS_CHANGE_VERSION, CASE WHEN t.$203 = True THEN ''D'' WHEN t.$201 = t.$202 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$203, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Branches.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Branches AS WITH curr_v AS (SELECT br_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Branches GROUP BY br_ID),EXCLUDE_LIST AS ( SELECT DISTINCT BR_ID FROM MatrixCare.HIST_STVHC_T_Branches br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.BR_ID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Branches t INNER JOIN curr_v v ON t.br_ID = v.br_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.BR_ID NOT IN (SELECT BR_ID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;
';