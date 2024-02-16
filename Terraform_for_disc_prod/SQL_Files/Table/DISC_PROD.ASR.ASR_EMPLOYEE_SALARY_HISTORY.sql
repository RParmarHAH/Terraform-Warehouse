CREATE OR REPLACE TABLE DISC_PROD.ASR.ASR_EMPLOYEE_SALARY_HISTORY (
	EMPLOYEESALARYHISTORYID VARCHAR(16777216),
	EMPLOYEEID VARCHAR(16777216),
	SALARYSTARTDATE VARCHAR(16777216),
	RATE VARCHAR(16777216),
	MILAGECOMPENSATION VARCHAR(16777216),
	COMBINEDRATE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);