resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_SANTRAXOHLOG" {
	name ="GET_SANTRAXOHLOG"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_SantraxOHLog 
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
    COPY INTO GENERATIONSALLIANCE.SantraxOHLog FROM (SELECT t.$1 AS SantraxOHLogID, t.$2 AS LogDate, t.$3 AS Type, t.$4 AS Status, t.$5 AS Errors, t.$6 AS RecordID, t.$7 AS Details, t.$8 AS BatchID, t.$9 AS UUID, t.$10 AS Payor, t.$11 AS PayorProgram, t.$12 AS Service, t.$13 AS ProcedureCode, t.$14 AS LocationID, t.$15 AS ProviderID, t.$16 AS RequestID, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_SantraxOHLog.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.SantraxOHLog AS WITH curr_v AS (SELECT SantraxOHLogID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.SantraxOHLog GROUP BY SantraxOHLogID) SELECT t.* FROM GENERATIONSALLIANCE.SantraxOHLog t INNER JOIN curr_v v ON t.SantraxOHLogID = v.SantraxOHLogID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

