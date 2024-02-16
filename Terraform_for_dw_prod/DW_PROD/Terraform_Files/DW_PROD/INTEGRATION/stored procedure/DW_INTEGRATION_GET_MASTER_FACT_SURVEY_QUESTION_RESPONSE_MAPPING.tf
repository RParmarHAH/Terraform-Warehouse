resource "snowflake_procedure" "DW_INTEGRATION_GET_MASTER_FACT_SURVEY_QUESTION_RESPONSE_MAPPING" {
	name ="GET_MASTER_FACT_SURVEY_QUESTION_RESPONSE_MAPPING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN

    INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING
    SELECT
	question.SURVEY_KEY,
	question.SURVEY_ID,
	question.SURVEY_QUESTION_KEY,
	question.question_id,
	question.question_text,
	'' NPS SCORE = '' || answer AS comments,
	header.SURVEY_RESPONSE_HEADER_KEY,
	header.client_key,
	header.RECORDED_DATE,
	header.EMPLOYEE_KEY
FROM
	DW_${var.SF_ENVIRONMENT}.HAH.FACT_SURVEY_QUESTION question
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.FACT_SURVEY_RESPONSE_DETAIL detail 
    ON
	question.SURVEY_QUESTION_KEY = detail.SURVEY_QUESTION_KEY
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SURVEY_RESPONSE_HEADER header
    ON
	detail.SURVEY_RESPONSE_HEADER_KEY = header.SURVEY_RESPONSE_HEADER_KEY;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

