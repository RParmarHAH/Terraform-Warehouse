CREATE OR REPLACE PROCEDURE DISC_PROD.GPSYNCDATA.GET_GPALLEMPLOYEESTATETAXBASE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GpSyncData.GET_GpAllEmployeeStateTaxBase 
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
    COPY INTO DISC_PROD.GpSyncData.HIST_GpAllEmployeeStateTaxBase FROM (SELECT t.$1 AS DB, t.$2 AS EMPLOYEE_ID, t.$3 AS State_Code, t.$4 AS Exempt, t.$5 AS Withholding, t.$6 AS FilingStatus, t.$7 AS FilingStatusText, t.$8 AS Inactive, t.$9 AS SYS_CHANGE_VERSION, t.$10 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$10,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_GpAllEmployeeStateTaxBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.GpAllEmployeeStateTaxBase AS WITH curr_v AS (SELECT DB, EMPLOYEE_ID, State_Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_GpAllEmployeeStateTaxBase GROUP BY DB, EMPLOYEE_ID, State_Code) SELECT t.* FROM GpSyncData.HIST_GpAllEmployeeStateTaxBase t INNER JOIN curr_v v ON t.DB = v.DB AND t.EMPLOYEE_ID = v.EMPLOYEE_ID AND t.State_Code = v.State_Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';