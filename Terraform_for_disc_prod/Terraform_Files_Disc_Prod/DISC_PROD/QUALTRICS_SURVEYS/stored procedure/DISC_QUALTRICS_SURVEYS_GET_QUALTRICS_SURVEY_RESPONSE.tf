resource "snowflake_procedure" "DISC_QUALTRICS_SURVEYS_GET_QUALTRICS_SURVEY_RESPONSE" {
	name ="GET_QUALTRICS_SURVEY_RESPONSE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  GET_QUALTRICS_SURVEY_RESPONSE 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- ----------  -------------------   -----------------------------------------------------------------------------------------------
-- 2023-11-20 RAVI SUTHAR            INITIAL DEVELOPMENT
--*****************************************************************************************************************************
 
--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.GET_QUALTRICS_SURVEY_RESPONSE 
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
	DELETE FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE WHERE SURVEY_ID=''SV_eVUEoFMiK0s2ej4'';
	INSERT INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE SELECT ''SV_eVUEoFMiK0s2ej4'',''Consumer Satisfaction Survey'',CURRENT_TIMESTAMP(),A.$1 FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Qualtrics_Surveys_FullLoad/SV_eVUEoFMiK0s2ej4/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT,pattern =>''.*.SV_eVUEoFMiK0s2ej4_Response.*.'') A;
	INSERT INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.HIST_QUALTRICS_SURVEY_RESPONSE(SURVEY_ID,SURVEY_NAME,LOAD_TIME,SURVEY_JSON) SELECT SURVEY_ID, SURVEY_NAME, LOAD_TIME, SURVEY_JSON FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE WHERE SURVEY_ID=''SV_eVUEoFMiK0s2ej4'';

    return ''Success'';
END;

 EOT
}

