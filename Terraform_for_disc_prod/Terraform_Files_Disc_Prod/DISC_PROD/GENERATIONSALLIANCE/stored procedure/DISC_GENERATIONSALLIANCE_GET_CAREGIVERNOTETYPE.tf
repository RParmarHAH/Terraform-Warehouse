resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_CAREGIVERNOTETYPE" {
	name ="GET_CAREGIVERNOTETYPE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_caregiverNoteType 
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
    COPY INTO GENERATIONSALLIANCE.caregiverNoteType FROM (SELECT t.$1 AS noteTypeID, t.$2 AS description, t.$3 AS createdBy, t.$4 AS created, t.$5 AS updatedBy, t.$6 AS lastUpdated, t.$7 AS outlookSync, t.$8 AS Active, t.$9 AS MasterID, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_caregiverNoteType.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.caregiverNoteType AS WITH curr_v AS (SELECT noteTypeID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.caregiverNoteType GROUP BY noteTypeID) SELECT t.* FROM GENERATIONSALLIANCE.caregiverNoteType t INNER JOIN curr_v v ON t.noteTypeID = v.noteTypeID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

