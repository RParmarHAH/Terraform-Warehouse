CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_INITIALCONTACT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_InitialContact 
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
    COPY INTO GENERATIONSALLIANCE.InitialContact FROM (SELECT t.$1 AS InitialContactID, t.$2 AS Name, t.$3 AS Address1, t.$4 AS Address2, t.$5 AS City, t.$6 AS State, t.$7 AS Zip, t.$8 AS Relation, t.$9 AS Email, t.$10 AS Phone, t.$11 AS createdBy, t.$12 AS created, t.$13 AS updatedBy, t.$14 AS lastUpdated, t.$15 AS AlternatePhone, t.$16 AS EnableOnCarePlan, t.$17 AS County, t.$18 AS CountyID, t.$19 AS SYS_CHANGE_VERSION, t.$20 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$20,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_InitialContact.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.InitialContact AS WITH curr_v AS (SELECT InitialContactID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.InitialContact GROUP BY InitialContactID) SELECT t.* FROM GENERATIONSALLIANCE.InitialContact t INNER JOIN curr_v v ON t.InitialContactID = v.InitialContactID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';