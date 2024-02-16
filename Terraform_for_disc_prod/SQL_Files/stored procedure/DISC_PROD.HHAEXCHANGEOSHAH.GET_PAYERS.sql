CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_PAYERS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_Payers 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.Payers (SELECT t.$1 AS AgencyID, t.$2 AS ChhaID, t.$3 AS ChhaName, t.$4 AS ChhaAddress1, t.$5 AS ChhaAddress2, t.$6 AS City, t.$7 AS State, t.$8 AS ZipCode, t.$9 AS Phone, t.$10 AS Fax, t.$11 AS ValidatePaperDutySheet, t.$12 AS GeneralEmail, t.$13 AS PaymentTerms, t.$14 AS Reason, t.$15 AS QBContractNumber, t.$16 AS QBTerms, t.$17 AS QBAccountingName, t.$18 AS QBTermsSpelled, t.$19 AS QBAccountNumber, t.$20 AS QBTermsInDays, t.$21 AS Notes, t.$22 AS IsReasonRequired, t.$23 AS WageParity, t.$24 AS AutomaticallyflagasTS, t.$25 AS CustomRollOver, t.$26 AS BillLinkingUnrecognizedNumber, t.$27 AS AutoSelectTimesheetRequiredForUnrecognizedNumber, t.$28 AS BillTimesheetNotApproved, t.$29 AS TimelyFilingLimit, t.$30 AS DutySheetTimeType, t.$31 AS DutySheetGroupBy, t.$32 AS DutySheetDisplayBilledHours, t.$33 AS DutySheetDisplayDateOfBirth, t.$34 AS DutySheetDisplayMedicaidNumber, t.$35 AS AuditVisitVerification, t.$36 AS AuditVisitDateAndTime, t.$37 AS AuditVisitSupervisor, t.$38 AS ModifiedDate, t.$39 AS ContractTypeName, t.$40 AS SYS_CHANGE_VERSION, t.$41 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$41,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_Payers.*[.]csv.gz'') T);

    return ''Success'';
END;
';