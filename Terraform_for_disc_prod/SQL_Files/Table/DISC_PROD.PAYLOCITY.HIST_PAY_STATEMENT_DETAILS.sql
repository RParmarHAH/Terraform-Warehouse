CREATE OR REPLACE TABLE DISC_PROD.PAYLOCITY.HIST_PAY_STATEMENT_DETAILS (
	COMPANYID VARCHAR(5),
	EMPLOYEEID NUMBER(38,0),
	YEAR NUMBER(38,0),
	APIRESPONSE VARIANT,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);