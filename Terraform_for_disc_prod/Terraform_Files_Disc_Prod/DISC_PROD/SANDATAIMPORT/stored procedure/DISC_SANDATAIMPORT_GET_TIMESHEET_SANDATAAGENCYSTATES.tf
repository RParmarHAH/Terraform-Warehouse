resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_TIMESHEET_SANDATAAGENCYSTATES" {
	name ="GET_TIMESHEET_SANDATAAGENCYSTATES"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_TimeSheet_SandataAgencyStates 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_TimeSheet_SandataAgencyStates FROM (SELECT t.$1 AS AgencyId, t.$2 AS State, t.$3 AS FullState, t.$4 AS OfficeNumber, t.$5 AS EVVDate, t.$6 AS WeekEndDate_DayName, t.$7 AS Hash, t.$8 AS CreatedAt, t.$9 AS ModifiedAt, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_TimeSheet_SandataAgencyStates.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.TimeSheet_SandataAgencyStates AS WITH curr_v AS (SELECT AgencyId, State, OfficeNumber, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_TimeSheet_SandataAgencyStates GROUP BY AgencyId, State, OfficeNumber) SELECT t.* FROM SandataImport.HIST_TimeSheet_SandataAgencyStates t INNER JOIN curr_v v ON t.AgencyId = v.AgencyId AND t.State = v.State AND t.OfficeNumber = v.OfficeNumber AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

