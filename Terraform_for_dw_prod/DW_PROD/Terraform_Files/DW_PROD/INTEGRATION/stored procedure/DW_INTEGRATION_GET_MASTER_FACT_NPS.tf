resource "snowflake_procedure" "DW_INTEGRATION_GET_MASTER_FACT_NPS" {
	name ="GET_MASTER_FACT_NPS"
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

    INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_NPS
    select client_key, recorded_date, question_id, question_text, NPS
    from (
      select 
        client_key, recorded_date, question_id, question_text,
        trim(split_part(comments, ''='', 2)) as NPS, 
        row_number() over(partition by client_key order by recorded_date desc) as rn
      from DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING where question_id = ''QID4''
    ) where rn = 1;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

