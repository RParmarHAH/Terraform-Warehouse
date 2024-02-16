CREATE OR REPLACE PROCEDURE DISC_PROD.HAH_REPORTING.GET_AGING_SUMMARY_BILLINGPERSONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HAH_Reporting.GET_aging_summary_BillingPersons 
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
    COPY INTO DISC_PROD.HAH_Reporting.HIST_aging_summary_BillingPersons FROM (SELECT t.$1 AS DfDb, t.$2 AS PersonCode, t.$3 AS PersonName, t.$4 AS BillOffice, t.$5 AS SYS_CHANGE_VERSION, t.$6 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$6,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/HAH_REPORTING/ (PATTERN => ''.*HAH_Reporting_aging_summary_BillingPersons.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE HAH_Reporting.aging_summary_BillingPersons AS WITH curr_v AS (SELECT DfDb, PersonCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM HAH_Reporting.HIST_aging_summary_BillingPersons GROUP BY DfDb, PersonCode) SELECT t.* FROM HAH_Reporting.HIST_aging_summary_BillingPersons t INNER JOIN curr_v v ON t.DfDb = v.DfDb AND t.PersonCode = v.PersonCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';