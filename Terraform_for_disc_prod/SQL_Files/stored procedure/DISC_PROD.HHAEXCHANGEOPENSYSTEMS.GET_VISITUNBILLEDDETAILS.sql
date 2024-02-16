CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_VISITUNBILLEDDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_VisitUnbilledDetails 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.VisitUnbilledDetails (SELECT t.$1 AS AgencyID, t.$2 AS VisitUnbilledDetailID, t.$3 AS PatientID, t.$4 AS CaregiverID, t.$5 AS VisitDate, t.$6 AS PayerID, t.$7 AS TimesheetRequired, t.$8 AS TimesheetReceived, t.$9 AS IsSkilledVisit, t.$10 AS VisitRateID, t.$11 AS VisitRate, t.$12 AS VisitID, t.$13 AS DisciplineID, t.$14 AS CaregiverNotCompliant, t.$15 AS CaregiverOverlapping, t.$16 AS ClinicalDocNotCompliant, t.$17 AS InCompleteConfirmation, t.$18 AS InsufficientDutyMinutes, t.$19 AS InvalidOT, t.$20 AS MissingAbsenceCode, t.$21 AS MissingCaregiverSSN, t.$22 AS MissingHHAPCARegInfo, t.$23 AS MissingMedicaidCompliance, t.$24 AS MissingOTCode, t.$25 AS MissingServiceLocationCode, t.$26 AS MoreThan24Hours, t.$27 AS NoPOCAttachedToSchedule, t.$28 AS POCNotCompliant, t.$29 AS RestrictedCaregivers, t.$30 AS ScheduledWithHoldRate, t.$31 AS ShiftOverlapping, t.$32 AS TimesheetNotApproved, t.$33 AS TTOTNotApproved, t.$34 AS Unauthorized, t.$35 AS UnBalancedVisits, t.$36 AS VisitMissingPayCode, t.$37 AS WithTempCaregiver, t.$38 AS Prebilling, t.$39 AS Deleted, t.$40 AS ApprovedTravelTimeHours, t.$41 AS CreatedDate, t.$42 AS SYS_CHANGE_VERSION, t.$43 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$43,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_VisitUnbilledDetails.*[.]csv.gz'') T);

    return ''Success'';
END;
';