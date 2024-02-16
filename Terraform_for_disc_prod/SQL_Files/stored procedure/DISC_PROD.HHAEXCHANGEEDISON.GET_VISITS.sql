CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_VISITS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_Visits 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.Visits (SELECT t.$1 AS AgencyID, t.$2 AS PatientID, t.$3 AS VisitID, t.$4 AS VisitDate, t.$5 AS ScheduledStartTime, t.$6 AS ScheduledEndTime, t.$7 AS IVRCallIn, t.$8 AS IVRCallOut, t.$9 AS VisitStartTime, t.$10 AS VisitEndTime, t.$11 AS Duties, t.$12 AS ApprovedTravelTimeHours, t.$13 AS MissedVisit, t.$14 AS TimesheetRequired, t.$15 AS TimesheetReceived, t.$16 AS PrimaryBillTo, t.$17 AS PrimaryServiceCode, t.$18 AS PrimaryContractHours, t.$19 AS PrimaryBillType, t.$20 AS Discipline, t.$21 AS SecondaryBillTo, t.$22 AS SecondaryServiceCode, t.$23 AS SecondaryContractHours, t.$24 AS SecondaryBillType, t.$25 AS Billed, t.$26 AS BilledHours, t.$27 AS TravelTimeHours, t.$28 AS OverTimeHours, t.$29 AS Billedamount, t.$30 AS InvoiceNumber, t.$31 AS InvoiceDate, t.$32 AS BatchNumber, t.$33 AS BillingExported, t.$34 AS BillingExportDate, t.$35 AS AideID, t.$36 AS Payrate, t.$37 AS Paid, t.$38 AS PaidDate, t.$39 AS PayrollBatchNumber, t.$40 AS PayrollExported, t.$41 AS PayrollExportDate, t.$42 AS PaidAmount, t.$43 AS PaidHours, t.$44 AS ThirdPartyAmount, t.$45 AS BilledRate, t.$46 AS ContractID, t.$47 AS PayerID, t.$48 AS OfficeID, t.$49 AS ImportID, t.$50 AS EVVSourceStartTime, t.$51 AS EVVTypeStartTime, t.$52 AS EVVSourceEndTime, t.$53 AS EVVTypeEndTime, t.$54 AS LastModifiedDate, t.$55 AS InvoiceDetailID, t.$56 AS SYS_CHANGE_VERSION, t.$57 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$57,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_Visits.*[.]csv.gz'')T);

    return ''Success'';
END;
';