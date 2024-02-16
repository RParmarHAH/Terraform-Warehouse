CREATE OR REPLACE TABLE DISC_PROD.DOCEBO.HIST_PAYROLL (
	USERNAME VARCHAR(100),
	ARE_YOU_OR_ARE_YOU_APPLYING_TO_BE_AN_INHOME_CAREGIVER VARCHAR(10),
	BRANCHES VARCHAR(200),
	BUSINESS_UNIT VARCHAR(40),
	DEACTIVATED VARCHAR(10),
	DIRECT_MANAGER VARCHAR(40),
	DO_YOU_HAVE_A_HOME_HEALTH_CERTIFICATION VARCHAR(40),
	EMAIL VARCHAR(150),
	EMAIL_ADDRESS VARCHAR(150),
	EMAIL_VALIDATION_STATUS VARCHAR(10),
	FIELD_OR_ADMIN VARCHAR(10),
	FIRST_NAME VARCHAR(70),
	FIRST_SERVICE_DATE VARCHAR(20),
	FULL_NAME VARCHAR(150),
	HIRE_DATE VARCHAR(20),
	HOURLY VARCHAR(10),
	JOB_LEVEL VARCHAR(40),
	JOB_TITLE VARCHAR(70),
	LAST_NAME VARCHAR(70),
	LOCATION VARCHAR(100),
	MANAGER_NAME VARCHAR(150),
	PAYROLL_ID VARCHAR(40),
	PHONE_NUMBER VARCHAR(40),
	PREFERRED_LANGUAGE VARCHAR(40),
	STATE VARCHAR(40),
	TERM_DATE VARCHAR(40),
	USER_CREATION_DATE VARCHAR(40),
	USER_EXPIRATION_DATE VARCHAR(40),
	USER_LAST_ACCESS_DATE VARCHAR(40),
	USER_LEVEL VARCHAR(40),
	USER_SUSPENSION_DATE VARCHAR(40),
	USER_UNIQUE_ID VARCHAR(40),
	COURSE_NAME VARCHAR(255),
	COURSE_CATEGORY VARCHAR(500),
	COURSE_CATEGORY_CODE VARCHAR(40),
	COURSE_CODE VARCHAR(40),
	COURSE_CREATION_DATE VARCHAR(40),
	COURSE_DURATION VARCHAR(40),
	COURSE_END_DATE VARCHAR(40),
	COURSE_HAS_EXPIRED VARCHAR(40),
	COURSE_INTERNAL_ID VARCHAR(40),
	COURSE_START_DATE VARCHAR(40),
	COURSE_STATUS VARCHAR(40),
	COURSE_TYPE VARCHAR(40),
	COURSE_UNIQUE_ID VARCHAR(40),
	CREDITS_CEUS VARCHAR(40),
	LANGUAGE VARCHAR(40),
	COMPLETION_DATE VARCHAR(40),
	COURSE_FIRST_ACCESS_DATE VARCHAR(40),
	COURSE_LAST_ACCESS_DATE VARCHAR(40),
	ENROLLMENT_DATE VARCHAR(40),
	ENROLLMENT_END_DATE VARCHAR(40),
	ENROLLMENT_START_DATE VARCHAR(40),
	COURSE_ENROLLMENT_STATUS VARCHAR(40),
	FINAL_SCORE VARCHAR(40),
	INITIAL_SCORE VARCHAR(40),
	USER_COURSE_LEVEL VARCHAR(40),
	COURSE_PROGRESS_PERCENTAGE VARCHAR(40),
	NUMBER_OF_ACTIONS VARCHAR(40),
	NUMBER_OF_SESSIONS VARCHAR(40),
	SESSION_TIME VARCHAR(40),
	TRAINING_MATERIAL_TIME VARCHAR(40),
	PERCENTAGE_OF_TRAINING_MATERIAL_FROM_MOBILE_APP VARCHAR(40),
	TIME_IN_TRAINING_MATERIAL_FROM_MOBILE_APP VARCHAR(40),
	TRAINING_MATERIAL_ACCESS_FROM_MOBILE_APP VARCHAR(40),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);