CREATE OR REPLACE TABLE DISC_PROD.PARADOX.CANDIDATE_JOURNEY_STATUS_HISTORY (
	CANDIDATE_ID NUMBER(16,0),
	CANDIDATE_NAME VARCHAR(150),
	CANDIDATE_PHONE_NUMBER VARCHAR(20),
	CANDIDATE_EMAIL VARCHAR(150),
	CANDIDATE_CREATE_DATE TIMESTAMP_NTZ(9),
	REQUISITION_ID VARCHAR(100),
	JOB_TITLE VARCHAR(255),
	JOB_CODE VARCHAR(40),
	LOCATION_NAME VARCHAR(45),
	CANDIDATE_JOURNEY_NAME VARCHAR(200),
	JOURNEY_STAGE_NAME VARCHAR(42),
	JOURNEY_STAGE_ORDER_NUMBER NUMBER(3,0),
	JOURNEY_STATUS_ORDER_NUMBER NUMBER(3,0),
	STATUS_CHANGE_DATE TIMESTAMP_NTZ(9),
	STATUS VARCHAR(105),
	STATUS_CHANGED_BY_USER VARCHAR(40),
	CANDIDATE_SOURCE VARCHAR(40),
	CANDIDATE_SOURCED_FROM_NAME VARCHAR(2048),
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