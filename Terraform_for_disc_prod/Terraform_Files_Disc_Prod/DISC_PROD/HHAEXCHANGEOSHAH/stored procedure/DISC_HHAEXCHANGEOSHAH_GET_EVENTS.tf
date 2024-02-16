resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_EVENTS" {
	name ="GET_EVENTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_Events 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.Events (SELECT t.$1 AS AgencyID, t.$2 AS EventID, t.$3 AS VisitID, t.$4 AS EventType, t.$5 AS VisitDate, t.$6 AS EventDateUTC, t.$7 AS ScheduledTime, t.$8 AS ChangeInServiceDateFrom, t.$9 AS ChangeInServiceDateTo, t.$10 AS PreviousCaregiverID, t.$11 AS NewCaregiverID, t.$12 AS OverTimeRequestHoursInMinutes, t.$13 AS TravelTimeRequestHoursInMinutes, t.$14 AS ApprovedHoursInMinutes, t.$15 AS ApprovedDateUTC, t.$16 AS ApprovedByUserName, t.$17 AS EventStatus, t.$18 AS DischargeDate, t.$19 AS Reason, t.$20 AS Comments, t.$21 AS CreatedByUserName, t.$22 AS OfficeID, t.$23 AS PatientID, t.$24 AS PayerID, t.$25 AS CreatedDate, t.$26 AS UpdatedDate, t.$27 AS SYS_CHANGE_VERSION, t.$28 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$28,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_Events.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

