CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_ERATE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_ERate 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.ERate (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS rateCode, t.$4 AS salary, t.$5 AS rate, t.$6 AS ratePer, t.$7 AS ecode, t.$8 AS cc1, t.$9 AS cc2, t.$10 AS cc3, t.$11 AS cc4, t.$12 AS cc5, t.$13 AS jobCode, t.$14 AS shift, t.$15 AS startDate, t.$16 AS endDate, t.$17 AS paygrade, t.$18 AS step, t.$19 AS guidfield, t.$20 AS lastChange, t.$21 AS lastChangeUser, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_ERate.*[.]csv.gz'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE EmpeonPreferred.ERate AS WITH curr_v AS (SELECT co, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmpeonPreferred.ERate GROUP BY co) SELECT t.* FROM EmpeonPreferred.ERate t INNER JOIN curr_v v ON t.co = v.co AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';