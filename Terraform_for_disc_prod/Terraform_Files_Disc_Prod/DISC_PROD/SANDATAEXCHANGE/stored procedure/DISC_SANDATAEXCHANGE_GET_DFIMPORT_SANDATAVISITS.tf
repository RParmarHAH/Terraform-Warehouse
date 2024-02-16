resource "snowflake_procedure" "DISC_SANDATAEXCHANGE_GET_DFIMPORT_SANDATAVISITS" {
	name ="GET_DFIMPORT_SANDATAVISITS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAEXCHANGE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SanDataExchange.GET_DfImport_SanDataVisits 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SanDataExchange.HIST_DfImport_SanDataVisits FROM (SELECT t.$1 AS ImportVisitLineId, t.$2 AS VisitKey, t.$3 AS ImportTaskId, t.$4 AS TimesheetId, t.$5 AS AgencyId, t.$6 AS VisitId, t.$7 AS ClientId, t.$8 AS ClientName, t.$9 AS ClientLocation, t.$10 AS EmployeeId, t.$11 AS EmployeeName, t.$12 AS AdmissionTypeId, t.$13 AS ServiceCode, t.$14 AS EventId, t.$15 AS TimeIn, t.$16 AS TimeOut, t.$17 AS TimeZone, t.$18 AS StatusCode, t.$19 AS ImportBatchId, t.$20 AS ChangedTime, t.$21 AS ServiceDate, t.$22 AS Hours, t.$23 AS ImportedToDf, t.$24 AS AllowFutureImport, t.$25 AS UpdateTime, t.$26 AS UpdateTaskId, t.$27 AS ArchiveTime, t.$28 AS ReadTime, t.$29 AS ImportKey, t.$30 AS OriginalHours, t.$31 AS SYS_CHANGE_VERSION, t.$32 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$32,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAEXCHANGE/ (PATTERN => ''.*SanDataExchange_DfImport_SanDataVisits.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SanDataExchange.DfImport_SanDataVisits AS WITH curr_v AS (SELECT ImportVisitLineId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SanDataExchange.HIST_DfImport_SanDataVisits GROUP BY ImportVisitLineId) SELECT t.* FROM SanDataExchange.HIST_DfImport_SanDataVisits t INNER JOIN curr_v v ON t.ImportVisitLineId = v.ImportVisitLineId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

