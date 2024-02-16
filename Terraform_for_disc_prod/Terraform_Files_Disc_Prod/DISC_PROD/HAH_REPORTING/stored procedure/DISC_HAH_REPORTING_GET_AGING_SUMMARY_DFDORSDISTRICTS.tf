resource "snowflake_procedure" "DISC_HAH_REPORTING_GET_AGING_SUMMARY_DFDORSDISTRICTS" {
	name ="GET_AGING_SUMMARY_DFDORSDISTRICTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAH_REPORTING"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.HAH_Reporting.GET_aging_summary_DfDorsDistricts 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.HAH_Reporting.HIST_aging_summary_DfDorsDistricts FROM (SELECT t.$1 AS DfDb, t.$2 AS ServiceAreaCode, t.$3 AS DistrictCode, t.$4 AS SYS_CHANGE_VERSION, t.$5 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$5,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/HAH_REPORTING/ (PATTERN => ''.*HAH_Reporting_aging_summary_DfDorsDistricts.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE HAH_Reporting.aging_summary_DfDorsDistricts AS WITH curr_v AS (SELECT DfDb, ServiceAreaCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM HAH_Reporting.HIST_aging_summary_DfDorsDistricts GROUP BY DfDb, ServiceAreaCode) SELECT t.* FROM HAH_Reporting.HIST_aging_summary_DfDorsDistricts t INNER JOIN curr_v v ON t.DfDb = v.DfDb AND t.ServiceAreaCode = v.ServiceAreaCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

