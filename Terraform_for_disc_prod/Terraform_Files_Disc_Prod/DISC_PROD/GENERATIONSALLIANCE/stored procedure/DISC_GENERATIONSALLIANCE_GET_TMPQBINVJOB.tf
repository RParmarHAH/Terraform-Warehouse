resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TMPQBINVJOB" {
	name ="GET_TMPQBINVJOB"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_tmpQBInvJob 
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
    COPY INTO GENERATIONSALLIANCE.tmpQBInvJob FROM (SELECT t.$1 AS employee, t.$2 AS sumTotalHours, t.$3 AS client, t.$4 AS clientID, t.$5 AS tsdate, t.$6 AS description, t.$7 AS modifier, t.$8 AS client_quickbooksid, t.$9 AS services_quickbooksid, t.$10 AS type, t.$11 AS receivedtimecard, t.$12 AS starttime, t.$13 AS endtime, t.$14 AS billable, t.$15 AS qbFullname, t.$16 AS classname, t.$17 AS flatRate, t.$18 AS authNumber, t.$19 AS casemanager, t.$20 AS cost, t.$21 AS locationID, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tmpQBInvJob.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tmpQBInvJob AS WITH curr_v AS (SELECT employee, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tmpQBInvJob GROUP BY employee) SELECT t.* FROM GENERATIONSALLIANCE.tmpQBInvJob t INNER JOIN curr_v v ON t.employee = v.employee AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

