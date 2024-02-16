CREATE OR REPLACE PROCEDURE DISC_PROD.ASR.GET_ASR_LOCATIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ASR.GET_ASR_LOCATIONS 
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
    COPY INTO DISC_PROD.ASR.HIST_ASR_Locations FROM (SELECT A.$1 AS LocationID, A.$2 AS LocationName, A.$3 AS NotificationEmail, A.$4 AS EVV_Authetnication, A.$5 AS EVV_ID, A.$6 AS EVV_Uses_UAT, A.$7 AS Provider_MEDICAID_ID, A.$8 AS LOCATIONNUMBER, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_Locations(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_LOCATIONS AS WITH curr_v AS (SELECT LOCATIONID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_PROD.ASR.HIST_ASR_LOCATIONS GROUP BY LOCATIONID) SELECT t.* FROM DISC_PROD.ASR.HIST_ASR_LOCATIONS t INNER JOIN curr_v v ON t.LOCATIONID = v.LOCATIONID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';