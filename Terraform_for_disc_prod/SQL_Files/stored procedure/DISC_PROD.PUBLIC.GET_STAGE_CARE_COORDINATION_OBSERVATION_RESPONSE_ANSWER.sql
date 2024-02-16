CREATE OR REPLACE PROCEDURE DISC_PROD.PUBLIC.GET_STAGE_CARE_COORDINATION_OBSERVATION_RESPONSE_ANSWER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS 'var sql = `

--****************************************************************************************************************************
-- NAME:  GET_STAGE_CARE_COORDINATION_OBSERVATION_RESPONSE_ANSWER
--
-- PURPOSE: Creates one row per observation response answer
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                               NOTES:
-- --------    -------------------                  ---------------------------------------------------------------------------

-- 04/11/2022  Paras Bhavnani                       Initial Development

--*****************************************************************************************************************************

INSERT OVERWRITE INTO CARE_COORDINATION_STAGE.ObservationResponseAnswer 
SELECT DISTINCT COALESCE(QMC.QUESTION_ID, SURVEY_QUESTION_KEY)  QUESTION_ID, 
                ANSWER ANSWER_VALUE, 
                NULL ANSWER_SCORE, 
                RECORD_ID||''-''||FSRD.QUESTION_ID EXTERNAL_ID, 
                RECORD_ID OBSERVATION_ID , 
                `;    
                     sql += STR_ETL_TASK_KEY;
                     sql +=  
                     ` AS ETL_TASK_KEY,
                `;    
                     sql += STR_ETL_TASK_KEY;
                     sql +=  
                     ` AS ETL_INSERTED_TASK_KEY,
                CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
                CURRENT_USER AS ETL_INSERTED_BY,
                CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
                CURRENT_USER AS ETL_LAST_UPDATED_BY,
                0 AS ETL_DELETED_FLAG,
                TRUE as NEWLY_CREATED_OR_UPDATED_FLAG
FROM DW_PROD.HAH.FACT_SURVEY_RESPONSE_DETAIL FSRD
JOIN DW_PROD.HAH.DIM_SURVEY_RESPONSE_HEADER DSRH ON FSRD.SURVEY_RESPONSE_HEADER_KEY=DSRH.SURVEY_RESPONSE_HEADER_KEY
LEFT JOIN DISC_PROD.QUALTRICS_SURVEYS.RESPONSES_W_QUESTION_MEANING_CHANGE QMC ON QMC.EXTERNAL_ID = DSRH.RECORD_ID||''-''||FSRD.QUESTION_ID
WHERE FSRD.SURVEY_ID IN (''SV_9R11KQoz9btyWto'',''SV_8rhFLN1ZJEdKRds'')`;

snowflake.execute ({sqlText: sql});

';