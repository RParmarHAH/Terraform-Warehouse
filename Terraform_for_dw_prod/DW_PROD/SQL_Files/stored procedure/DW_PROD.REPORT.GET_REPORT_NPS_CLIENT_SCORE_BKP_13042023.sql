CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_NPS_CLIENT_SCORE_BKP_13042023("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  return_result varchar(500);
BEGIN
--*****************************************************************************************************************************
-- NAME:  NPS_CLIENT_SCORE
--
-- PURPOSE: Populating NPS score from client along with other fields coming through Qualtrics Consumer Satisfaction Survey.
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
--             Hasnain Motagamwala   Initial development
-- 02-09-2023  Meet Hariyani         Added feilds from consumer satisfaction surveys.
-- 02-28-2023  Hasnain Motagamwala   Removed the where conditions in INCLUDE_FOR_EXEC_OPS_HOURS_LIST and INCLUDE_FOR_EXEC_OPS_CLIENTS_LIST CTEs  
-- 03-21-2023  Hasnain Motagamwala   Brought in BATCH_NUMBER in SURVEY_MAPPING CTE by joining FACT_SURVEY_QUESTION_RESPONSE_MAPPING with BATCH CTE
-- 03-21-2023  Hasnain Motagamwala   Changed joining condition from RECORDED_DATE to BATCH_NUMBER in CLIENT_CONTRACTS CTE
-- 03-21-2023  Hasnain Motagamwala   ADDED BATCH_NUMBER IN ITS ORIGINAL FORM TAKEN FROM DW_DEV.HAH.DIM_SURVEY_RESPONSE_HEADER AS SOURCE_BATCH_NUMBER
-- 03-31-2023  Hasnain Motagamwala   Brought in BRANCH_KEY from DW_PROD.INTEGRATION.DIM_CLIENT_MERGED where BRANCH_KEY is NULL in CLIENT_CONTRACTS CTE.
-- 04-06-2023  Meet Hariyani         Changed CLIENT_KEY TO WH_CLIENT_KEY used in Batch(CTE).
-- 04-12-2023  Hasnain Motagamwala   Added SURVEY_KEY column in BATCH(CTE)
-- 04-12-2023  Hasnain Motagamwala   Made Changes in SURVEY_MAPPING(CTE) 
--                                   added SQR.SURVEY_KEY = FSQM.SURVEY_KEY in joining between SQR and FSQM, 
--                                   added SQR.SURVEY_KEY = BATCH.SURVEY_KEY in joining between SQR and BATCH 
-- 04-13-2023  Hasnain Motagamwala   Added SURVEY_NAME column in CLIENT_SURVEY CTE and SURVEY_ID, SURVEY_NAME in the t1 CTE
--*****************************************************************************************************************************
CREATE OR REPLACE TABLE DW_PROD.REPORT.NPS_CLIENT_SCORE AS
WITH WH_CLIENTS AS(
    SELECT ROW_NUMBER() OVER (PARTITION BY CMD.OLD_KEY ORDER BY DCM.LAST_SERVICE_DATE DESC) AS RNUM,CMD.* 
    FROM APP_DB_PROD.CARE_COORDINATION.CLIENT_MATCH_DEDUPE CMD
    LEFT JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DCM ON CMD.CURRENT_KEYS = DCM.ORIGINAL_CLIENT_KEY 
    AND DCM.ORIGINAL_CLIENT_KEY=DCM.CLIENT_KEY
    WHERE CMD.OLD_KEY<>CMD.CURRENT_KEYS
  )
  , CLIENT_SURVEY AS (
    SELECT SURVEY_ID,SURVEY_KEY,SURVEY_NAME
    FROM DW_PROD.HAH.DIM_SURVEY 
    WHERE CLIENT_EMPLOYEE_INDICATOR = ''CLIENT''
  )
  , BATCH AS (
  SELECT COALESCE(WHC.current_keys,client_key) as wh_client_key,SURVEY_KEY,SURVEY_ID,SURVEY_RESPONSE_HEADER_KEY,CAST(CONCAT(''20'',SUBSTRING(BATCH_NUMBER,3,2),
    CASE 
      WHEN SUBSTRING(BATCH_NUMBER,1,2) = ''Q1'' THEN ''-01-01''
      WHEN SUBSTRING(BATCH_NUMBER,1,2) = ''Q2'' THEN ''-04-01''
      WHEN SUBSTRING(BATCH_NUMBER,1,2) = ''Q3'' THEN ''-07-01''
      WHEN SUBSTRING(BATCH_NUMBER,1,2) = ''Q4'' THEN ''-10-01''
    END)AS DATE) AS batch_number, BATCH_NUMBER AS SOURCE_BATCH_NUMBER
  FROM DW_PROD.HAH.DIM_SURVEY_RESPONSE_HEADER
  LEFT JOIN WH_CLIENTS WHC on client_key = WHC.OLD_KEY AND WHC.RNUM=1
  )--SELECT DISTINCT SURVEY_ID FROM DW_PROD.HAH.DIM_SURVEY_RESPONSE_HEADER WHERE CLIENT_KEY IN (SELECT DISTINCT wh_client_key FROM BATCH);
  , SURVEY_MAPPING AS (
    SELECT SQR.CLIENT_KEY, BATCH.SURVEY_ID, CS.SURVEY_NAME, SQR.SURVEY_RESPONSE_HEADER_KEY, BATCH.BATCH_NUMBER, BATCH.SOURCE_BATCH_NUMBER, TRIM(SPLIT_PART(COMMENTS, ''='', 2)) AS NPS, TO_DATE(RECORDED_DATE) RECORDED_DATE
    FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING FSQM
    INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING SQR 
    ON SQR.SURVEY_QUESTION_KEY  = FSQM.SURVEY_QUESTION_KEY 
    AND SQR.SURVEY_KEY = FSQM.SURVEY_KEY
    INNER JOIN BATCH 
    ON SQR.CLIENT_KEY = BATCH.WH_CLIENT_KEY 
    AND SQR.SURVEY_RESPONSE_HEADER_KEY = BATCH.SURVEY_RESPONSE_HEADER_KEY
    AND SQR.SURVEY_KEY = BATCH.SURVEY_KEY
    LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = SQR.SURVEY_KEY
    WHERE FSQM.QUESTION_CONTEXT = ''NPS'' AND FSQM.SURVEY_KEY = CS.SURVEY_KEY
  )--SELECT * FROM SURVEY_MAPPING;--74,363
  , CLIENT_CONTRACTS AS (
      SELECT 
        DISTINCT SM.CLIENT_KEY, SM.SURVEY_ID, SM.SURVEY_NAME, SM.BATCH_NUMBER, SM.SOURCE_BATCH_NUMBER, SM.NPS, SM.SURVEY_RESPONSE_HEADER_KEY, COALESCE(FV.BRANCH_KEY, DCM.PRIMARY_BRANCH_KEY) BRANCH_KEY, FV.CONTRACT_KEY ,SM.RECORDED_DATE
      FROM SURVEY_MAPPING SM
      LEFT JOIN DW_PROD.HAH.FACT_VISIT FV
        ON SM.CLIENT_KEY = FV.CLIENT_KEY
        AND YEAR(SM.BATCH_NUMBER) = YEAR(FV.SERVICE_DATE)
        AND MONTH(SM.BATCH_NUMBER) = MONTH(FV.SERVICE_DATE)
    LEFT JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DCM
    ON SM.CLIENT_KEY = DCM.CLIENT_KEY
  )--SELECT * FROM CLIENT_CONTRACTS;
  , INCLUDE_FOR_EXEC_OPS_HOURS_LIST AS (
      SELECT DISTINCT CLIENT_KEY FROM CLIENT_CONTRACTS C
      INNER JOIN DW_PROD.REPORT.VW_DASHBOARD_CONTRACTS DC
        ON C.CONTRACT_KEY = DC.CONTRACT_KEY
      --WHERE INCLUDE_FOR_EXEC_OPS_HOURS = ''TRUE''
  )
  , INCLUDE_FOR_EXEC_OPS_CLIENTS_LIST AS (
      SELECT DISTINCT CLIENT_KEY FROM CLIENT_CONTRACTS C
      INNER JOIN DW_PROD.REPORT.VW_DASHBOARD_CONTRACTS DC
        ON C.CONTRACT_KEY = DC.CONTRACT_KEY
      --WHERE INCLUDE_FOR_EXEC_OPS_CLIENTS = ''TRUE''
  )
  , t1 as(
  SELECT DISTINCT
    C.CLIENT_KEY, C.BRANCH_KEY, C.SURVEY_RESPONSE_HEADER_KEY, C.SURVEY_ID, C.SURVEY_NAME, BATCH_NUMBER, SOURCE_BATCH_NUMBER, NPS, RECORDED_DATE --, QUESTION_ID, QUESTION_TEXT
    ,CASE WHEN OCL.CLIENT_KEY IS NOT NULL THEN TRUE ELSE FALSE END AS INCLUDE_FOR_EXEC_OPS_HOURS
    ,CASE WHEN OHL.CLIENT_KEY IS NOT NULL THEN TRUE ELSE FALSE END AS INCLUDE_FOR_EXEC_OPS_CLIENTS
  FROM CLIENT_CONTRACTS C
  LEFT JOIN INCLUDE_FOR_EXEC_OPS_HOURS_LIST OHL
    ON C.CLIENT_KEY = OHL.CLIENT_KEY
  LEFT JOIN INCLUDE_FOR_EXEC_OPS_CLIENTS_LIST OCL
    ON C.CLIENT_KEY = OCL.CLIENT_KEY
   )--SELECT * FROM t1;
,compassion AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS SHOW_COMPASSION ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Shows compassion'' AND A.SURVEY_KEY = CS.SURVEY_KEY)-- SELECT * FROM compassion;--72,100
,visit_changes AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS INFORMED_OF_VISIT_CHANGES ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Informed of visit changes''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,respect AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS TREATING_WITH_RESPECT ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Treating with Respect''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,home AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS SAFE_IN_HOME ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Safe in home''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,skills AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS RIGHT_SKILLS ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Right skills''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,attentive AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS ATTENTIVE_TO_NEEDS ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Attentive to needs''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,helpfulness AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS OFFICE_HELPFULLNESS ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Office helpfulness''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,Staying AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS STAYING_ENTIRE_VISIT ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Staying entire visit''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,Trustworthy AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS TRUSTWORTHY ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Trustworthy''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,time AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS ON_TIME ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''On time''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,caregiver AS (
SELECT b.CLIENT_KEY ,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AS RECOGNIZE_CAREGIVER ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Recognize caregiver''AND A.SURVEY_KEY = CS.SURVEY_KEY)
,experience AS (
SELECT b.CLIENT_KEY ,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AS IMPROVE_EXPERIANCE ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Improve experience''AND A.SURVEY_KEY = CS.SURVEY_KEY
),
caregiver_experience AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS overall_caregiver_experiance ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Overall caregiver experience''AND A.SURVEY_KEY = CS.SURVEY_KEY
)--SELECT * FROM caregiver_experience;
,email AS (
SELECT b.CLIENT_KEY ,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AS client_email_address ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Client email address''AND A.SURVEY_KEY = CS.SURVEY_KEY
),
completed AS (
SELECT b.CLIENT_KEY ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS survay_completed_by ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
LEFT JOIN CLIENT_SURVEY CS ON CS.SURVEY_KEY = B.SURVEY_KEY
WHERE QUESTION_CONTEXT = ''Survey completed by''AND A.SURVEY_KEY = CS.SURVEY_KEY
),
program AS (
SELECT CLIENT_KEY,listagg(PROGRAM_NAME,'','') AS program_name 
FROM APP_DB_PROD.CARE_COORDINATION.CLIENT_PARTNER_PROGRAM 
GROUP BY CLIENT_KEY
)
SELECT t1.*,
visit_changes.INFORMED_OF_VISIT_CHANGES,
respect.TREATING_WITH_RESPECT,
compassion.SHOW_COMPASSION,
home.SAFE_IN_HOME,
skills.RIGHT_SKILLS,
attentive.ATTENTIVE_TO_NEEDS,
helpfulness.OFFICE_HELPFULLNESS,
Staying.STAYING_ENTIRE_VISIT,
Trustworthy.Trustworthy,
time.ON_TIME,
caregiver.RECOGNIZE_CAREGIVER,
experience.IMPROVE_EXPERIANCE,
caregiver_experience.overall_caregiver_experiance,
email.client_email_address,
completed.survay_completed_by,
program.program_name,
CASE 
  WHEN program_name is not null THEN ''True''
  ELSE ''False''
END AS Care_cordination 
FROM t1
LEFT JOIN compassion ON t1.SURVEY_RESPONSE_HEADER_KEY = compassion.SURVEY_RESPONSE_HEADER_KEY
left JOIN visit_changes ON t1.SURVEY_RESPONSE_HEADER_KEY = visit_changes.SURVEY_RESPONSE_HEADER_KEY
left JOIN respect ON t1.SURVEY_RESPONSE_HEADER_KEY = respect.SURVEY_RESPONSE_HEADER_KEY
left JOIN home ON t1.SURVEY_RESPONSE_HEADER_KEY = home.SURVEY_RESPONSE_HEADER_KEY
left JOIN skills ON t1.SURVEY_RESPONSE_HEADER_KEY = skills.SURVEY_RESPONSE_HEADER_KEY
left JOIN attentive ON t1.SURVEY_RESPONSE_HEADER_KEY = attentive.SURVEY_RESPONSE_HEADER_KEY
left JOIN helpfulness ON t1.SURVEY_RESPONSE_HEADER_KEY = helpfulness.SURVEY_RESPONSE_HEADER_KEY
left JOIN Staying ON t1.SURVEY_RESPONSE_HEADER_KEY = Staying.SURVEY_RESPONSE_HEADER_KEY
left JOIN Trustworthy ON t1.SURVEY_RESPONSE_HEADER_KEY = Trustworthy.SURVEY_RESPONSE_HEADER_KEY
left JOIN time ON t1.SURVEY_RESPONSE_HEADER_KEY = time.SURVEY_RESPONSE_HEADER_KEY
left JOIN caregiver ON t1.SURVEY_RESPONSE_HEADER_KEY = caregiver.SURVEY_RESPONSE_HEADER_KEY
left JOIN experience ON t1.SURVEY_RESPONSE_HEADER_KEY = experience.SURVEY_RESPONSE_HEADER_KEY
LEFT JOIN caregiver_experience ON t1.SURVEY_RESPONSE_HEADER_KEY = caregiver_experience.SURVEY_RESPONSE_HEADER_KEY
LEFT JOIN email ON t1.SURVEY_RESPONSE_HEADER_KEY = email.SURVEY_RESPONSE_HEADER_KEY
LEFT JOIN completed ON t1.SURVEY_RESPONSE_HEADER_KEY = completed.SURVEY_RESPONSE_HEADER_KEY
LEFT JOIN program ON t1.client_key = program.client_key
LEFT JOIN batch ON t1.SURVEY_RESPONSE_HEADER_KEY = batch.SURVEY_RESPONSE_HEADER_KEY;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';