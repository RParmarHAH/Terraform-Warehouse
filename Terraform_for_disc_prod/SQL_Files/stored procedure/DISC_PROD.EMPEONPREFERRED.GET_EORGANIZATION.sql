CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONPREFERRED.GET_EORGANIZATION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonPreferred.GET_EOrganization 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonPreferred.EOrganization (SELECT t.$1 AS organizationId, t.$2 AS co, t.$3 AS id, t.$4 AS startDate, t.$5 AS endDate, t.$6 AS department, t.$7 AS location, t.$8 AS division, t.$9 AS position, t.$10 AS floorUnit, t.$11 AS mailStop, t.$12 AS manager, t.$13 AS reason, t.$14 AS lastChange, t.$15 AS lastChangeUser, t.$16 AS Class, t.$17 AS team, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_EOrganization.*[.]csv.gz'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE EmpeonPreferred.EOrganization AS WITH curr_v AS (SELECT organizationId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmpeonPreferred.EOrganization GROUP BY organizationId) SELECT t.* FROM EmpeonPreferred.EOrganization t INNER JOIN curr_v v ON t.organizationId = v.organizationId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';