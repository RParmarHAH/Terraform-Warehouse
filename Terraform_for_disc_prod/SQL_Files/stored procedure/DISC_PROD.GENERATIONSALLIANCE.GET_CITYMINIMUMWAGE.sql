CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_CITYMINIMUMWAGE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_CityMinimumWage 
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
    COPY INTO GENERATIONSALLIANCE.CityMinimumWage FROM (SELECT t.$1 AS WageID, t.$2 AS City, t.$3 AS MinimumWage, t.$4 AS Created, t.$5 AS CreatedBy, t.$6 AS Updated, t.$7 AS UpdatedBy, t.$8 AS SYS_CHANGE_VERSION, t.$9 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$9,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_CityMinimumWage.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.CityMinimumWage AS WITH curr_v AS (SELECT WageID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.CityMinimumWage GROUP BY WageID) SELECT t.* FROM GENERATIONSALLIANCE.CityMinimumWage t INNER JOIN curr_v v ON t.WageID = v.WageID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';