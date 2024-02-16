CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_ADMIN_OPTIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_ADMIN_OPTIONS 
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
    COPY INTO GENERATIONSALLIANCE.ADMIN_OPTIONS FROM (SELECT t.$1 AS FiscalYearEnd, t.$2 AS CompanyName, t.$3 AS Address, t.$4 AS City, t.$5 AS State, t.$6 AS Zip, t.$7 AS Phone, t.$8 AS TIN, t.$9 AS PayPeriodEndDay, t.$10 AS CalendarDisplayOption, t.$11 AS IsSSN, t.$12 AS EENumLength, t.$13 AS SplitTimesheetDays, t.$14 AS ShowSrvOnCal, t.$15 AS TypeOfCaregiver, t.$16 AS payOvertime, t.$17 AS CreateTS_ConfirmedOnly, t.$18 AS vendorGLAcct, t.$19 AS defaultConfirmed, t.$20 AS QbInvoiceDescr, t.$21 AS createBills, t.$22 AS providerNum, t.$23 AS ImagePath, t.$24 AS QbAPAcct, t.$25 AS tsNoteDetail, t.$26 AS passportID, t.$27 AS passportLocation, t.$28 AS createdBy, t.$29 AS created, t.$30 AS updatedBy, t.$31 AS lastUpdated, t.$32 AS securityOn, t.$33 AS loginsAllowed, t.$34 AS icd9Version, t.$35 AS ReadOnlyNotes, t.$36 AS inactivityTimeout, t.$37 AS showCalendarNotes, t.$38 AS localization, t.$39 AS telephonyLastUpload, t.$40 AS telephonyLastDownload, t.$41 AS telephonyFirstUpload, t.$42 AS createTsAvailShift, t.$43 AS ul, t.$44 AS telephonyID, t.$45 AS expDt, t.$46 AS telCgCustom, t.$47 AS acctSystem, t.$48 AS overtimewarning, t.$49 AS IndependentContractor, t.$50 AS ScheduleDateLastUpdated, t.$51 AS Tardy, t.$52 AS connectedusers, t.$53 AS clientTelephonyID, t.$54 AS vendorGLExpAcct, t.$55 AS telephonySystem, t.$56 AS linkAttachments, t.$57 AS bit_update_con_schedule, t.$58 AS bit_round_earlylogin, t.$59 AS telephonyUploadTill, t.$60 AS qbFlatRateHideTime, t.$61 AS logo, t.$62 AS logovalue, t.$63 AS bit_CmpNameOnReports, t.$64 AS bit_Canada2008, t.$65 AS bit_QBLog, t.$66 AS AgencyID, t.$67 AS int_MileageAct, t.$68 AS bit_ImportMileage, t.$69 AS str_tpwid, t.$70 AS str_tpwpassword, t.$71 AS str_servername, t.$72 AS int_CallIn, t.$73 AS int_CallOut, t.$74 AS str_CompanyID, t.$75 AS str_CompanyPassword, t.$76 AS int_RoundInterval, t.$77 AS int_ScheduleRoundInterval, t.$78 AS dtm_ProcessingDate, t.$79 AS bit_MissedAlert, t.$80 AS int_LateBy, t.$81 AS biwklyXfrStartDate, t.$82 AS Invoice_Number, t.$83 AS Estimate_Number, t.$84 AS Attach_Options, t.$85 AS Attach_Path, t.$86 AS IsARChecked, t.$87 AS AccountReceivable, t.$88 AS IsHosted, t.$89 AS AllowClientCGLogin, t.$90 AS FranchiseID, t.$91 AS QBVendorName, t.$92 AS CompatibleAppVersion, t.$93 AS AbbreviateNames, t.$94 AS RemoveClientPhone, t.$95 AS AllowCaregiversToPOC, t.$96 AS PagesinNewTab, t.$97 AS IsQBOE, t.$98 AS bit_ProcessManualExport, t.$99 AS hostedTelephonyOffset, t.$100 AS bit_OnlineApplicationEnabled, t.$101 AS bit_OnlineServiceEnabled, t.$102 AS EnableMileagePrompt, t.$103 AS ShowUnAvailable, t.$104 AS ShowTaskCompletedStatus, t.$105 AS AllowCGToViewAvailableshift, t.$106 AS bit_EmailCallCenterAssigned, t.$107 AS bit_EnableTotalHoursOnSchedule, t.$108 AS EnableClientViewTask, t.$109 AS EnableClientNotifications, t.$110 AS EnableClientViewPOC, t.$111 AS bit_RequireStrongPassword, t.$112 AS bit_UsePasswordFieldsOnScreen, t.$113 AS ConfirmContSchedules, t.$114 AS EnableCheckin, t.$115 AS bit_EnableFTEAlert, t.$116 AS int_FTEAlertHours, t.$117 AS OvertimeHours, t.$118 AS bit_EnableQuickConfirmGrid, t.$119 AS bit_EnableGPS, t.$120 AS dec_GPSVariance, t.$121 AS AutoMatchCallerId, t.$122 AS bit_BillableStatus, t.$123 AS CustomLogoWidth, t.$124 AS CustomLogoHeight, t.$125 AS bitLimitCalenderDateRange, t.$126 AS GeneralOptionsScheduleStartDate, t.$127 AS GeneralOptionsScheduleEndDate, t.$128 AS bit_MaskSSN, t.$129 AS allowCGtoAccessVisitNotes, t.$130 AS bitShiftVisitByClient, t.$131 AS bit_IncludeInactiveCGNoteType, t.$132 AS bit_IncludeInactiveClientNoteType, t.$133 AS bit_IncludeInactiveReferralNoteType, t.$134 AS bit_EnableOTPerWeek, t.$135 AS OTHourPerWeek, t.$136 AS bit_EnableOTPerDay, t.$137 AS OTHoursPerDay, t.$138 AS bit_EnableWeightedAvg, t.$139 AS bit_CgMissedAlert, t.$140 AS bit_disableVisitNoteTime, t.$141 AS bit_change_password_force, t.$142 AS password_duration, t.$143 AS bit_ReadOnlyConfirmedSchedules, t.$144 AS CalendarViewableType, t.$145 AS CalendarViewablePeriodType, t.$146 AS CalendarViewablePeriod, t.$147 AS EnableClientViewQuestion, t.$148 AS EnableFranchiseSetup, t.$149 AS is_MsdVstAlertMsg, t.$150 AS MsdVstAlertMsg, t.$151 AS int_LateByCG, t.$152 AS travel_enable, t.$153 AS Travel_clientId, t.$154 AS TrvlTimeDefRate, t.$155 AS itemName, t.$156 AS ServiceCode, t.$157 AS IncludeHolidayPremium, t.$158 AS EnableClientViewVisitNotes, t.$159 AS CalendarPeriodLimitType, t.$160 AS PriorRollingDays, t.$161 AS FutureRollingDays, t.$162 AS CalculateOTForIC, t.$163 AS CanadaTaxCode, t.$164 AS EmailDisclaimer, t.$165 AS EnableEmailDisclaimer, t.$166 AS EnableMockLocation, t.$167 AS ShowPayorOnCalendar, t.$168 AS EnableClientQA, t.$169 AS DefaultQA, t.$170 AS EnableQAonNewSchedules, t.$171 AS DoNotCallTimes, t.$172 AS DoNotCallStartTime, t.$173 AS DoNotCallEndTime, t.$174 AS bit_CustomMailServer, t.$175 AS SMTPHostAddress, t.$176 AS SMTPPassword, t.$177 AS SMTPPortNumber, t.$178 AS bit_UseTLS, t.$179 AS SMTPUserName, t.$180 AS ShowPItemOnCalendar, t.$181 AS bit_EnableConsecutiveVisit, t.$182 AS int_MinimumShiftDuration, t.$183 AS IsCallerIdMatch, t.$184 AS bit_AutoCaregiverNumber, t.$185 AS bit_DoNotAllowLoginOutsideGPS, t.$186 AS IsConfirmNoteRequired, t.$187 AS SantraxFtpID, t.$188 AS SantraxPassword, t.$189 AS SantraxID, t.$190 AS SantraxProcessingDate, t.$191 AS SantraxEmployeeLastExport, t.$192 AS SantraxScheduleLastExport, t.$193 AS SantraxLastImport, t.$194 AS SantraxEmployeeReqFields, t.$195 AS bitRoundShiftTo15Mins, t.$196 AS SantraxFTPFolder, t.$197 AS TravelTimeAlert, t.$198 AS Mileageaccount_Otherexpence_ServiceCode, t.$199 AS bit_enablemileagecalculation, t.$200 AS IsShowNeedsAlert, t.$201 AS bit_enableappnotification, t.$202 AS EnableElectronicSign, t.$203 AS IsLanguagePromtRequired, t.$204 AS ChartingNoteCompletionDays, t.$205 AS IsDisplayTelephonyID, t.$206 AS IsAutoAttachCallCenterNote, t.$207 AS bit_DashboardAccess, t.$208 AS MobileInactivityTimeout, t.$209 AS EnableMessageCenter, t.$210 AS bit_ReadOnlySignedSchedules, t.$211 AS SignatureTimeOption, t.$212 AS EnableVoiceSignature, t.$213 AS IsDisplayPayor, t.$214 AS RequiredCGVisitNote, t.$215 AS EnforcePasswordHistory, t.$216 AS bit_HideClientCategoriesAndQuestions, t.$217 AS bit_HideCGCategoriesAndQuestions, t.$218 AS IsTimeDecimalFormat, t.$219 AS decryptedSMTPassword, t.$220 AS HHAXID, t.$221 AS HHAXFtpID, t.$222 AS HHAXPassword, t.$223 AS HHAXEmployeeLastExport, t.$224 AS HHAXProcessingDate, t.$225 AS decryptedHHAXPassword, t.$226 AS bit_DisplayServiceShortDescription, t.$227 AS IsAzureEnabled, t.$228 AS AllowRequestShift, t.$229 AS PasswordMinLength, t.$230 AS EnableAmazonSES, t.$231 AS SantraxOHClientLastExport, t.$232 AS SantraxOHProviderID, t.$233 AS SantraxOHProcessingDate, t.$234 AS SantraxOHEmpLastExport, t.$235 AS SantraxOHVisitLastExport, t.$236 AS SantraxOHID, t.$237 AS SantraxOHUserName, t.$238 AS SantraxOHPassword, t.$239 AS decryptedSantraxOHPassword, t.$240 AS decryptedSantraxPassword, t.$241 AS OfflineMode, t.$242 AS bit_AdminOverride, t.$243 AS ShowVisitNotesInClientApp, t.$244 AS TellusMedicaidID, t.$245 AS TellusNPI, t.$246 AS TellusNPITaxonomy, t.$247 AS TellusClientID, t.$248 AS TellusUserName, t.$249 AS TellusPassword, t.$250 AS TellusProcessingDate, t.$251 AS TellusLastExport, t.$252 AS bit_Enable_Password_Auto_Reset, t.$253 AS Password_Auto_Reset_Duration, t.$254 AS EnableDMASTasksOnPOC, t.$255 AS TellusFTPPassword, t.$256 AS EnableCgScreening, t.$257 AS CgScreeningFailedMessage, t.$258 AS CgScreeningHoursAllowPrior, t.$259 AS Int_VisitLogout_LateBy, t.$260 AS Int_VisitLogout_LateByCG, t.$261 AS bit_CgMissedLogoutAlert, t.$262 AS is_MsdVstLogoutAlertMsg, t.$263 AS MsdVstLogout_AlertMsg, t.$264 AS ARProviderID, t.$265 AS EnableMassachusettsEVV, t.$266 AS MassHealthID, t.$267 AS SIMSConsumerID, t.$268 AS ProviderFEINNumber, t.$269 AS MassachusettsVisitLastExport, t.$270 AS ARUserName, t.$271 AS ARPassword, t.$272 AS ARJurisdictionID, t.$273 AS ARVisitLastExport, t.$274 AS ARProviderEmail, t.$275 AS ARProviderXRef, t.$276 AS AllowAuthenticareExport, t.$277 AS ARProcessingStartDate, t.$278 AS HHAXVisitLastExport, t.$279 AS HHAXClientID, t.$280 AS HHAXClientSecret, t.$281 AS NYMedicaidProviderName, t.$282 AS NYMedicaidProviderID, t.$283 AS NYMedicaidNPI, t.$284 AS NYMedicaidLastExport, t.$285 AS NYMedicaidProcessingDate, t.$286 AS MedicaidSubmitterID, t.$287 AS IsDisplayClientPhone, t.$288 AS CarebridgeFTPPAssword, t.$289 AS CarebridgeProviderID, t.$290 AS CarebridgeUsername, t.$291 AS CarebridgeLastExport, t.$292 AS CarebridgeBeginProcess, t.$293 AS RoundPayrollHours, t.$294 AS ARRoundingRules, t.$295 AS excludeDailyOtFromHolidayHours, t.$296 AS MassachusettsProviderID, t.$297 AS MassachusettsProviderSL, t.$298 AS EnableARFileExport, t.$299 AS EnableCGIncompleteTaskNote, t.$300 AS TellusPort, t.$301 AS AllowCarebridgeExport, t.$302 AS IsCBSpecificTimesheet, t.$303 AS IsEnableContShiftManually, t.$304 AS IsEnableEvvConflict, t.$305 AS iConnectID, t.$306 AS SantraxOHPasswordStrong, t.$307 AS SMTPPasswordStrong, t.$308 AS HHAXPasswordStrong, t.$309 AS SantraxPasswordStrong, t.$310 AS TellusPasswordStrong, t.$311 AS ARPasswordStrong, t.$312 AS HHAXClientSecretStrong, t.$313 AS SYS_CHANGE_VERSION, t.$314 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$314,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ADMIN_OPTIONS.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ADMIN_OPTIONS AS WITH curr_v AS (SELECT CompanyName, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ADMIN_OPTIONS GROUP BY CompanyName) SELECT t.* FROM GENERATIONSALLIANCE.ADMIN_OPTIONS t INNER JOIN curr_v v ON t.CompanyName = v.CompanyName AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';