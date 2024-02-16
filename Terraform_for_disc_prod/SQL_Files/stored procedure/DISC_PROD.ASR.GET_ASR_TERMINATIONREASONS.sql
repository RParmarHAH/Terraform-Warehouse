CREATE OR REPLACE PROCEDURE DISC_PROD.ASR.GET_ASR_TERMINATIONREASONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ASR.GET_ASR_TERMINATIONREASONS 
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
    COPY INTO DISC_PROD.ASR.HIST_ASR_TERMINATIONREASONS FROM (SELECT A.$1 AS TERMINATION_REASON_ID, A.$2 AS TERMINATION_REASON_Name, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_TerminationReasons(file_format => DISC_PROD.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_TERMINATIONREASONS AS (SELECT TERMINATION_REASON_ID, TERMINATION_REASON_Name,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY,current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,current_user() AS ETL_INSERTED_BY,current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,current_user() AS ETL_LAST_UPDATED_BY,FALSE as ETL_DELETED_FLAG FROM DISC_PROD.ASR.HIST_ASR_TERMINATIONREASONS WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.ASR.HIST_ASR_TERMINATIONREASONS));

    return ''Success'';
END;
';