CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_PATTI("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_patti 
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
    COPY INTO GENERATIONSALLIANCE.patti FROM (SELECT t.$1 AS pattiUnique, t.$2 AS scheduleID, t.$3 AS clientID, t.$4 AS socialsecnum, t.$5 AS scheduledStartTime, t.$6 AS scheduledEndTime, t.$7 AS VisitStartTime, t.$8 AS VisitEndTime, t.$9 AS RoundedStarttime, t.$10 AS RoundedEndTime, t.$11 AS milege, t.$12 AS updatedSchedule, t.$13 AS updatedStartTime, t.$14 AS updatedEndTime, t.$15 AS scheduleNotFound, t.$16 AS str_callerId, t.$17 AS str_callername, t.$18 AS int_purposeid, t.$19 AS str_purpose, t.$20 AS str_employeename, t.$21 AS str_clientname, t.$22 AS int_workmin, t.$23 AS str_workhours, t.$24 AS f1, t.$25 AS f2, t.$26 AS f3, t.$27 AS f4, t.$28 AS T0, t.$29 AS D0, t.$30 AS Q0, t.$31 AS dtm_created, t.$32 AS SYS_CHANGE_VERSION, t.$33 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$33,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_patti.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.patti AS WITH curr_v AS (SELECT pattiUnique, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.patti GROUP BY pattiUnique) SELECT t.* FROM GENERATIONSALLIANCE.patti t INNER JOIN curr_v v ON t.pattiUnique = v.pattiUnique AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';