resource "snowflake_procedure" "DISC_SANDATAEXCHANGE_GET_DFIMPORT_DATAFLEXTIMESHEETVISITS" {
	name ="GET_DFIMPORT_DATAFLEXTIMESHEETVISITS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SanDataExchange.GET_DfImport_DataFlexTimeSheetVisits 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SanDataExchange.HIST_DfImport_DataFlexTimeSheetVisits FROM (SELECT t.$1 AS Id, t.$2 AS TimesheetId, t.$3 AS ServiceDate, t.$4 AS DateAbbreviation, t.$5 AS DeltaHours, t.$6 AS SYS_CHANGE_VERSION, t.$7 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$7,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAEXCHANGE/ (PATTERN => ''.*SanDataExchange_DfImport_DataFlexTimeSheetVisits.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SanDataExchange.DfImport_DataFlexTimeSheetVisits AS WITH curr_v AS (SELECT Id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SanDataExchange.HIST_DfImport_DataFlexTimeSheetVisits GROUP BY Id) SELECT t.* FROM SanDataExchange.HIST_DfImport_DataFlexTimeSheetVisits t INNER JOIN curr_v v ON t.Id = v.Id AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

