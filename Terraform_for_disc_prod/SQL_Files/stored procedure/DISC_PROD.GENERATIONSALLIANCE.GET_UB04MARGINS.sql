CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_UB04MARGINS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_UB04Margins 
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
    COPY INTO GENERATIONSALLIANCE.UB04Margins FROM (SELECT t.$1 AS UB04MarginID, t.$2 AS leftMargin, t.$3 AS topMargin, t.$4 AS createdBy, t.$5 AS created, t.$6 AS updatedBy, t.$7 AS lastUpdated, t.$8 AS BillingProviderNPI, t.$9 AS Name, t.$10 AS Address, t.$11 AS City, t.$12 AS State, t.$13 AS Zip, t.$14 AS EnableAcknowledgmentRequest, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_UB04Margins.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.UB04Margins AS WITH curr_v AS (SELECT UB04MarginID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.UB04Margins GROUP BY UB04MarginID) SELECT t.* FROM GENERATIONSALLIANCE.UB04Margins t INNER JOIN curr_v v ON t.UB04MarginID = v.UB04MarginID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';