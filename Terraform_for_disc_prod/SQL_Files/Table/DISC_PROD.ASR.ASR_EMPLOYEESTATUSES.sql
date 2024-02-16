CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_EMPLOYEESTATUSES (
	EMPLOYEE_STATUS_ID VARCHAR(16777216),
	EMPLOYEE_STATUS_NAME VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);