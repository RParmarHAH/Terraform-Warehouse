CREATE OR REPLACE PROCEDURE DISC_PROD.ASR.GET_ASR_BILLINGSUMMARY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ASR.GET_ASR_BILLINGSUMMARY 
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
    COPY INTO DISC_PROD.ASR.HIST_ASR_BillingSummary FROM (SELECT A.$1 AS Program, A.$2 AS CustomerName, A.$3 AS Service_Date, A.$4 AS Service_Type, A.$5 AS Scheduled_Hours, A.$6 AS Actual_Hours, A.$7 AS Employee_Name, A.$8 AS Customer_ID, A.$9 AS Employee_ID, A.$10 AS SERVICEVISITID, A.$11 AS SERVICEVISITACTUALID, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_BillingSummary(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_BILLINGSUMMARY AS WITH curr_v AS (SELECT SERVICEVISITACTUALID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_PROD.ASR.HIST_ASR_BILLINGSUMMARY GROUP BY SERVICEVISITACTUALID) SELECT t.* FROM DISC_PROD.ASR.HIST_ASR_BILLINGSUMMARY t INNER JOIN curr_v v ON t.SERVICEVISITACTUALID = v.SERVICEVISITACTUALID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';