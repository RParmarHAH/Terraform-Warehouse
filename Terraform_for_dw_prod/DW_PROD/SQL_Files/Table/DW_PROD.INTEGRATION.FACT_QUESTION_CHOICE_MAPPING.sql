CREATE OR REPLACE TABLE DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING (
	SURVEY_KEY VARCHAR(32),
	SURVEY_ID VARCHAR(32),
	SURVEY_QUESTION_KEY VARCHAR(32),
	QUESTION_ID VARCHAR(32),
	CHOICE_LABLE NUMBER(38,0),
	CHOICE_TEXT VARCHAR(32)
);