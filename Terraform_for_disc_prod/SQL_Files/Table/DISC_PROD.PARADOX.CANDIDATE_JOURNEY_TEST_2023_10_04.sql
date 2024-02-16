CREATE OR REPLACE TABLE DISC_PROD.PARADOX.CANDIDATE_JOURNEY_TEST_2023_10_04 (
	REQ_ID VARCHAR(100),
	JOB_TITLE VARCHAR(255),
	STORE VARCHAR(40),
	ORGANIZATIONAL_ALIGNMENT VARCHAR(40),
	STATE VARCHAR(40),
	CITY VARCHAR(40),
	CANDIDATE_ID NUMBER(16,0),
	CANDIDATE_NAME VARCHAR(50),
	PHONE_NUMBER VARCHAR(20),
	EMAIL VARCHAR(150),
	STATUS VARCHAR(200),
	CANDIDATE_ENGAGED_CLICKED_APPLY_NOW TIMESTAMP_NTZ(9),
	CANDIDATE_CAPTURE_COMPLETE_SCREENING_COMPLETE TIMESTAMP_NTZ(9),
	REJECTED__DID_NOT_MEET_AGE_REQUIREMENTS TIMESTAMP_NTZ(9),
	INTERVIEW_REQUEST_SENT TIMESTAMP_NTZ(9),
	INTERVIEW_ACCEPTED_BY_CANDIDATE TIMESTAMP_NTZ(9),
	INTERVIEW_REQUEST_CANCELED_USER TIMESTAMP_NTZ(9),
	INTERVIEW_REQUEST_CANCELED_CANDIDATE TIMESTAMP_NTZ(9),
	INTERVIEW_SCHEDULED TIMESTAMP_NTZ(9),
	INTERVIEW_NO_SHOW TIMESTAMP_NTZ(9),
	REJECTED__NOT_ELIGIBLE_FOR_WORK TIMESTAMP_NTZ(9),
	HIRE TIMESTAMP_NTZ(9),
	TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEW_ACCEPTANCE VARCHAR(20),
	TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEW_SCHEDULED VARCHAR(20),
	TIME_FROM_INTERVIEW_REQUEST_SENT_TO_INTERVIEW_SCHEDULED_ VARCHAR(20),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_HIRE VARCHAR(20),
	TIME_FROM_CAPTURE_COMPLETE_TO_HIRE VARCHAR(20),
	CANDIDATE_SOURCE VARCHAR(40),
	CANDIDATE_SOURCED_FROM_NAME VARCHAR(2048),
	RECORDED_VIDEO_INTERVIEW VARCHAR(10),
	RECORDED_VIDEO_RESPONSE_COUNT NUMBER(3,0),
	RECORDED_VIDEO_QUESTIONS_SENT NUMBER(3,0),
	ALL_RECORDED_VIDEO_ANSWERS_WITHIN_24_HOURS VARCHAR(10),
	TOTAL_PARADOX_VIDEO_MEETINGS NUMBER(3,0),
	TOTAL_PARADOX_VIDEO_DURATION_IN_MINUTES VARCHAR(40),
	SEND_FULL_APPLICATION_FORM TIMESTAMP_NTZ(9),
	FULL_APPLICATION_FORM_COMPLETE TIMESTAMP_NTZ(9),
	ONBOARDING_SENT TIMESTAMP_NTZ(9),
	ONBOARDING_COMPLETE TIMESTAMP_NTZ(9),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_ONBOARDING_COMPLETE VARCHAR(20),
	OFFER_SENT TIMESTAMP_NTZ(9),
	OFFER_ACCEPTED TIMESTAMP_NTZ(9),
	OFFER_DECLINED TIMESTAMP_NTZ(9),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_OFFER_SENT VARCHAR(20),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_OFFER_ACCEPTED VARCHAR(20),
	ANTICIPATED_START_DATE_HIRE_DETAILS TIMESTAMP_NTZ(9),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_START_DATE VARCHAR(20),
	JOB_TITLE_CODE VARCHAR(20),
	PROFILE_ID VARCHAR(40),
	MULTIPLE_RECORDS VARCHAR(10),
	PRIMARY_IDENTIFIER VARCHAR(40),
	REAPPLY_IN_CAPTURE VARCHAR(10),
	REAPPLY_IN_JOB_SEARCH VARCHAR(10),
	REAPPLY_IN_CAMPAIGN VARCHAR(10),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);