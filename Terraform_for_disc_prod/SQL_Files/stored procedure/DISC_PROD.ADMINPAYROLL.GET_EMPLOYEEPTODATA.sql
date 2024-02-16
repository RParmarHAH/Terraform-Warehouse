CREATE OR REPLACE PROCEDURE DISC_PROD.ADMINPAYROLL.GET_EMPLOYEEPTODATA("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.AdminPayroll.GET_EmployeePtoData 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-12-15		Komal Dhokai			Updated TargetSQL
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_PROD.AdminPayroll.HIST_EmployeePtoData FROM (SELECT t.$1 AS Key, t.$2 AS CompanyCode, t.$3 AS EmployeeId, t.$4 AS TimeStamp, t.$5 AS DataJson, t.$6 AS SYS_CHANGE_VERSION, t.$7 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$7,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/ADMINPAYROLL/ (PATTERN => ''.*AdminPayroll_pto_EmployeePtoData.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.AdminPayroll.EmployeePtoData AS WITH curr_v AS (SELECT Key, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_PROD.AdminPayroll.HIST_EmployeePtoData GROUP BY Key) SELECT t.* FROM DISC_PROD.AdminPayroll.HIST_EmployeePtoData t INNER JOIN curr_v v ON t.Key = v.Key AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';