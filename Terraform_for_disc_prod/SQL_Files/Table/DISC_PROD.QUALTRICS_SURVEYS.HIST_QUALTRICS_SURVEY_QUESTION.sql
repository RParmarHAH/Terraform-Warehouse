CREATE OR REPLACE TABLE DISC_PROD.QUALTRICS_SURVEYS.HIST_QUALTRICS_SURVEY_QUESTION (
	ID NUMBER(38,0) autoincrement,
	SURVEY_ID VARCHAR(50),
	SURVEY_NAME VARCHAR(500),
	LOAD_TIME TIMESTAMP_NTZ(9),
	SURVEY_QUESTION_JSON VARIANT
);