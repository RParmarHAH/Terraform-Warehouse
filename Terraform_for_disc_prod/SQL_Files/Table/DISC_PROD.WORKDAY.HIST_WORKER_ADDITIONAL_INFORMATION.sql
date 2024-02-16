CREATE OR REPLACE TABLE DISC_PROD.WORKDAY.HIST_WORKER_ADDITIONAL_INFORMATION (
	EMPLOYEE_ID VARCHAR(100) NOT NULL,
	"UNION" VARCHAR(16777216),
	UNION_ACTIVE VARCHAR(16777216),
	UNION_DESCRIPTION VARCHAR(16777216),
	LATEST_VACCINATION VARCHAR(16777216),
	LATEST_VACCINATION_STATUS VARCHAR(16777216),
	LATEST_VACCINATION_TYPE VARCHAR(16777216),
	SEND_TO_AMS VARCHAR(16777216),
	MANAGER_TITLE VARCHAR(16777216),
	MANAGER_FIRST_NAME VARCHAR(16777216),
	MANAGER_MIDDLE_NAME VARCHAR(16777216),
	MANAGER_LAST_NAME VARCHAR(16777216),
	MANAGER_SUFFIX VARCHAR(16777216),
	LOCATION_IDENTIFIER VARCHAR(16777216),
	GP_ID VARCHAR(16777216),
	CAREGIVER_TYPE VARCHAR(16777216),
	ENTERPRISE_ID VARCHAR(16777216),
	DATE_OF_DEATH VARCHAR(16777216),
	PREFERRED_LOCALE VARCHAR(16777216),
	HOURLY_COMPENSATION VARCHAR(16777216),
	NEW_HIRE_FLAG VARCHAR(16777216),
	LAST_DAY_WORKED VARCHAR(16777216),
	AMS_COST_CENTER_HIERARCHY VARCHAR(16777216),
	JOB_CHANGE_OLD VARCHAR(16777216),
	JOB_CHANGE_NEW VARCHAR(16777216),
	APPLICANT_ENTERED_DATE VARCHAR(16777216),
	PRE_BOARDING_COMPLETION VARCHAR(16777216),
	PARADOX_PREHIRE_ID VARCHAR(16777216),
	LANDING_INSERTED_DATE TIMESTAMP_NTZ(9),
	LANDING_INSERTED_BY VARCHAR(16777216),
	PROCESSED_TIMESTAMP TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN,
	FILE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9)
);