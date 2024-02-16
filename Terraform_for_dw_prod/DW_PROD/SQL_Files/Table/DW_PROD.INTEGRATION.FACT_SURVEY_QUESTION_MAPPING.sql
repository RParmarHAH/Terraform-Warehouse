CREATE OR REPLACE TABLE DW_PROD.INTEGRATION.FACT_SURVEY_QUESTION_MAPPING (
	SURVEY_KEY VARCHAR(32),
	SURVEY_ID VARCHAR(32) NOT NULL,
	SURVEY_QUESTION_KEY VARCHAR(32) NOT NULL,
	QUESTION_ID VARCHAR(32) NOT NULL,
	QUESTION_TEXT VARCHAR(500) NOT NULL,
	QUESTION_CONTEXT VARCHAR(100)
);