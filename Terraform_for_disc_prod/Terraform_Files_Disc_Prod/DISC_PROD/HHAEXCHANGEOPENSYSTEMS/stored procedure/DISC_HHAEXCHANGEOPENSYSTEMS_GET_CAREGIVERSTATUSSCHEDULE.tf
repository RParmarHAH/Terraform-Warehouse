resource "snowflake_procedure" "DISC_HHAEXCHANGEOPENSYSTEMS_GET_CAREGIVERSTATUSSCHEDULE" {
	name ="GET_CAREGIVERSTATUSSCHEDULE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.GET_CaregiverStatusSchedule 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.CaregiverStatusSchedule (SELECT t.$1 AS AgencyID, t.$2 AS StatusScheduleID, t.$3 AS CaregiverID, t.$4 AS ScheduleDate, t.$5 AS StatusID, t.$6 AS CurrentStatus, t.$7 AS ReasonID, t.$8 AS Note, t.$9 AS CreatedBy, t.$10 AS CreatedDate, t.$11 AS TerminationDate, t.$12 AS Sent105, t.$13 AS UpdatedBy, t.$14 AS UpdatedDate, t.$15 AS StatusChanged, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_CaregiverStatusSchedule.*[.]csv.gz'') T);

    return ''Success'';
END;

 EOT
}

