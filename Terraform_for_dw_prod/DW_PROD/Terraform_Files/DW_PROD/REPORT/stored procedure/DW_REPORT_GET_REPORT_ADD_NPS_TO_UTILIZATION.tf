resource "snowflake_procedure" "DW_REPORT_GET_REPORT_ADD_NPS_TO_UTILIZATION" {
	name ="GET_REPORT_ADD_NPS_TO_UTILIZATION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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
    return_result varchar(1000);
	return_result_temp varchar(1000);
BEGIN
    INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.HAH.FACT_SURVEY_QUESTION_RESPONSE_MAPPING
    SELECT 
      question.SURVEY_QUESTION_KEY, question.question_id, question.question_text, ''NPS SCORE = '' || answer as comments, 
      header.SURVEY_RESPONSE_HEADER_KEY, header.client_key, header.RECORDED_DATE
    FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_SURVEY_QUESTION question
    INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.FACT_SURVEY_RESPONSE_DETAIL detail 
    ON question.SURVEY_QUESTION_KEY = detail.SURVEY_QUESTION_KEY
    INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SURVEY_RESPONSE_HEADER header
    ON detail.SURVEY_RESPONSE_HEADER_KEY = header.SURVEY_RESPONSE_HEADER_KEY;
 
    SELECT CONCAT(''Message: '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
 
    INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.HAH.FACT_NPS
    select client_key, recorded_date, question_id, question_text, NPS
    from (
      select 
        client_key, recorded_date, question_id, question_text,
        trim(split_part(comments, ''='', 2)) as NPS, 
        row_number() over(partition by client_key order by recorded_date desc) as rn
      from DW_${var.SF_ENVIRONMENT}.HAH.FACT_SURVEY_QUESTION_RESPONSE_MAPPING where question_id = ''QID4''
    ) where rn = 1;
	
	SELECT CONCAT('' '',"number of rows inserted",'' Rows Inserted.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return CONCAT(return_result,'' | '',return_result_temp);
 
    update DW_${var.SF_ENVIRONMENT}.REPORT.UTILIZATION UC
    set UC.NPS = FN.NPS
    from DW_${var.SF_ENVIRONMENT}.HAH.FACT_NPS FN
    where FN.CLIENT_KEY = UC.CLIENT_KEY 
    AND YEAR(UC.PERIOD_BEGIN_DATE) = YEAR(FN.RECORDED_DATE) 
    AND MONTH(UC.PERIOD_BEGIN_DATE) = MONTH(FN.RECORDED_DATE);
 
  SELECT CONCAT('' '',"number of rows Updated",'' Rows Updated.'') into :return_result_temp FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
  return CONCAT(return_result,'' | '',return_result_temp);
END;

 EOT
}

