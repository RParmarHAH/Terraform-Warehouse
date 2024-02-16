CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_EVVWITHOUTSCHEDULEDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_EVVwithoutScheduleDetails 
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
    COPY INTO GENERATIONSALLIANCE.EVVwithoutScheduleDetails FROM (SELECT t.$1 AS EVVwithoutScheduleDetailsID, t.$2 AS LoginPattiID, t.$3 AS LogoutPattiID, t.$4 AS ServiceCode, t.$5 AS ScheduleSignatureID, t.$6 AS Notes, t.$7 AS SYS_CHANGE_VERSION, t.$8 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$8,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_EVVwithoutScheduleDetails.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.EVVwithoutScheduleDetails AS WITH curr_v AS (SELECT EVVwithoutScheduleDetailsID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.EVVwithoutScheduleDetails GROUP BY EVVwithoutScheduleDetailsID) SELECT t.* FROM GENERATIONSALLIANCE.EVVwithoutScheduleDetails t INNER JOIN curr_v v ON t.EVVwithoutScheduleDetailsID = v.EVVwithoutScheduleDetailsID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';