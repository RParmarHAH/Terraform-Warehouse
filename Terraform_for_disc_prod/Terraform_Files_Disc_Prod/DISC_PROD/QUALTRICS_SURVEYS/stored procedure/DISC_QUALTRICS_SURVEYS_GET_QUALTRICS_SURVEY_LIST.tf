resource "snowflake_procedure" "DISC_QUALTRICS_SURVEYS_GET_QUALTRICS_SURVEY_LIST" {
	name ="GET_QUALTRICS_SURVEY_LIST"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

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
	INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_LIST 
	SELECT CURRENT_TIMESTAMP(),A.$1 FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Survey_List/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT,pattern =>''.*Qualtrics_Survey_List.*.'') A;
	RETURN ''Succeeded.'';
END

 EOT
}

