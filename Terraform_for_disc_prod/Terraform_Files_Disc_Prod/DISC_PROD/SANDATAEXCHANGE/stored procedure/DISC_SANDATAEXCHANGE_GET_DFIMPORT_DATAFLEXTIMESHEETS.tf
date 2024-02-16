resource "snowflake_procedure" "DISC_SANDATAEXCHANGE_GET_DFIMPORT_DATAFLEXTIMESHEETS" {
	name ="GET_DFIMPORT_DATAFLEXTIMESHEETS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SanDataExchange.GET_DfImport_DataFlexTimeSheets 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SanDataExchange.HIST_DfImport_DataFlexTimeSheets FROM (SELECT t.$1 AS Id, t.$2 AS ImportTaskId, t.$3 AS Operation, t.$4 AS Key, t.$5 AS IsValid, t.$6 AS SavedToDataFlex, t.$7 AS State, t.$8 AS RefNo, t.$9 AS TrackingId, t.$10 AS ClientNo, t.$11 AS EmployeeNo, t.$12 AS ContractCode, t.$13 AS BillCode, t.$14 AS PayrollDate, t.$15 AS WeekendDate, t.$16 AS OfficeNo, t.$17 AS SupervisorCode, t.$18 AS EvvCode, t.$19 AS TypeCode, t.$20 AS ChangedByCode, t.$21 AS AuditNumber, t.$22 AS SequenceNumber, t.$23 AS Timestamp, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAEXCHANGE/ (PATTERN => ''.*SanDataExchange_DfImport_DataFlexTimeSheets.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SanDataExchange.DfImport_DataFlexTimeSheets AS WITH curr_v AS (SELECT Id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SanDataExchange.HIST_DfImport_DataFlexTimeSheets GROUP BY Id) SELECT t.* FROM SanDataExchange.HIST_DfImport_DataFlexTimeSheets t INNER JOIN curr_v v ON t.Id = v.Id AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

