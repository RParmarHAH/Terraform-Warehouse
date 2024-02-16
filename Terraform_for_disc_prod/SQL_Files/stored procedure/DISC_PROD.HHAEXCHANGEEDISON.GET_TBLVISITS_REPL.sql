CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_TBLVISITS_REPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_tblVisits_REPL 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.tblVisits_REPL (SELECT t.$1 AS AgencyID, t.$2 AS VisitID, t.$3 AS MasterWeekHeaderID, t.$4 AS AllocationID, t.$5 AS Deleted, t.$6 AS PatientID, t.$7 AS CoordinatorID, t.$8 AS CaregiverID, t.$9 AS POCHeaderID, t.$10 AS VisitDate, t.$11 AS ScheduledStartTime, t.$12 AS ScheduledEndTime, t.$13 AS VisitStartTime, t.$14 AS VisitEndTime, t.$15 AS ApprovedStatus, t.$16 AS ApprovedOverTimeHours, t.$17 AS ApprovedTravelTimeHours, t.$18 AS Billed, t.$19 AS POCCompliant, t.$20 AS HasOpenEvent, t.$21 AS ImportReference, t.$22 AS UpdateComments, t.$23 AS UpdateReasonID, t.$24 AS vDiscipline, t.$25 AS PayerID, t.$26 AS ValidatePaperDutySheet, t.$27 AS PermanentDelete, t.$28 AS OfficeID, t.$29 AS UpdateVisitActionTakenReason, t.$30 AS AccruedMinuteVisit, t.$31 AS Createdby, t.$32 AS CreatedDate, t.$33 AS LastModifiedBy, t.$34 AS LastModifiedDate, t.$35 AS IsMissedVisit, t.$36 AS SYS_CHANGE_VERSION, t.$37 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$37,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_tblVisits_REPL.*[.]csv.gz'')T);

    return ''Success'';
END;
';