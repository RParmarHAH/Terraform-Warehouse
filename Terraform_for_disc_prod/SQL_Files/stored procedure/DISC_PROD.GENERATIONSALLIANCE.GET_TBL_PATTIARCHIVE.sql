CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_TBL_PATTIARCHIVE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_tbl_pattiarchive 
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
    COPY INTO GENERATIONSALLIANCE.tbl_pattiarchive FROM (SELECT t.$1 AS int_pattiarchiveid, t.$2 AS int_pattiid, t.$3 AS dtm_Savedt, t.$4 AS ClientId, t.$5 AS PhoneDialedTo, t.$6 AS PID, t.$7 AS Purpose, t.$8 AS EMID, t.$9 AS Lname, t.$10 AS Jname, t.$11 AS Clid, t.$12 AS Clid_Name, t.$13 AS W_Min, t.$14 AS Hrs, t.$15 AS f1, t.$16 AS f2, t.$17 AS f3, t.$18 AS f4, t.$19 AS M1, t.$20 AS T0, t.$21 AS D0, t.$22 AS Q0, t.$23 AS dtm_createddate, t.$24 AS int_scheduleid, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_tbl_pattiarchive.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.tbl_pattiarchive AS WITH curr_v AS (SELECT int_pattiarchiveid, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.tbl_pattiarchive GROUP BY int_pattiarchiveid) SELECT t.* FROM GENERATIONSALLIANCE.tbl_pattiarchive t INNER JOIN curr_v v ON t.int_pattiarchiveid = v.int_pattiarchiveid AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';