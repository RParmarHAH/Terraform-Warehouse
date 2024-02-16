CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_CLIENTPAYORCODE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_ClientPayorCode 
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
    COPY INTO GENERATIONSALLIANCE.ClientPayorCode FROM (SELECT t.$1 AS ClientID, t.$2 AS PayorID, t.$3 AS ProcedureCode, t.$4 AS CreatedOn, t.$5 AS CreatedBY, t.$6 AS IsDeleted, t.$7 AS Updated, t.$8 AS UpdatedBY, t.$9 AS servicecode, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ClientPayorCode.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ClientPayorCode AS WITH curr_v AS (SELECT ClientID, PayorID, ProcedureCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ClientPayorCode GROUP BY ClientID, PayorID, ProcedureCode) SELECT t.* FROM GENERATIONSALLIANCE.ClientPayorCode t INNER JOIN curr_v v ON t.ClientID = v.ClientID AND t.PayorID = v.PayorID AND t.ProcedureCode = v.ProcedureCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';