CREATE OR REPLACE PROCEDURE DISC_PROD.QUALTRICS_SURVEYS.GET_CC_BOUNCED("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.QUALTRICS_SURVEYS.GET_CC_BOUNCED 
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
    INSERT INTO DISC_PROD.QUALTRICS_SURVEYS.HIST_CC_BOUNCED SELECT A.$1,A.$2,A.$3,A.$4,A.$5,A.$6,A.$7,A.$8,A.$9,A.$10,A.$11,NULL, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Bounced_Contacts/Bounced_Contacts_List.csv(file_format => DISC_PROD.STAGE.CSV_FORMAT) A;

    --ViewSQL
    INSERT OVERWRITE INTO DISC_PROD.QUALTRICS_SURVEYS.CC_BOUNCED SELECT * FROM DISC_PROD.QUALTRICS_SURVEYS.HIST_CC_BOUNCED WHERE ETL_INSERTED_DATE=(SELECT MAX(ETL_INSERTED_DATE) FROM DISC_PROD.QUALTRICS_SURVEYS.HIST_CC_BOUNCED);

    return ''Success'';
END;
';