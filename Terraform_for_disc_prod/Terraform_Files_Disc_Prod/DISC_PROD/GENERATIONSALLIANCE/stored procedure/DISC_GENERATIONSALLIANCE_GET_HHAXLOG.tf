resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_HHAXLOG" {
	name ="GET_HHAXLOG"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_HHAXLog 
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
    COPY INTO GENERATIONSALLIANCE.HHAXLog FROM (SELECT t.$1 AS HHAXLogID, t.$2 AS LogDate, t.$3 AS Type, t.$4 AS Status, t.$5 AS Errors, t.$6 AS RecordID, t.$7 AS Details, t.$8 AS LogFileName, t.$9 AS HHAXStateCode, t.$10 AS PayorID, t.$11 AS MedRecNum, t.$12 AS ServiceAltDesc, t.$13 AS ScheduleStartTime, t.$14 AS ScheduleEndTime, t.$15 AS StatusRetryCount, t.$16 AS EVVMSID, t.$17 AS BatchID, t.$18 AS TransactionID, t.$19 AS UnitsPerHour, t.$20 AS APIStatusCode, t.$21 AS APIResponse, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_HHAXLog.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.HHAXLog AS WITH curr_v AS (SELECT HHAXLogID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.HHAXLog GROUP BY HHAXLogID) SELECT t.* FROM GENERATIONSALLIANCE.HHAXLog t INNER JOIN curr_v v ON t.HHAXLogID = v.HHAXLogID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

