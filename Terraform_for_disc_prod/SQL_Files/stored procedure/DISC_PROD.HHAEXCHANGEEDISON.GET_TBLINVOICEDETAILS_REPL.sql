CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_TBLINVOICEDETAILS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_tblInvoiceDetails_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.tblInvoiceDetails_REPL (SELECT t.$1 AS AgencyID, t.$2 AS InvoiceDetailID, t.$3 AS InvoiceHeaderID, t.$4 AS VisitID, t.$5 AS CaregiverID, t.$6 AS VisitStartTime, t.$7 AS VisitEndTime, t.$8 AS BilledHours, t.$9 AS BilledRate, t.$10 AS OverTimeHours, t.$11 AS OverTimeRate, t.$12 AS TravelTimeHours, t.$13 AS TravelTimeRate, t.$14 AS BilledAmount, t.$15 AS VisitDate, t.$16 AS PatientID, t.$17 AS PayerID, t.$18 AS InvServiceCodeID, t.$19 AS InvContractServiceCode, t.$20 AS InvRateType, t.$21 AS VisitPaymentStatus, t.$22 AS BilledUnits, t.$23 AS AuthorizationNumber, t.$24 AS LastExportedDate, t.$25 AS PatientPaidAmount, t.$26 AS InvoiceDetailID3rdParty, t.$27 AS EBillingHold, t.$28 AS PayerReferenceNumber, t.$29 AS OfficeID, t.$30 AS SubmissionDate, t.$31 AS SubmissionUTCDate, t.$32 AS EbillingHoldReasonText, t.$33 AS DFTAVisit, t.$34 AS ExternalScheduleID, t.$35 AS ExternalInvoiceNumber, t.$36 AS ExternalClaimNumber, t.$37 AS BillingLineItemID, t.$38 AS CreatedBy, t.$39 AS CreatedDate, t.$40 AS CreatedUTCDate, t.$41 AS UpdatedBy, t.$42 AS UpdatedDate, t.$43 AS UpdatedUTCDate, t.$44 AS SYS_CHANGE_VERSION, t.$45 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$45,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_tblInvoiceDetails_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;
';