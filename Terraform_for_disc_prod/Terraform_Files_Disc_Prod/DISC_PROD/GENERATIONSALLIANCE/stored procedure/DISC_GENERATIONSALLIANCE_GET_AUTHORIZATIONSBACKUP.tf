resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_AUTHORIZATIONSBACKUP" {
	name ="GET_AUTHORIZATIONSBACKUP"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_AuthorizationsBackup 
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
    COPY INTO GENERATIONSALLIANCE.AuthorizationsBackup FROM (SELECT t.$1 AS clientID, t.$2 AS serviceRequestId, t.$3 AS authorizationId, t.$4 AS authType, t.$5 AS allowedUnitOrAmt, t.$6 AS timespan, t.$7 AS createdBy, t.$8 AS created, t.$9 AS updatedBy, t.$10 AS lastUpdated, t.$11 AS maxAllowedUnitOrAmt, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_AuthorizationsBackup.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.AuthorizationsBackup AS WITH curr_v AS (SELECT clientID, serviceRequestId, authorizationId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.AuthorizationsBackup GROUP BY clientID, serviceRequestId, authorizationId) SELECT t.* FROM GENERATIONSALLIANCE.AuthorizationsBackup t INNER JOIN curr_v v ON t.clientID = v.clientID AND t.serviceRequestId = v.serviceRequestId AND t.authorizationId = v.authorizationId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

