CREATE OR REPLACE TABLE DISC_PROD.WORKDAY.WORKER_STATUS (
	EMPLOYEE_ID VARCHAR(100) NOT NULL,
	STAFFING_EVENT VARCHAR(16777216),
	STAFFING_EVENT_DATE DATE,
	EMPLOYEE_STATUS VARCHAR(16777216),
	ACTIVE BOOLEAN,
	HIRE_DATE DATE,
	ORIGINAL_HIRE_DATE DATE,
	HIRE_REASON VARCHAR(16777216),
	TERMINATION_DATE DATE,
	PRIMARY_TERMINATION_REASON VARCHAR(16777216),
	NOT_ELIGIBLE_FOR_HIRE BOOLEAN,
	REHIRE BOOLEAN,
	LANDING_INSERTED_DATE TIMESTAMP_NTZ(9),
	LANDING_INSERTED_BY VARCHAR(16777216),
	PROCESSED_TIMESTAMP TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN,
	FILE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9)
);