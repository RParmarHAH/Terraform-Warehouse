resource "snowflake_procedure" "DW_HAH_GET_STAGE_HM_FACT_SURVEY_QUESTION" {
	name ="GET_STAGE_HM_FACT_SURVEY_QUESTION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"

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


        var sql = `

 --*****************************************************************************************************************************

-- NAME:  FACT_SURVEY_QUESTION
-- PURPOSE: Insert survey questions
-- DEVELOPMENT LOG:
-- DATE        AUTHOR             	NOTES:
-- --------    -------------------  ---------------------------------------------------------------------------
-- 04/11/2022  Paras Bhavnani	    Initial DEVelopment
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.HM_FACT_SURVEY_QUESTION 
WITH MAIN AS 
	(SELECT f.KEY AS QUESTION_ID,
	f.value:subQuestions AS SUBQUESTIONS,
	f.value:questionText::STRING AS QUESTION,
	f.value:questionType:type::STRING AS QUESTION_TYPE,
	*
	FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_QUESTION, table(flatten(SURVEY_QUESTION_JSON:result:questions )) f
	WHERE SURVEY_ID=''SV_9R11KQoz9btyWto'')
,T1 AS 
	(SELECT SURVEY_ID, IFF(QUESTION_TYPE=''TE'',QUESTION_ID||''_TEXT'',QUESTION_ID) AS QUESTION_ID,
	QUESTION
	FROM MAIN
	WHERE SUBQUESTIONS IS NULL
	AND QUESTION_TYPE NOT IN (''Slider'',''SBS''))
,T2 AS 
	(SELECT SURVEY_ID, QUESTION_ID||''_''||f.KEY,
	MAIN.QUESTION||'' - ''||f.value:choiceText AS SUBQUESTION
	FROM MAIN, table(flatten(SUBQUESTIONS)) f
	WHERE QUESTION_TYPE NOT IN (''Slider'',''SBS''))
,T3 AS 
	(SELECT SURVEY_ID, QUESTION_ID||''_''||f.KEY,
	MAIN.QUESTION||'' - ''||f.value:choiceText AS SUBQUESTION
	FROM MAIN , table(flatten(VALUE:choices)) f
	WHERE QUESTION_TYPE=''Slider'')
,T4 AS 
	(SELECT SURVEY_ID, QUESTION_ID||''#''||f.KEY||''_1'',
	MAIN.QUESTION||'' - ''||f.value:questionText AS SUBQUESTION
	FROM MAIN, table(flatten(VALUE:columns)) f 
	WHERE QUESTION_TYPE=''SBS'')
,T5 AS 
	(SELECT SURVEY_ID, QUESTION_ID||''_''||f.KEY||''_TEXT'',
	MAIN.QUESTION||'' - ''||f.value:choiceText AS SUBQUESTION
	FROM MAIN, table(flatten(VALUE:choices)) f 
	WHERE f.value:textEntry IS NOT NULL )
,FINAL AS 
	(SELECT * FROM T1
	UNION 
	SELECT * FROM T2
	UNION
	SELECT * FROM T3
	UNION
	SELECT * FROM T4
	UNION
	SELECT * FROM T5)
,FINAL_CLEANED AS (
    SELECT *,
    REPLACE(Q.QUESTION_ID,''#'','''') AS CLEAN_SOURCE_QUESTION_ID,
    TRIM(REPLACE(Q.QUESTION,''  -'','' -'')) AS QUESTION_TEXT_0,
    REPLACE(QUESTION_TEXT_0,''\\$\\{e://Field/CLIENT_FIRST_NAME\\}'',''[Field-CLIENT_FIRST_NAME]'') AS QUESTION_TEXT_1,
    REGEXP_REPLACE(QUESTION_TEXT_1 , ''<[^>]*>'', ''''  ) AS QUESTION_TEXT_2,
    coalesce(OLD_QTEXT,QUESTION_TEXT_2) AS CLEAN_QUESTION_TEXT
    FROM FINAL Q
    LEFT JOIN DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUESTION_MAPPING_EXTRACT_TO_API M ON M.OLD_SQID = REPLACE(Q.QUESTION_ID,''#'','''')
)
SELECT 
	MD5(CLEAN_SOURCE_QUESTION_ID||CLEAN_QUESTION_TEXT) AS SURVEY_QUESTION_KEY,
	MD5(SURVEY_ID) AS SURVEY_KEY,
	SURVEY_ID,
	26 AS SOURCE_SYSTEM_ID,
	''Qualtrics'' AS SYSTEM_CODE,
	CLEAN_SOURCE_QUESTION_ID AS QUESTION_ID,
	CLEAN_QUESTION_TEXT AS QUESTION,
	NULL AS QUESTION_CATEGORY,
	1 AS IS_ACTIVE,
	 `;    
             sql += STR_ETL_TASK_KEY;

             sql +=  

             ` AS ETL_TASK_KEY,
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
	current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,
	CURRENT_USER() AS ETL_INSERTED_BY,
	current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER() AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM FINAL_CLEANED;         
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}

