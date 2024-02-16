CREATE OR REPLACE TABLE DISC_PROD.HEALTH_NAVIGATOR.ASSESSMENT_SCORING__C (
	ID VARCHAR(18),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	ISDELETED BOOLEAN,
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	SCORE_INTEGER__C NUMBER(18,0),
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	CLIENT__C VARCHAR(18),
	QUESTION_SECTION__C VARCHAR(255),
	NAME VARCHAR(80),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	ASSESSMENT__C VARCHAR(18),
	HIGH_SCORE__C NUMBER(5,0),
	CREATEDBYID VARCHAR(18),
	OWNERID VARCHAR(18),
	IDENTIFIED_NEED_SCORE__C NUMBER(5,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	SCORE_TEXT__C VARCHAR(255),
	LASTMODIFIEDBYID VARCHAR(18),
	MEDIUM_SCORE__C VARCHAR(5)
);