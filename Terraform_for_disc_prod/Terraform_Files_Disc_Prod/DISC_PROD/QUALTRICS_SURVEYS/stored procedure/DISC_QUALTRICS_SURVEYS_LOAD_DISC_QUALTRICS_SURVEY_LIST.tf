resource "snowflake_procedure" "DISC_QUALTRICS_SURVEYS_LOAD_DISC_QUALTRICS_SURVEY_LIST" {
	name ="LOAD_DISC_QUALTRICS_SURVEY_LIST"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
	INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_LIST 
	SELECT CURRENT_TIMESTAMP(),A.$1 FROM @DW_${var.SF_ENVIRONMENT}.Stage.AZSTAGEPROD/Qualtrics/Qualtrics_Survey_List/(file_format => DW_${var.SF_ENVIRONMENT}.PUBLIC.MY_JSON_FORMAT,pattern =>''.*Qualtrics_Survey_List.*.'') A;
	RETURN ''Succeeded.'';
END

 EOT
}

