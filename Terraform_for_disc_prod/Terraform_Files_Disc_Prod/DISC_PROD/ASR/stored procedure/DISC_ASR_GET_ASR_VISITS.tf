resource "snowflake_procedure" "DISC_ASR_GET_ASR_VISITS" {
	name ="GET_ASR_VISITS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_VISITS 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_VISITS FROM ( SELECT A.$1 AS VisitDate, A.$2 AS ServiceVisitID, A.$3 AS VisitStartDate, A.$4 AS VisitEndDate, A.$5 AS HoursAssigned, A.$6 AS WeekDay, A.$7 AS CheckInTime, A.$8 AS VisitFee, A.$9 AS VisitRate, A.$10 AS MilesToDrive, A.$11 AS AllowedExtraTime, A.$12 AS ServiceType, A.$13 AS CustomerID, A.$14 AS EmployeeID, A.$15 AS AutoEmailLateCheckIns, A.$16 AS IgnoreLastTwoDigits, A.$17 AS ReceivableFee, A.$18 AS ReceivableRate, A.$19 AS RecurrenceType, A.$20 AS PayerSourceID, A.$21 AS HoursAssignedOrigSched, A.$22 AS RequireSignatures, A.$23 AS DrivingCompensationAmount, A.$24 AS DrivingCompensationRate, A.$25 AS ProgramID_SV, A.$26 AS ServiceVisitActualID, A.$27 AS TimeCheckedIn, A.$28 AS TimeCheckedOut, A.$29 AS IsCancelled, A.$30 AS RescheduledTo, A.$31 AS ResponcibleForCancelation, A.$32 AS CancelationComments, A.$33 AS CommLogRecordID, A.$34 AS EmpCommLogRecID, A.$35 AS RandomCheck, A.$36 AS RescheduledEmployeeID, A.$37 AS LateCheckInNotification, A.$38 AS CheckedInFrom, A.$39 AS CheckedOutFrom, A.$40 AS RescheduledVisitRate, A.$41 AS RescheduledVisitFee, A.$42 AS CustomerNotified, A.$43 AS EmployeeNotified, A.$44 AS HoursCredited, A.$45 AS VisitStatusID, A.$46 AS IsFinal, A.$47 AS TimeCheckedInIsFinal, A.$48 AS TimeCheckedOutIsFinal, A.$49 AS IsPaid, A.$50 AS VisitNotes, A.$51 AS IsTrimmedOverMaxShift, A.$52 AS BillingCodeID, A.$53 AS HoursApproved, A.$54 AS MilesToMakeVisit, A.$55 AS TimeToMakeVisit, A.$56 AS ChInLat, A.$57 AS ChInLong, A.$58 AS ChOutLat, A.$59 AS ChOutLong, A.$60 AS EVV_SequenceID, A.$61 AS EVV_ReasonCodeID, A.$62 AS EVV_ReasonMemo, A.$63 AS EVV_ExceptionsCleared, A.$64 AS EVV_ClientSignatureIsEmpty, A.$65 AS ObservationsNoted, A.$66 AS SupervisorNotifiedOfObservationsNoted, A.$67 AS EVV_TransactionID, A.$68 AS EVV_LastSubmittedOn, A.$69 AS DocumentationReceived, A.$70 AS ActualVisitDate, A.$71 AS EVV_PayDate, A.$72 AS ScheduledCheckIn, A.$73 AS ScheduledCheckOut, A.$74 AS ScheduledCheckInOrigSched, A.$75 AS ScheduledCheckOutOrigSched, A.$76 AS ProgramID, A.$77 AS HomePhone, A.$78 AS EmployeeHomePhone, A.$79 AS CustomerZipCode, A.$80 AS EmployeeZipCode, A.$81 AS CustomerName, A.$82 AS EmployeeName, A.$83 AS ActualOrScheduledCheckIn, A.$84 AS ActualOrScheduledCheckOut, A.$85 AS CancelationCommentsUsable, A.$86 AS Rate, A.$87 AS RateType, A.$88 AS MilageCompensation, A.$89 AS IsFirstVisit, A.$90 AS CoPay, A.$91 AS ZoneID, A.$92 AS LocationID, A.$93 AS CustomerNumCommRecrods, A.$94 AS EmployeeNumCommRecrods, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_Visits(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_VISITS AS WITH curr_v AS (SELECT SERVICEVISITACTUALID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_VISITS WHERE SERVICEVISITACTUALID IS NOT NULL GROUP BY SERVICEVISITACTUALID) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_VISITS T INNER JOIN curr_v v ON t.SERVICEVISITACTUALID = v.SERVICEVISITACTUALID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE WHERE CASE WHEN TRY_TO_DATE(TRIM(T.VISITDATE), ''MM/DD/YYYY HH12:MI:SS AM'') <> TRY_TO_DATE(COALESCE(TRIM(T.TIMECHECKEDIN), TRIM(T.RESCHEDULEDTO)), ''MM/DD/YYYY HH12:MI:SS AM'') THEN TRY_TO_DATE(COALESCE(TRIM(T.TIMECHECKEDIN), TRIM(T.RESCHEDULEDTO)), ''MM/DD/YYYY HH12:MI:SS AM'') ELSE TRY_TO_DATE(TRIM(T.VISITDATE), ''MM/DD/YYYY HH12:MI:SS AM'') END <= ''10/22/2023'' ;

    return ''Success'';
END;

 EOT
}

