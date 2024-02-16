resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_USERLOGIN" {
	name ="GET_USERLOGIN"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_UserLogin 
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
    COPY INTO GENERATIONSALLIANCE.UserLogin FROM (SELECT t.$1 AS UserLoginID, t.$2 AS AgencyID, t.$3 AS UserID, t.$4 AS RoleID, t.$5 AS ParentToken, t.$6 AS RemoteHostAddress, t.$7 AS SessionStart, t.$8 AS SessionEnd, t.$9 AS LastAccessed, t.$10 AS LoggedOut, t.$11 AS IsQbSync, t.$12 AS isMobile, t.$13 AS AppVersion, t.$14 AS IsForcedLogout, t.$15 AS AdminName, t.$16 AS AppRegId, t.$17 AS IsConcurrentLogin, t.$18 AS LoggedOutSource, t.$19 AS DeviceDetails, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_UserLogin.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.UserLogin AS WITH curr_v AS (SELECT UserLoginID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.UserLogin GROUP BY UserLoginID) SELECT t.* FROM GENERATIONSALLIANCE.UserLogin t INNER JOIN curr_v v ON t.UserLoginID = v.UserLoginID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

