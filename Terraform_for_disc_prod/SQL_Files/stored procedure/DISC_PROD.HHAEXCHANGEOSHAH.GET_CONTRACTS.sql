CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_CONTRACTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_Contracts 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.Contracts (SELECT t.$1 AS AgencyID, t.$2 AS ContractID, t.$3 AS ChhaID, t.$4 AS ContractName, t.$5 AS Address1, t.$6 AS Address2, t.$7 AS City, t.$8 AS State, t.$9 AS ZipCode, t.$10 AS Phone, t.$11 AS Fax, t.$12 AS AuthorizationRequired, t.$13 AS ValidatePaperDutySheet, t.$14 AS RequiredCompliance, t.$15 AS ContactPerson, t.$16 AS GeneralEmail, t.$17 AS PaymentTerms, t.$18 AS Reason, t.$19 AS QBExportContractNumber, t.$20 AS QBExportTerms, t.$21 AS QBAccountingName, t.$22 AS QBTermsSpelled, t.$23 AS QBAccountNumber, t.$24 AS QBTermsInDays, t.$25 AS Notes, t.$26 AS IsReasonRequired, t.$27 AS WageParity, t.$28 AS AutomaticallyflagasTS, t.$29 AS CustomRollOver, t.$30 AS BillLinkingUnrecognizedNumber, t.$31 AS AutoSelectTimesheetRequiredForUnrecognizedNumber, t.$32 AS BillTimesheetNotApproved, t.$33 AS IsVNSContract, t.$34 AS TimelyFilingLimit, t.$35 AS DutySheetTimeType, t.$36 AS DutySheetGroupBy, t.$37 AS DutySheetDisplayBilledHours, t.$38 AS DutySheetDisplayDateOfBirth, t.$39 AS DutySheetDisplayMedicaidNumber, t.$40 AS AuditVisitVerification, t.$41 AS AuditVisitDateAndTime, t.$42 AS AuditVisitSupervisor, t.$43 AS ContractTypeName, t.$44 AS ModifiedDate, t.$45 AS AuthorizationWeekID, t.$46 AS AuthorizationWeek, t.$47 AS LinkedContractPayerID, t.$48 AS BillingConfigurationRoundingMinsDuration, t.$49 AS BillingConfigurationRoundingMinsBy, t.$50 AS SYS_CHANGE_VERSION, t.$51 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$49,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_Contracts.*[.]csv.gz'') T);

    return ''Success'';
END;
';