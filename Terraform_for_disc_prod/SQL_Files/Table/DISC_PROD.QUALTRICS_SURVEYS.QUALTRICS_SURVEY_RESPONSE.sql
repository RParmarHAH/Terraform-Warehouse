CREATE OR REPLACE TABLE DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE (
	SURVEY_ID VARCHAR(50),
	SURVEY_NAME VARCHAR(500),
	LOAD_TIME TIMESTAMP_NTZ(9),
	SURVEY_JSON VARIANT
);