CREATE OR REPLACE PROCEDURE DISC_PROD.COSTALSYNCDATA.GET_GPALLPAYCODESBASE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.CostalSyncData.GET_GpAllPayCodesBase 
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
    COPY INTO DISC_PROD.CostalSyncData.HIST_GpAllPayCodesBase FROM (SELECT t.$1 AS DB, t.$2 AS PAY_CODE, t.$3 AS DESCRIPTION, t.$4 AS INACTIVE, t.$5 AS PAY_TYPE, t.$6 AS PAY_RATE, t.$7 AS PAY_UNIT, t.$8 AS PAY_PERIOD, t.$9 AS LAST_PAY_DATE, t.$10 AS BASED_ON_CODE, t.$11 AS SYS_CHANGE_VERSION, t.$12 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$12,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/COSTALSYNCDATA/ (PATTERN => ''.*CostalSyncData_dbo_GpAllPayCodesBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.CostalSyncData.GpAllPayCodesBase AS WITH curr_v AS (SELECT DB, PAY_CODE, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM CostalSyncData.HIST_GpAllPayCodesBase GROUP BY DB, PAY_CODE) SELECT t.* FROM CostalSyncData.HIST_GpAllPayCodesBase t INNER JOIN curr_v v ON t.DB = v.DB AND t.PAY_CODE = v.PAY_CODE AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';