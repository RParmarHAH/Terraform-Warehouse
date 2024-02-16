resource "snowflake_procedure" "DISC_HHAEXCHANGEOSHAH_GET_REJECTEDCALLS" {
	name ="GET_REJECTEDCALLS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.GET_RejectedCalls 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOSHAH.RejectedCalls (SELECT t.$1 AS AgencyID, t.$2 AS RejectedCallID, t.$3 AS MaintenanceID, t.$4 AS AssignmentID, t.$5 AS CaregiverID, t.$6 AS CaregiverName, t.$7 AS CaregiverCode, t.$8 AS OfficeID, t.$9 AS OfficeName, t.$10 AS CaregiverPhone1, t.$11 AS CaregiverPhone2, t.$12 AS CaregiverTeam, t.$13 AS PatientName, t.$14 AS CallDate, t.$15 AS CallTime, t.$16 AS CallType, t.$17 AS CallerID, t.$18 AS Status, t.$19 AS EVVSource, t.$20 AS EVVType, t.$21 AS DutysheetCount, t.$22 AS CreatedBy, t.$23 AS CreatedDate, t.$24 AS UpdatedBy, t.$25 AS UpdatedDate, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OSHAH/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOSHAH_dbo_RejectedCalls.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

