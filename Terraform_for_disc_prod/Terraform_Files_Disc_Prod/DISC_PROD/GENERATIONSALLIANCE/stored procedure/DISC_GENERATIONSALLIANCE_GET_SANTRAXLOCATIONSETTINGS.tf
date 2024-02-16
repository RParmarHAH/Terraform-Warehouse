resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_SANTRAXLOCATIONSETTINGS" {
	name ="GET_SANTRAXLOCATIONSETTINGS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_SantraxLocationSettings 
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
    COPY INTO GENERATIONSALLIANCE.SantraxLocationSettings FROM (SELECT t.$1 AS LocationSettingsID, t.$2 AS LocationID, t.$3 AS SantraxID, t.$4 AS ProviderID, t.$5 AS UserID, t.$6 AS Password, t.$7 AS Created, t.$8 AS CreatedBy, t.$9 AS LastUpdated, t.$10 AS UpdatedBy, t.$11 AS SandataGroupId, t.$12 AS PasswordStrong, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_SantraxLocationSettings.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.SantraxLocationSettings AS WITH curr_v AS (SELECT LocationSettingsID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.SantraxLocationSettings GROUP BY LocationSettingsID) SELECT t.* FROM GENERATIONSALLIANCE.SantraxLocationSettings t INNER JOIN curr_v v ON t.LocationSettingsID = v.LocationSettingsID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

