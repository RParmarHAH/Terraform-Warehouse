CREATE OR REPLACE PROCEDURE DISC_PROD.ADMINPAYROLL.GET_PTOBANKDATA("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AdminPayroll.GET_PtoBankData 
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
    COPY INTO DISC_PROD.AdminPayroll.HIST_PtoBankData FROM (SELECT t.$1 AS Key, t.$2 AS TimeStamp, t.$3 AS Code, t.$4 AS Name, t.$5 AS IsAccrual, t.$6 AS IsActive, t.$7 AS TargetPayCode, t.$8 AS DataJson, t.$9 AS SYS_CHANGE_VERSION, t.$10 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$10,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/ADMINPAYROLL/ (PATTERN => ''.*DISC_PROD.AdminPayroll_pto_PtoBankData.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.AdminPayroll.PtoBankData AS WITH curr_v AS (SELECT Key, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_PROD.AdminPayroll.HIST_PtoBankData GROUP BY Key) SELECT t.* FROM DISC_PROD.AdminPayroll.HIST_PtoBankData t INNER JOIN curr_v v ON t.Key = v.Key AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';