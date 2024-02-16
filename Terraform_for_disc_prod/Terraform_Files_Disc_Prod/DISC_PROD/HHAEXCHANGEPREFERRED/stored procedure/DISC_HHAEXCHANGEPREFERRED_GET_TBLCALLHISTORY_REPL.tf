resource "snowflake_procedure" "DISC_HHAEXCHANGEPREFERRED_GET_TBLCALLHISTORY_REPL" {
	name ="GET_TBLCALLHISTORY_REPL"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.GET_tblCallHistory_REPL 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.tblCallHistory_REPL  (SELECT t.$1 AS AgencyID, t.$2 AS CallHistoryID, t.$3 AS VisitID, t.$4 AS AssignmentID, t.$5 AS CallTime, t.$6 AS CallDuration, t.$7 AS Type, t.$8 AS CallStatus, t.$9 AS TasksPerformed, t.$10 AS CallerID, t.$11 AS LinkedBy, t.$12 AS LinkedDate, t.$13 AS EVVType, t.$14 AS EVVSource, t.$15 AS Longitude, t.$16 AS Latitude, t.$17 AS EVVPatientId, t.$18 AS LinkedUTCDate, t.$19 AS CaregiverID, t.$20 AS AutoScheduleServiceTypeID, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_tblCallHistory_REPL.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;

 EOT
}

