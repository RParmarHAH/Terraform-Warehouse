CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_EPREVEMPL("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_EPrevEmpl 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.EPrevEmpl (SELECT t.$1 AS co, t.$2 AS id, t.$3 AS employer, t.$4 AS startDate, t.$5 AS endDate, t.$6 AS salary, t.$7 AS salaryPer, t.$8 AS jobTitle, t.$9 AS notes, t.$10 AS termReason, t.$11 AS duties, t.$12 AS phone, t.$13 AS businessType, t.$14 AS supervisor, t.$15 AS canContact, t.$16 AS contacted, t.$17 AS guidfield, t.$18 AS lastChange, t.$19 AS lastChangeUser, t.$20 AS salaryEnd, t.$21 AS salaryEndPer, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_EPrevEmpl.*[.]csv.gz'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE EmpeonPreferred.EPrevEmpl AS WITH curr_v AS (SELECT co, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmpeonPreferred.EPrevEmpl GROUP BY co) SELECT t.* FROM EmpeonPreferred.EPrevEmpl t INNER JOIN curr_v v ON t.co = v.co AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';