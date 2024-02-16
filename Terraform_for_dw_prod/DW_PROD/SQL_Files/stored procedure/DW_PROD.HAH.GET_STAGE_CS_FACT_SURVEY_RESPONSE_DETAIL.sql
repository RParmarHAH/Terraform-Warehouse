CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CS_FACT_SURVEY_RESPONSE_DETAIL("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
    --*****************************************************************************************************************************
-- NAME:  FACT_SURVEY_RESPONSE_DETAIL
--
-- PURPOSE: Insert survey response details
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR             	NOTES:
-- --------    -------------------  ---------------------------------------------------------------------------
-- 09/11/2022  Paras Bhavnani	    Initial DEVelopment
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.CS_FACT_SURVEY_RESPONSE_DETAIL
WITH HEADER AS 
	(SELECT  
	f.value:responseId::STRING AS RESPONSE_ID,
	SR.SURVEY_ID AS SURVEY_ID,
	f.value AS value_a
	FROM DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE SR, table(flatten(SURVEY_JSON:responses)) f
	WHERE SURVEY_ID=''SV_eVUEoFMiK0s2ej4''
	) --SELECT * FROM HEADER;
,RESPONSES AS 
	(SELECT 
	HEADER.RESPONSE_ID,
	f.KEY AS QUESTION_ID, 
	f.value AS ANSWER
	FROM HEADER,table(flatten(value_a:values))f)--SELECT * FROM RESPONSES;
,QUESTIONS_ANSWERS AS 
	(SELECT R.*,FSQ.SURVEY_QUESTION_KEY,FSQ.QUESTION_TEXT FROM RESPONSES R
	JOIN STAGE.CS_FACT_SURVEY_QUESTIONS FSQ ON R.QUESTION_ID=FSQ.QUESTION_ID)--SELECT * FROM QUESTIONS_ANSWERS;
SELECT 
	MD5(H.SURVEY_ID||'' - ''||H.RESPONSE_ID||'' - ''||QA.QUESTION_ID||'' - ''||QA.QUESTION_TEXT) AS SURVEY_RESPONSE_DETAIL_KEY,
	MD5(H.SURVEY_ID) AS SURVEY_KEY,
	H.SURVEY_ID,
	26 AS SOURCE_SYSTEM_ID,
	''Qualtrics'' AS SYSTEM_CODE,
	MD5(H.SURVEY_ID||'' - ''||H.RESPONSE_ID) AS SURVEY_RESPONSE_HEADER_KEY,
	QA.SURVEY_QUESTION_KEY,
	QA.QUESTION_ID,
	IFF(SUBSTRING(QA.ANSWER::STRING,1,1)=''['',QA.ANSWER[0],QA.ANSWER::STRING) AS ANSWER,
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
	JOIN QUESTIONS_ANSWERS QA ON H.RESPONSE_ID=QA.RESPONSE_ID;       
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
          ';