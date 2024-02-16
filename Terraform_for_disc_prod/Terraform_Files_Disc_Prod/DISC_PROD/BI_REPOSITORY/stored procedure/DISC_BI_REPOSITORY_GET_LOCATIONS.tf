resource "snowflake_procedure" "DISC_BI_REPOSITORY_GET_LOCATIONS" {
	name ="GET_LOCATIONS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "BI_REPOSITORY"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.BI_Repository.GET_Locations 
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
    COPY INTO BI_Repository.HIST_Locations FROM (SELECT t.$1 AS Id, t.$2 AS SysId, t.$3 AS ExternalLocationId, t.$4 AS LocSys, t.$5 AS DF_Code, t.$6 AS PayrollFreq, t.$7 AS PayrollBaseDate, t.$8 AS EVVLive, t.$9 AS SYS_CHANGE_VERSION, t.$10 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$10,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/BI_REPOSITORY/ (PATTERN => ''.*BI_Repository_dbo_Locations.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE BI_Repository.Locations AS WITH curr_v AS (SELECT Id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM BI_Repository.HIST_Locations GROUP BY Id) SELECT t.* FROM BI_Repository.HIST_Locations t INNER JOIN curr_v v ON t.Id = v.Id AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

