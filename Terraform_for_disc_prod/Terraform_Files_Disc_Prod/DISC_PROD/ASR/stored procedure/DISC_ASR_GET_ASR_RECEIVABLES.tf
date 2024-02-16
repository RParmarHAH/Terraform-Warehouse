resource "snowflake_procedure" "DISC_ASR_GET_ASR_RECEIVABLES" {
	name ="GET_ASR_RECEIVABLES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_RECEIVABLES 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_RECEIVABLES FROM (SELECT A.$1 AS VisitDate, A.$2 AS ServiceVisitID, A.$3 AS ServiceType, A.$4 AS CustomerID, A.$5 AS EmployeeID, A.$6 AS PayerSourceID, A.$7 AS HoursAssignedOrigSched, A.$8 AS ServiceVisitActualID, A.$9 AS TimeCheckedIn, A.$10 AS TimeCheckedOut, A.$11 AS IsCancelled, A.$12 AS RescheduledTo, A.$13 AS ResponcibleForCancelation, A.$14 AS CancelationComments, A.$15 AS CommLogRecordID, A.$16 AS EmpCommLogRecID, A.$17 AS RandomCheck, A.$18 AS RescheduledEmployeeID, A.$19 AS LateCheckInNotification, A.$20 AS CheckedInFrom, A.$21 AS CheckedOutFrom, A.$22 AS RescheduledVisitRate, A.$23 AS RescheduledVisitFee, A.$24 AS CustomerNotified, A.$25 AS EmployeeNotified, A.$26 AS HoursCredited, A.$27 AS VisitStatusID, A.$28 AS IsFinal, A.$29 AS TimeCheckedInIsFinal, A.$30 AS TimeCheckedOutIsFinal, A.$31 AS IsPaid, A.$32 AS VisitNotes, A.$33 AS IsTrimmedOverMaxShift, A.$34 AS BillingCodeID, A.$35 AS HoursApproved, A.$36 AS MilesToMakeVisit, A.$37 AS TimeToMakeVisit, A.$38 AS ChInLat, A.$39 AS ChInLong, A.$40 AS ChOutLat, A.$41 AS ChOutLong, A.$42 AS EVV_SequenceID, A.$43 AS EVV_ReasonCodeID, A.$44 AS EVV_ReasonMemo, A.$45 AS EVV_ExceptionsCleared, A.$46 AS EVV_ClientSignatureIsEmpty, A.$47 AS ObservationsNoted, A.$48 AS SupervisorNotifiedOfObservationsNoted, A.$49 AS EVV_TransactionID, A.$50 AS EVV_LastSubmittedOn, A.$51 AS DocumentationReceived, A.$52 AS ActualVisitDate, A.$53 AS EVV_PayDate, A.$54 AS ScheduledCheckIn, A.$55 AS ScheduledCheckOut, A.$56 AS ScheduledCheckInOrigSched, A.$57 AS ScheduledCheckOutOrigSched, A.$58 AS ProgramID, A.$59 AS HomePhone, A.$60 AS EmployeeHomePhone, A.$61 AS CustomerZipCode, A.$62 AS EmployeeZipCode, A.$63 AS CustomerName, A.$64 AS EmployeeName, A.$65 AS ActualOrScheduledCheckIn, A.$66 AS ActualOrScheduledCheckOut, A.$67 AS CancelationCommentsUsable, A.$68 AS Rate, A.$69 AS RateType, A.$70 AS MilageCompensation, A.$71 AS IsFirstVisit, A.$72 AS CoPay, A.$73 AS ZoneID, A.$74 AS LocationID, A.$75 AS SupervisorID, A.$76 AS CustomerNumCommRecrods, A.$77 AS EmployeeNumCommRecrods, A.$78 AS ScheduledDuration, A.$79 AS ActualDuration, A.$80 AS ActualDurationAdjusted, A.$81 AS BillableHours,A.$82 AS EarnedAmount, A.$83 AS MilesCompensation, A.$84 AS PayrollDeductions, A.$85 AS NonTaxablePayrollDeductions, A.$86 AS TotalEarnedAmount, A.$87 AS RequiredHours, A.$88 AS ReceivableAmount, A.$89 AS ReceivableFeeOrRate, A.$90 AS ProfitAmount, A.$91 AS IsBilled, A.$92 AS BillingTransactionID, A.$93 AS BillingDate, A.$94 AS InvoiceNumber, A.$95 AS InvoiceNumberExtern, A.$96 AS BillingPremium, A.$97 AS BillingPremiumTag, A.$98 AS BilledAmount, A.$99 AS Memo_ReceivableFeeOrRate, A.$100 AS Memo_BillableHours, A.$101 AS BillingMemo, A.$102 AS LastModifiedOn, A.$103 AS ClaimNumber, A.$104 AS rank, A.$105 as DateCheckedIn,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_Receivables(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_ZIPCODES) A);					

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_RECEIVABLES AS WITH curr_v AS (SELECT BILLINGTRANSACTIONID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_Receivables GROUP BY BILLINGTRANSACTIONID) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_Receivables t INNER JOIN curr_v v ON t.BILLINGTRANSACTIONID = v.BILLINGTRANSACTIONID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

