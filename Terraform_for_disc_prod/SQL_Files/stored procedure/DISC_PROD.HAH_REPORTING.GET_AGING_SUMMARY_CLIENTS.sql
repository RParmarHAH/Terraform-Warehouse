CREATE OR REPLACE PROCEDURE DISC_PROD.HAH_REPORTING.GET_AGING_SUMMARY_CLIENTS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HAH_Reporting.GET_aging_summary_Clients 
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
    COPY INTO DISC_PROD.HAH_Reporting.HIST_aging_summary_Clients FROM (SELECT t.$1 AS DfDb, t.$2 AS ClientNumber, t.$3 AS LastName, t.$4 AS FirstName, t.$5 AS OfficeNumber, t.$6 AS SupervisorCode, t.$7 AS BillOffice, t.$8 AS Agent, t.$9 AS RegionCode, t.$10 AS SYS_CHANGE_VERSION, t.$11 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$11,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/HAH_REPORTING/ (PATTERN => ''.*HAH_Reporting_aging_summary_Clients.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE HAH_Reporting.aging_summary_Clients AS WITH curr_v AS (SELECT DfDb, ClientNumber, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM HAH_Reporting.HIST_aging_summary_Clients GROUP BY DfDb, ClientNumber) SELECT t.* FROM HAH_Reporting.HIST_aging_summary_Clients t INNER JOIN curr_v v ON t.DfDb = v.DfDb AND t.ClientNumber = v.ClientNumber AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';