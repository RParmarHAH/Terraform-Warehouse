resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_OFFICE_OFFICES_REPL" {
	name ="GET_OFFICE_OFFICES_REPL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_Office_Offices_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Office_Offices_REPL (SELECT t.$1 AS AgencyID, t.$2 AS OfficeID, t.$3 AS OfficeName, t.$4 AS OfficeCode, t.$5 AS OfficeLevelID, t.$6 AS Active, t.$7 AS FederalTaxNumber, t.$8 AS NPI, t.$9 AS HICFA33b, t.$10 AS AgencyZipCode, t.$11 AS DefaultCoordinatorID, t.$12 AS Address1, t.$13 AS Address2, t.$14 AS City, t.$15 AS State, t.$16 AS ZipCode, t.$17 AS Phone, t.$18 AS Phone2, t.$19 AS TimeZone, t.$20 AS UseAddressForInvoice, t.$21 AS UseAddressForClinicalDoc, t.$22 AS ConexusPassword, t.$23 AS AccountingName, t.$24 AS AccountNumber, t.$25 AS TermsSpelled, t.$26 AS TermsInDays, t.$27 AS ValidateScheduleOvertime, t.$28 AS AdminUserEmail, t.$29 AS ExclusionList, t.$30 AS ExclusionListStartAsOn, t.$31 AS ExclusionListCancelledAsOn, t.$32 AS ExclusionListMD, t.$33 AS ExclusionListMDStartAsOn, t.$34 AS ExclusionListMDCancelledAsOn, t.$35 AS LiveInOTMins, t.$36 AS CaregiverOvertimeMins, t.$37 AS LiveInOTAfterMins, t.$38 AS UnBalancedToleranceMinutes, t.$39 AS IsDefault, t.$40 AS MobileFOBVerification, t.$41 AS MobileGPSVisitVerification, t.$42 AS GPSToleranceRange, t.$43 AS CaregiverInServiceOverlaps, t.$44 AS ConexusCode, t.$45 AS UniqueUrlID, t.$46 AS SuiTaxJurisdiction, t.$47 AS SpendDown, t.$48 AS SpendDownPeriodMonths, t.$49 AS SpendDownProcessDay, t.$50 AS MedicaidNumberValidationExpDisplay, t.$51 AS MedicaidNumberValidationExp, t.$52 AS MedicaidNumberValidationExpMsg, t.$53 AS DisplayMDOrderAideTabAs, t.$54 AS PrivateContractID, t.$55 AS TransportationByWalking, t.$56 AS TransportationByDriving, t.$57 AS TransportationByPublic, t.$58 AS CaregiverAbsenceOverlaps, t.$59 AS BeaconVerification, t.$60 AS MasterWeekRolloverTimeFrame, t.$61 AS CaregiverVerificationLists, t.$62 AS PhysicianVerificationLists, t.$63 AS EnableCaregiverVerificationList, t.$64 AS CaregiverVerificationListStartAsOn, t.$65 AS CaregiverVerificationListCancelAsOn, t.$66 AS EnablePhysicianVerificationList, t.$67 AS PhysicianVerificationListStartAsOn, t.$68 AS PhysicianVerificationListCancelAsOn, t.$69 AS ExclusionListState, t.$70 AS CaregiverOpenCasesView, t.$71 AS CaregiverOpenCasesRequestAccept, t.$72 AS CaregiverOpenCaseRequestLimit, t.$73 AS CaregiverOpenCaseRequestLimitValue, t.$74 AS CalculateAndPayOffDutyTime, t.$75 AS MaxODTMinutes, t.$76 AS AllowConsecutiveShifts, t.$77 AS SecondaryIdentifier, t.$78 AS EnableMobileAppOfflineSupport, t.$79 AS MobileOfflineSupportSynchPeriod, t.$80 AS EnableAutoAdjustSchedule, t.$81 AS CreatedBy, t.$82 AS CreatedDate, t.$83 AS CreatedUTCDate, t.$84 AS LastUpdatedBy, t.$85 AS LastUpdatedDate, t.$86 AS LastUpdatedUTCDate, t.$87 AS SYS_CHANGE_VERSION, t.$88 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$88,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_Office_Offices_REPL.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

