CREATE OR REPLACE PROCEDURE DISC_PROD.QUALTRICS_SURVEYS.GET_QUALTRICS_SURVEY_DISTRIBUTION_HISTORY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.QUALTRICS_SURVEYS.GET_QUALTRICS_SURVEY_DISTRIBUTION_HISTORY 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-11-30		Komal Dhokai			Removed TargetSQL
--*****************************************************************************************************************************

BEGIN 
   
    --ViewSQL
    INSERT OVERWRITE INTO DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_DISTRIBUTION_HISTORY SELECT a.$1,a.$2,a.$3,a.$4,a.$5,a.$6,a.$7,a.$8,a.$9,a.$10,a.$11,a.$12,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY,CURRENT_TIMESTAMP(),CURRENT_USER(),CURRENT_TIMESTAMP(),CURRENT_USER(),NULL FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Survey_Distribution_History/(file_format => DISC_PROD.STAGE.CSV_FORMAT) a;

    return ''Success'';
END;
';