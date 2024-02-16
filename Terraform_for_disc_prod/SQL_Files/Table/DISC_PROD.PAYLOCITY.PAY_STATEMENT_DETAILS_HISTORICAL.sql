CREATE OR REPLACE TABLE DISC_PROD.PAYLOCITY.PAY_STATEMENT_DETAILS_HISTORICAL (
	COMPANYID VARCHAR(5),
	EMPLOYEEID NUMBER(38,0),
	YEAR NUMBER(38,0),
	AMOUNT NUMBER(12,3),
	CHECKDATE VARCHAR(16777216),
	DET VARCHAR(16777216),
	DETCODE VARCHAR(16777216),
	DETTYPE VARCHAR(16777216),
	ELIGIBLECOMPENSATION NUMBER(38,0),
	HOURS NUMBER(38,0),
	RATE NUMBER(38,0),
	TRANSACTIONNUMBER NUMBER(38,0),
	TRANSACTIONTYPE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);