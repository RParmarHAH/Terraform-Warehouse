CREATE OR REPLACE PROCEDURE DISC_PROD.QUALTRICS_SURVEYS.GET_QUALTRICS_SURVEY_QUESTION("TaskKey" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.QUALTRICS_SURVEYS.GET_QUALTRICS_SURVEY_QUESTION 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************


BEGIN
	--DELETESQL
	DELETE FROM DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_QUESTION WHERE SURVEY_ID=''SV_eVUEoFMiK0s2ej4'';
	INSERT INTO DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_QUESTION SELECT ''SV_eVUEoFMiK0s2ej4'',''Consumer Satisfaction Survey'',CURRENT_TIMESTAMP(),A.$1 FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Qualtrics_Surveys/SV_eVUEoFMiK0s2ej4/(file_format => DISC_PROD.STAGE.MY_JSON_FORMAT,pattern =>''.*.SV_eVUEoFMiK0s2ej4_Question.*.'') A;
	INSERT INTO DISC_PROD.QUALTRICS_SURVEYS.HIST_QUALTRICS_SURVEY_QUESTION(SURVEY_ID,SURVEY_NAME,LOAD_TIME,SURVEY_QUESTION_JSON) SELECT SURVEY_ID, SURVEY_NAME, LOAD_TIME, SURVEY_QUESTION_JSON FROM DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_QUESTION WHERE SURVEY_ID=''SV_eVUEoFMiK0s2ej4'';
	
	return ''Success'';
END;
';