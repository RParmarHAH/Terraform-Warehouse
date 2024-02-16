resource "snowflake_procedure" "DW_HAH_GET_STAGE_HM_FACT_SURVEY_RESPONSE_DETAIL" {
	name ="GET_STAGE_HM_FACT_SURVEY_RESPONSE_DETAIL"
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
-- NAME:  FACT_SURVEY_RESPONSE_DETAIL
--
-- PURPOSE: Insert survey response details
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR             	NOTES:
-- --------    -------------------  ---------------------------------------------------------------------------
-- 04/11/2022  Paras Bhavnani	    Initial DEVelopment
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.HM_FACT_SURVEY_RESPONSE_DETAIL
WITH HEADER AS 
	(SELECT  
	f.value:responseId::STRING AS RESPONSE_ID,
	SR.SURVEY_ID AS SURVEY_ID,
	f.value AS value_a
	FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE SR, table(flatten(SURVEY_JSON:responses)) f
	WHERE SURVEY_ID=''SV_9R11KQoz9btyWto''
	AND f.value:values.CLIENT_KEY::STRING IS NOT NULL
	)
,RESPONSES AS 
	(SELECT 
	HEADER.RESPONSE_ID,
	REPLACE(f.KEY,''#'','''') AS QUESTION_ID, 
	IFF(SUBSTRING(f.value::STRING,1,1)=''['',f.value[0],f.value::STRING) AS ANSWER 
	FROM HEADER,table(flatten(value_a:values))f)
,QUESTIONS_ANSWERS AS 
	(SELECT R.*,FSQ.SURVEY_QUESTION_KEY,FSQ.QUESTION_TEXT FROM RESPONSES R
	JOIN DW_${var.SF_ENVIRONMENT}.STAGE.HM_FACT_SURVEY_QUESTION FSQ ON R.QUESTION_ID=FSQ.QUESTION_ID)
,LABLES AS 
	(SELECT
	HEADER.RESPONSE_ID,
	REPLACE(f.KEY,''#'','''') AS QUESTION_ID, 
	f.value::STRING AS ANSWER 
	FROM HEADER,table(flatten(value_a:labels))f
	WHERE SUBSTRING(f.value::STRING,1,1)<>''[''
	UNION
	SELECT
	HEADER.RESPONSE_ID,
	REPLACE(f.KEY,''#'','''') AS QUESTION_ID, 
	LISTAGG(f2.value,'','') AS ANSWER
	FROM HEADER,table(flatten(value_a:labels))f,table(flatten(f.value))f2
	GROUP BY RESPONSE_ID,QUESTION_ID
	)
SELECT 
	MD5(H.SURVEY_ID||'' - ''||H.RESPONSE_ID||'' - ''||QA.QUESTION_ID||'' - ''||QA.QUESTION_TEXT) AS SURVEY_RESPONSE_DETAIL_KEY,
	MD5(H.SURVEY_ID) AS SURVEY_KEY,
	H.SURVEY_ID,
	26 AS SOURCE_SYSTEM_ID,
	''Qualtrics'' AS SYSTEM_CODE,
	MD5(H.SURVEY_ID||'' - ''||H.RESPONSE_ID) AS SURVEY_RESPONSE_HEADER_KEY,
	QA.SURVEY_QUESTION_KEY,
	QA.QUESTION_ID,
	COALESCE(L.ANSWER,QA.ANSWER) AS ANSWER,
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
	FROM HEADER H
	JOIN QUESTIONS_ANSWERS QA ON H.RESPONSE_ID=QA.RESPONSE_ID
	LEFT JOIN LABLES L ON H.RESPONSE_ID=L.RESPONSE_ID AND QA.QUESTION_ID=L.QUESTION_ID;          
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

