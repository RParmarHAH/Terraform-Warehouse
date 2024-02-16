resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_CLIENTNOTESDELETED" {
	name ="GET_CLIENTNOTESDELETED"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_clientNotesDeleted 
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
    COPY INTO GENERATIONSALLIANCE.clientNotesDeleted FROM (SELECT t.$1 AS ClientId, t.$2 AS NoteDate, t.$3 AS NoteTime, t.$4 AS Description, t.$5 AS createdBy, t.$6 AS created, t.$7 AS updatedBy, t.$8 AS lastUpdated, t.$9 AS noteTypeID, t.$10 AS NotePriority, t.$11 AS scheduleID, t.$12 AS CallID, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_clientNotesDeleted.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.clientNotesDeleted AS WITH curr_v AS (SELECT ClientId, NoteDate, NoteTime, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.clientNotesDeleted GROUP BY ClientId, NoteDate, NoteTime) SELECT t.* FROM GENERATIONSALLIANCE.clientNotesDeleted t INNER JOIN curr_v v ON t.ClientId = v.ClientId AND t.NoteDate = v.NoteDate AND t.NoteTime = v.NoteTime AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

