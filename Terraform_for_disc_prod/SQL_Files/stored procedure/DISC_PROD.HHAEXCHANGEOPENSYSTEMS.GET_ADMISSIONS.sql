CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_ADMISSIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_Admissions 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.Admissions (SELECT t.$1 AS AdmissionID, t.$2 AS PlacementID, t.$3 AS AgencyID, t.$4 AS PatientID, t.$5 AS ContractID, t.$6 AS ContractType, t.$7 AS ChhaID, t.$8 AS AltPatientID, t.$9 AS StartDate, t.$10 AS SourceOfAdmissionID, t.$11 AS ServiceCodeID, t.$12 AS DischargeDate, t.$13 AS DischargeTo, t.$14 AS DischargeNote, t.$15 AS CreatedDate, t.$16 AS CreatedBy, t.$17 AS UpdatedDate, t.$18 AS UpdatedBy, t.$19 AS DischargeReason, t.$20 AS HasSurplus, t.$21 AS SurplusAmount, t.$22 AS ContractPaysPercent, t.$23 AS PrivatePaysPercent, t.$24 AS DeductibleAmount, t.$25 AS DeductibleDuration, t.$26 AS AmountLimitPerDay, t.$27 AS AmountLimitPerWeek, t.$28 AS AmountLimitPerMonth, t.$29 AS ScanFileName, t.$30 AS ScanFileGUID, t.$31 AS SecSubscriberRelation, t.$32 AS SecSubscriberFirstName, t.$33 AS SecSubscriberLastName, t.$34 AS SecSubscriberInsuranceNumber, t.$35 AS SecSubscriberAddress1, t.$36 AS SecSubscriberAddress2, t.$37 AS SecSubscriberCity, t.$38 AS SecSubscriberState, t.$39 AS SecSubscriberZipCode, t.$40 AS SecInsName, t.$41 AS SecSubscriberInsurancePayerNumber, t.$42 AS ClaimFillingCode, t.$43 AS IncludeSecPayerInfoEbillingExport, t.$44 AS SecSubscriberAsPatientName, t.$45 AS SecSubscriberAddressType, t.$46 AS SecondaryPaysPercent, t.$47 AS SecondaryChhaID, t.$48 AS MonthlyBilling, t.$49 AS MonthlyBillingDay, t.$50 AS MonthlyBillingDate, t.$51 AS MonthlyServicecodeID, t.$52 AS MonthlyCaregiverID, t.$53 AS MonthlyPayrateID, t.$54 AS MonthlyStartTime, t.$55 AS MonthlyEndTime, t.$56 AS admOfficeID, t.$57 AS DeductibleAndAmountLimitApplyOn, t.$58 AS MultiPayerVisitType, t.$59 AS DFTAPatient, t.$60 AS PrivatePayServiceCodeID, t.$61 AS ContractBillingDiagnosisCodes, t.$62 AS LimitMaximumPayerContributionPerPeriod, t.$63 AS AuthLimitPerDay, t.$64 AS AuthLimitPerWeek, t.$65 AS AuthLimitPerMonth, t.$66 AS AuthLimitPerYear, t.$67 AS AuthLimitPerLifeTime, t.$68 AS LimitForAdditionalInvoice, t.$69 AS PaymentAdjustmentReasonID, t.$70 AS PaymentAdjustmentReason, t.$71 AS EliminationPeriod, t.$72 AS EliminationPeriodDays, t.$73 AS EliminationPeriodCountDaysType, t.$74 AS EliminationPeriodAdjustmentReasonID, t.$75 AS EliminationPeriodAdjustmentReason, t.$76 AS EliminationPeriodStartDate, t.$77 AS BillingStarted, t.$78 AS LimitForAdditionalInvoiceName, t.$79 AS PayerRankID, t.$80 AS PayerPlacementID, t.$81 AS PreventDischargeDateUpdate, t.$82 AS SYS_CHANGE_VERSION, t.$83 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$83,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_Admissions.*[.]csv.gz'') T);

    return ''Success'';
END;
';