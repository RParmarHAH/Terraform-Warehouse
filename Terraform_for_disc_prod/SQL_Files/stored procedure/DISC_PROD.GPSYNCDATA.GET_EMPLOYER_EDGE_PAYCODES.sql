CREATE OR REPLACE PROCEDURE DISC_PROD.GPSYNCDATA.GET_EMPLOYER_EDGE_PAYCODES("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GpSyncData.GET_EMPLOYER_EDGE_PAYCODES 
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
    COPY INTO DISC_PROD.GpSyncData.HIST_EMPLOYER_EDGE_PAYCODES FROM (SELECT t.$1 AS COMPANY_CODE, t.$2 AS PAY_CODE, t.$3 AS TYPE_CODE, t.$4 AS IN_USE, t.$5 AS COUNT_HOURS, t.$6 AS COMMENT, t.$7 AS CATEGORY, t.$8 AS IsHomeCare, t.$9 AS IsSkilled, t.$10 AS IsDD, t.$11 AS State, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_EMPLOYER_EDGE_PAYCODES.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.EMPLOYER_EDGE_PAYCODES AS WITH curr_v AS (SELECT COMPANY_CODE, PAY_CODE, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_EMPLOYER_EDGE_PAYCODES GROUP BY COMPANY_CODE, PAY_CODE) SELECT t.* FROM GpSyncData.HIST_EMPLOYER_EDGE_PAYCODES t INNER JOIN curr_v v ON t.COMPANY_CODE = v.COMPANY_CODE AND t.PAY_CODE = v.PAY_CODE AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';