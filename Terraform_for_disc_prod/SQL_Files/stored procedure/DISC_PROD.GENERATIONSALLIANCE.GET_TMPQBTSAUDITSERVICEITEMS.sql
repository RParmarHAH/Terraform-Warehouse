CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_TMPQBTSAUDITSERVICEITEMS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_tmpQbTsAuditServiceItems 
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
    COPY INTO GENERATIONSALLIANCE.tmpQbTsAuditServiceItems FROM (SELECT t.$1 AS serviceDescr, t.$2 AS Description, t.$3 AS cost, t.$4 AS qbCost, t.$5 AS SYS_CHANGE_VERSION, t.$6 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$6,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tmpQbTsAuditServiceItems.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tmpQbTsAuditServiceItems AS WITH curr_v AS (SELECT serviceDescr, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tmpQbTsAuditServiceItems GROUP BY serviceDescr) SELECT t.* FROM GENERATIONSALLIANCE.tmpQbTsAuditServiceItems t INNER JOIN curr_v v ON t.serviceDescr = v.serviceDescr AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';