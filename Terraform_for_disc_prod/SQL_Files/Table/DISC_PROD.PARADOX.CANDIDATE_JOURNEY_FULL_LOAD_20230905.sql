CREATE OR REPLACE TABLE DISC_PROD.PARADOX.CANDIDATE_JOURNEY_FULL_LOAD_20230905 (
	REQ_ID VARCHAR(16777216),
	JOB_TITLE VARCHAR(16777216),
	STORE VARCHAR(16777216),
	ORGANIZATIONAL_ALIGNMENT VARCHAR(16777216),
	STATE VARCHAR(16777216),
	CITY VARCHAR(16777216),
	CANDIDATE_ID VARCHAR(16777216),
	CANDIDATE_NAME VARCHAR(16777216),
	PHONE_NUMBER VARCHAR(16777216),
	EMAIL VARCHAR(16777216),
	STATUS VARCHAR(16777216),
	CANDIDATE_ENGAGED_CLICKED_APPLY_NOW VARCHAR(16777216),
	CANDIDATE_CAPTURE_COMPLETE_SCREENING_COMPLETE VARCHAR(16777216),
	REJECTED_DID_NOT_MEET_AGE_REQUIREMENTS VARCHAR(16777216),
	INTERVIEW_REQUEST_SENT VARCHAR(16777216),
	INTERVIEW_ACCEPTED_BY_CANDIDATE VARCHAR(16777216),
	INTERVIEW_REQUEST_CANCELED_USER VARCHAR(16777216),
	INTERVIEW_REQUEST_CANCELED_CANDIDATE VARCHAR(16777216),
	INTERVIEW_SCHEDULED VARCHAR(16777216),
	INTERVIEW_NO_SHOW VARCHAR(16777216),
	REJECTED_NOT_ELIGIBLE_FOR_WORK VARCHAR(16777216),
	HIRE VARCHAR(16777216),
	TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEW_ACCEPTANCE VARCHAR(16777216),
	TIME_FROM_CAPTURE_COMPLETE_TO_INTERVIEW_SCHEDULED VARCHAR(16777216),
	TIME_FROM_INTERVIEW_REQUEST_SENT_TO_INTERVIEW_SCHEDULED_ VARCHAR(16777216),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_HIRE VARCHAR(16777216),
	TIME_FROM_CAPTURE_COMPLETE_TO_HIRE VARCHAR(16777216),
	CANDIDATE_SOURCE VARCHAR(16777216),
	CANDIDATE_SOURCED_FROM_NAME VARCHAR(16777216),
	RECORDED_VIDEO_INTERVIEW VARCHAR(16777216),
	RECORDED_VIDEO_RESPONSE_COUNT VARCHAR(16777216),
	RECORDED_VIDEO_QUESTIONS_SENT VARCHAR(16777216),
	ALL_RECORDED_VIDEO_ANSWERS_WITHIN_24_HOURS VARCHAR(16777216),
	TOTAL_PARADOX_VIDEO_MEETINGS VARCHAR(16777216),
	TOTAL_PARADOX_VIDEO_DURATION_IN_MINUTES VARCHAR(16777216),
	SEND_FULL_APPLICATION_FORM VARCHAR(16777216),
	FULL_APPLICATION_FORM_COMPLETE VARCHAR(16777216),
	ONBOARDING_SENT VARCHAR(16777216),
	ONBOARDING_COMPLETE VARCHAR(16777216),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_ONBOARDING_COMPLETE VARCHAR(16777216),
	OFFER_SENT VARCHAR(16777216),
	OFFER_ACCEPTED VARCHAR(16777216),
	OFFER_DECLINED VARCHAR(16777216),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_OFFER_SENT VARCHAR(16777216),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_OFFER_ACCEPTED VARCHAR(16777216),
	ANTICIPATED_START_DATE_HIRE_DETAILS VARCHAR(16777216),
	TIME_FROM_INTERVIEW_SCHEDULED_TO_START_DATE VARCHAR(16777216),
	JOB_TITLE_CODE VARCHAR(16777216),
	PROFILE_ID VARCHAR(16777216),
	MULTIPLE_RECORDS VARCHAR(16777216),
	PRIMARY_IDENTIFIER VARCHAR(16777216),
	REAPPLY_IN_CAPTURE VARCHAR(16777216),
	REAPPLY_IN_JOB_SEARCH VARCHAR(16777216),
	REAPPLY_IN_CAMPAIGN VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_TASK_KEY NUMBER(1,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);