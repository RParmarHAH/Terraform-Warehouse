CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_REPORT_NPS_CAREGIVER_SCORE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  NPS_CAREGIVER_SCORE
--
-- PURPOSE: Populating NPS score from CAREGIVER along with other fields coming through Qualtrics PULSE Survey.
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 06-04-2023  Meet Hariyani         Initial development.
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_PROD.REPORT.NPS_CAREGIVER_SCORE

WITH WH_EMPLOYEES AS 
(SELECT ROW_NUMBER() OVER (PARTITION BY CAMD.OLD_KEY ORDER BY DEM.EMPLOYEE_LAST_WORKED_DATE DESC) AS RNUM,CAMD.* 
FROM APP_DB_PROD.CARE_COORDINATION.CAREGIVER_MATCH_DEDUPE CAMD
LEFT JOIN DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED DEM ON CAMD.CURRENT_KEYS = DEM.ORIGINAL_EMPLOYEE_KEY 
AND DEM.ORIGINAL_EMPLOYEE_KEY=DEM.EMPLOYEE_KEY
WHERE CAMD.OLD_KEY<>CAMD.CURRENT_KEYS)

,Pulse_survey AS (
SELECT DISTINCT coalesce(whe.current_keys,SRH.EMPLOYEE_KEY) as wh_employee_key,SRH.survey_response_header_key,SRH.RECORDED_DATE,SRH.START_DATE,SRH.END_DATE, DE.PRIMARY_BRANCH_NAME  
FROM DW_PROD.HAH.DIM_SURVEY_RESPONSE_HEADER SRH
LEFT JOIN WH_EMPLOYEES WHE on SRH.EMPLOYEE_KEY = WHE.old_key AND WHE.RNUM=1
LEFT JOIN DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED DE ON DE.ORIGINAL_EMPLOYEE_KEY = coalesce(WHE.current_keys,SRH.EMPLOYEE_KEY)
WHERE SURVEY_ID = ''SV_3UvAmrnKb24ZfO6''  )

,NPS AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS NPS ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''recommend help at home'')
,belonging_text AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS sense_of_belonging_text ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''sense of belonging text'')
,clockout_text AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS easily_clockin_clockout_text ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''easily clockin clockout text'')
,clockout AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS easily_clockin_clockout ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''easily clockin clockout'')
,experience AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS improve_your_experience ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''improve your experience'')
,schedule AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS satisfied_with_schedule ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''satisfied with schedule'')
,support AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS support_from_office_team ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''support from office team'')
,support_text AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS support_from_office_team_text ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''support from office team text'')
,paid AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS paid_on_time ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''paid on time'')
,belonging AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS sense_of_belonging ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''sense of belonging'')
,schedule_text AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS satisfied_with_schedule_text ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''satisfied with schedule text'')
,prepared_text AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS prepared_for_new_client_text ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''prepared for new client text'')
,paid_text AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS paid_on_time_text ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''paid on time text'')
,prepared AS (
SELECT b.employee_key ,NVL(c.CHOICE_TEXT::VARCHAR,TRIM(SPLIT_PART(b.COMMENTS, ''='', 2))::VARCHAR) AS prepared_for_new_client ,SURVEY_RESPONSE_HEADER_KEY
FROM DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING a
INNER JOIN DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_RESPONSE_MAPPING b ON a.SURVEY_QUESTION_KEY = b.SURVEY_QUESTION_KEY
left JOIN DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING c ON c.CHOICE_LABLE::VARCHAR = TRIM(SPLIT_PART(b.COMMENTS, ''='', 2)) AND b.SURVEY_QUESTION_KEY = c.SURVEY_QUESTION_KEY
WHERE QUESTION_CONTEXT = ''prepared for new client'')
,FINAL AS (
SELECT 
	PS.WH_EMPLOYEE_KEY,
	ps.survey_response_header_key,
	PS.RECORDED_DATE,
	PS.START_DATE,
	PS.END_DATE,
	PS.PRIMARY_BRANCH_NAME AS BRANCH_NAME,
	nps.NPS,
	e.improve_your_experience,
	bl.sense_of_belonging,
	bt.sense_of_belonging_text,
	c.easily_clockin_clockout,
	ct.easily_clockin_clockout_text,
	su.support_from_office_team,
	sut.support_from_office_team_text,
	p.paid_on_time,
	paid.paid_on_time_text,
	sc.satisfied_with_schedule,
	st.satisfied_with_schedule_text,
	pr.prepared_for_new_client,
	pt.prepared_for_new_client_text
FROM pulse_survey ps 
LEFT JOIN NPS ON NPS.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN belonging_text bt ON bt.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN clockout_text CT ON CT.survey_response_header_key = PS.survey_response_header_key
LEFT JOIN clockout C ON C.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN experience e ON e.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN schedule sc ON sc.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN support su ON su.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN support_text sut ON sut.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN paid p ON p.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN belonging bl ON bl.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN schedule_text st ON st.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN prepared_text pt ON pt.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN paid_text paid ON paid.survey_response_header_key = ps.survey_response_header_key
LEFT JOIN prepared pr ON pr.survey_response_header_key = ps.survey_response_header_key
)SELECT * FROM FINAL;

RETURN(''SUCCESS'');

END';