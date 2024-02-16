CREATE OR REPLACE TABLE DISC_PROD.PAYLOCITY.EMPLOYEE_LIST (
	COMPANYID VARCHAR(16777216),
	EMPLOYEEID NUMBER(38,0),
	STATUSCODE VARCHAR(16777216),
	STATUSTYPECODE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);