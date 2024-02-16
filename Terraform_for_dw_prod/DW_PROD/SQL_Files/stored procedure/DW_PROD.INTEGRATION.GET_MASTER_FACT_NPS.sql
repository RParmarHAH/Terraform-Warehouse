CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_MASTER_FACT_NPS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

    INSERT OVERWRITE INTO DW_PROD.INTEGRATION.FACT_NPS
    select client_key, recorded_date, question_id, question_text, NPS
    from (
      select 
        client_key, recorded_date, question_id, question_text,
        trim(split_part(comments, ''='', 2)) as NPS, 
        row_number() over(partition by client_key order by recorded_date desc) as rn
      from DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING where question_id = ''QID4''
    ) where rn = 1;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';