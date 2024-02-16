CREATE OR REPLACE PROCEDURE DISC_PROD.GPSYNCDATA.GET_GPALLEMPLOYEESFEDERALTAXBASE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GpSyncData.GET_GpAllEmployeesFederalTaxBase 
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
    COPY INTO DISC_PROD.GpSyncData.HIST_GpAllEmployeesFederalTaxBase FROM (SELECT t.$1 AS Db, t.$2 AS Employee_ID, t.$3 AS FederalFilingStatusCode, t.$4 AS FederalFilingStatusNumber, t.$5 AS FederalMaritalStatus, t.$6 AS FederalExempt, t.$7 AS FederalWithholding, t.$8 AS AdditionalWithholding, t.$9 AS EstimatedWithholding, t.$10 AS LocalTaxCode, t.$11 AS TaxWithholdingState, t.$12 AS MarriedWithholdingAsSingle, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_GpAllEmployeesFederalTaxBase.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.GpAllEmployeesFederalTaxBase AS WITH curr_v AS (SELECT Db, Employee_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_GpAllEmployeesFederalTaxBase GROUP BY Db, Employee_ID) SELECT t.* FROM GpSyncData.HIST_GpAllEmployeesFederalTaxBase t INNER JOIN curr_v v ON t.Db = v.Db AND t.Employee_ID = v.Employee_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';