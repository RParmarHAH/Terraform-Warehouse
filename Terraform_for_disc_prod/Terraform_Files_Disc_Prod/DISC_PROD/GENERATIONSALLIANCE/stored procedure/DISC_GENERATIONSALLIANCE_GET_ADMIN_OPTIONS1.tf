resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_ADMIN_OPTIONS1" {
	name ="GET_ADMIN_OPTIONS1"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_ADMIN_OPTIONS1 
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
    COPY INTO GENERATIONSALLIANCE.ADMIN_OPTIONS1 FROM (SELECT t.$1 AS CompanyName, t.$2 AS bit_OnlineApplicationEnabled, t.$3 AS bit_OnlineServiceEnabled, t.$4 AS OnlineApplicationEmails, t.$5 AS ApplicationUrlToRedirect, t.$6 AS ApplicationCustomMessage, t.$7 AS ServiceURLToRedirect, t.$8 AS ServiceCustomMessage, t.$9 AS OnlineServiceEmails, t.$10 AS bit_EnableDailyScheduleReminder, t.$11 AS UserEMailForScheduleReminderSummary, t.$12 AS EmailAccount_ScheduleReminder, t.$13 AS bitConvictedCrime, t.$14 AS CertificationText, t.$15 AS bitRequireSSN, t.$16 AS bitRemoveEODisclaimer, t.$17 AS bitEmergencyContactInfo, t.$18 AS EO_Disclaimer, t.$19 AS bit_IncludeCGAppNotification, t.$20 AS bit_IncludeCGTextNotification, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ADMIN_OPTIONS1.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ADMIN_OPTIONS1 AS WITH curr_v AS (SELECT CompanyName, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ADMIN_OPTIONS1 GROUP BY CompanyName) SELECT t.* FROM GENERATIONSALLIANCE.ADMIN_OPTIONS1 t INNER JOIN curr_v v ON t.CompanyName = v.CompanyName AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

