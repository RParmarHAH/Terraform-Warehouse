CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_BILLABLESERVICEVISITSREPORT (
	VISITDATE VARCHAR(16777216),
	WEEKDAY VARCHAR(16777216),
	BILLABLE_HOURS VARCHAR(16777216),
	BILLABLE_UNITS VARCHAR(16777216),
	CUSTOMER_NAME VARCHAR(16777216),
	SCHEDULED_CHECK_IN VARCHAR(16777216),
	SCHEDULED_CHECK_OUT VARCHAR(16777216),
	SCHEDULED_DURATION VARCHAR(16777216),
	SCHEDULED_REQD_HRS VARCHAR(16777216),
	ACTUAL_CHECK_IN VARCHAR(16777216),
	ACTUAL_CHECK_OUT VARCHAR(16777216),
	ACTUAL_DURATION VARCHAR(16777216),
	PAYER_SOURCE VARCHAR(16777216),
	SERVICE_TYPE VARCHAR(16777216),
	SERVICE_CODE VARCHAR(16777216),
	CUSTOMER_ID VARCHAR(16777216),
	EMPLOYEE_ID VARCHAR(16777216),
	SERVICEVISITID VARCHAR(16777216),
	SERVICEVISITACTUALID VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);