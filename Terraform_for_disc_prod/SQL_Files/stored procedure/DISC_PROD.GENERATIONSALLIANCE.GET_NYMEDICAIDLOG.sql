CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_NYMEDICAIDLOG("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_NYMedicaidLog 
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
    COPY INTO GENERATIONSALLIANCE.NYMedicaidLog FROM (SELECT t.$1 AS MedicaidLogID, t.$2 AS TransactionID, t.$3 AS Submitdtm, t.$4 AS ScheduleID, t.$5 AS Client, t.$6 AS Caregiver, t.$7 AS Payor, t.$8 AS AltDesc, t.$9 AS Starttime, t.$10 AS Endtime, t.$11 AS JSONRequest, t.$12 AS JSONResponse, t.$13 AS Status, t.$14 AS Errors, t.$15 AS BatchID, t.$16 AS Type, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_NYMedicaidLog.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.NYMedicaidLog AS WITH curr_v AS (SELECT MedicaidLogID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.NYMedicaidLog GROUP BY MedicaidLogID) SELECT t.* FROM GENERATIONSALLIANCE.NYMedicaidLog t INNER JOIN curr_v v ON t.MedicaidLogID = v.MedicaidLogID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';