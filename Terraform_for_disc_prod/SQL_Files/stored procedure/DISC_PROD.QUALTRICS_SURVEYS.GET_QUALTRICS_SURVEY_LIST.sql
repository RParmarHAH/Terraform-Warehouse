CREATE OR REPLACE PROCEDURE DISC_PROD.QUALTRICS_SURVEYS.GET_QUALTRICS_SURVEY_LIST()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  LOAD_DISC_QUALTRICS_SURVEY_LIST 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- ----------  	-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-12-14 	KOMAL DHOKAI           INITIAL DEVELOPMENT
--*****************************************************************************************************************************

BEGIN
	INSERT OVERWRITE INTO DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_LIST 
	SELECT CURRENT_TIMESTAMP(),A.$1 FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Survey_List/(file_format => DISC_PROD.STAGE.MY_JSON_FORMAT,pattern =>''.*Qualtrics_Survey_List.*.'') A;
	RETURN ''Succeeded.'';
END
';