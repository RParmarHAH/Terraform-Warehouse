CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_CLASS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_class 
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
    COPY INTO GENERATIONSALLIANCE.class FROM (SELECT t.$1 AS className, t.$2 AS classListId, t.$3 AS createdBy, t.$4 AS created, t.$5 AS updatedBy, t.$6 AS lastUpdated, t.$7 AS SYS_CHANGE_VERSION, t.$8 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$8,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_class.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.class AS WITH curr_v AS (SELECT className, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.class GROUP BY className) SELECT t.* FROM GENERATIONSALLIANCE.class t INNER JOIN curr_v v ON t.className = v.className AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';