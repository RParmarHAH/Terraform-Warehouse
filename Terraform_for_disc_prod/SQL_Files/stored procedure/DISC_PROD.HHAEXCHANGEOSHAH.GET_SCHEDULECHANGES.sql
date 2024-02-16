CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOSHAH.GET_SCHEDULECHANGES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOSHAH.GET_ScheduleChanges 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOSHAH.ScheduleChanges (SELECT t.$1 AS AgencyID, t.$2 AS ScheduleID, t.$3 AS InvoiceDetailID, t.$4 AS ScheduleType, t.$5 AS VisitDate, t.$6 AS PatientID, t.$7 AS ScheduledStartTime, t.$8 AS ScheduledEndTime, t.$9 AS CaregiverID, t.$10 AS PayRateID, t.$11 AS POCID, t.$12 AS PayerID, t.$13 AS PrimaryContractID, t.$14 AS PrimaryServiceCodeID, t.$15 AS VisitStartTime, t.$16 AS VisitEndTime, t.$17 AS IsMissedVisit, t.$18 AS TimesheetRequired, t.$19 AS EVVStartTime, t.$20 AS EVVEndTime, t.$21 AS VerifiedBy, t.$22 AS VerifiedText, t.$23 AS DateVerified, t.$24 AS TimeVerified, t.$25 AS Supervisor, t.$26 AS TimesheetApproved, t.$27 AS DutiesPerformed, t.$28 AS TravelTimeMinutes, t.$29 AS Billed, t.$30 AS BilledMinutes, t.$31 AS InvoiceNumber, t.$32 AS PayrollPaid, t.$33 AS PayrollBatchNumber, t.$34 AS ModifiedDate, t.$35 AS IsDeleted, t.$36 AS OfficeID, t.$37 AS SYS_CHANGE_VERSION, t.$38 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$38,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_ScheduleChanges.*[.]csv.gz'') T);

    return ''Success'';
END;
';