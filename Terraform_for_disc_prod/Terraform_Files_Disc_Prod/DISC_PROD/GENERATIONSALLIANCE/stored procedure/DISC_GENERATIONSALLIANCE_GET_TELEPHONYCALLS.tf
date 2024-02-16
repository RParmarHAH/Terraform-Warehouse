resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_TELEPHONYCALLS" {
	name ="GET_TELEPHONYCALLS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_TelephonyCalls 
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
    COPY INTO GENERATIONSALLIANCE.TelephonyCalls FROM (SELECT t.$1 AS callsid, t.$2 AS accountsid, t.$3 AS agencyid, t.$4 AS status, t.$5 AS version, t.$6 AS cfrom, t.$7 AS cto, t.$8 AS direction, t.$9 AS callername, t.$10 AS fcity, t.$11 AS fstate, t.$12 AS fzip, t.$13 AS fcountry, t.$14 AS tocity, t.$15 AS tostate, t.$16 AS tozip, t.$17 AS tocountry, t.$18 AS duration, t.$19 AS CostPerMinute, t.$20 AS billableMinutes, t.$21 AS StartTime, t.$22 AS EndTime, t.$23 AS CallExpense, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_TelephonyCalls.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.TelephonyCalls AS WITH curr_v AS (SELECT callsid, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.TelephonyCalls GROUP BY callsid) SELECT t.* FROM GENERATIONSALLIANCE.TelephonyCalls t INNER JOIN curr_v v ON t.callsid = v.callsid AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

