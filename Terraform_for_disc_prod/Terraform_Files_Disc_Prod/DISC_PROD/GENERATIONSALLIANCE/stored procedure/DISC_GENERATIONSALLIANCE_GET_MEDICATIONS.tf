resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_MEDICATIONS" {
	name ="GET_MEDICATIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_medications 
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
    COPY INTO GENERATIONSALLIANCE.medications FROM (SELECT t.$1 AS clientID, t.$2 AS planOfCareId, t.$3 AS drugID, t.$4 AS Drug, t.$5 AS Dose, t.$6 AS Frequency, t.$7 AS Route, t.$8 AS OrderType, t.$9 AS createdBy, t.$10 AS created, t.$11 AS updatedBy, t.$12 AS lastUpdated, t.$13 AS StartDate, t.$14 AS DiscontinuedDate, t.$15 AS SortOrder, t.$16 AS Reason, t.$17 AS Notes, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_medications.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.medications AS WITH curr_v AS (SELECT clientID, planOfCareId, drugID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.medications GROUP BY clientID, planOfCareId, drugID) SELECT t.* FROM GENERATIONSALLIANCE.medications t INNER JOIN curr_v v ON t.clientID = v.clientID AND t.planOfCareId = v.planOfCareId AND t.drugID = v.drugID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

