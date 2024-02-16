resource "snowflake_procedure" "DISC_ASR_GET_ASR_PLANOFSERVICE" {
	name ="GET_ASR_PLANOFSERVICE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_PLANOFSERVICE 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_PlanOfService FROM (SELECT A.$1 AS ServiceVisitID, A.$2 AS CustomerID, A.$3 AS WeekDay, A.$4 AS EmployeeID, A.$5 AS HoursAssigned, A.$6 AS CheckInTime, A.$7 AS VisitFee, A.$8 AS Notes, A.$9 AS VisitStartDate, A.$10 AS VisitEndDate, A.$11 AS RecurrenceType, A.$12 AS MilesToDrive, A.$13 AS AllowedExtraTime, A.$14 AS VisitRate, A.$15 AS ServiceType, A.$16 AS EARLY_CHECKIN_ALLOWED_MINUTES, A.$17 AS AutoEmailLateCheckIns, A.$18 AS ForceClientPhoneUse, A.$19 AS IgnoreLastTwoDigits, A.$20 AS ReceivableRate, A.$21 AS ReceivableFee, A.$22 AS PayerSourceID, A.$23 AS CreatedOn, A.$24 AS CreatedBy, A.$25 AS LastModifiedOn, A.$26 AS LastModifiedBy, A.$27 AS BillingCodeID, A.$28 AS RequireSignatures, A.$29 AS NoGPSVerification, A.$30 AS DrivingCompensationAmount, A.$31 AS DrivingCompensationRate, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_PlanOfService(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_PLANOFSERVICE AS WITH curr_v AS (SELECT SERVICEVISITID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_PLANOFSERVICE GROUP BY SERVICEVISITID) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_PLANOFSERVICE t INNER JOIN curr_v v ON t.SERVICEVISITID = v.SERVICEVISITID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

