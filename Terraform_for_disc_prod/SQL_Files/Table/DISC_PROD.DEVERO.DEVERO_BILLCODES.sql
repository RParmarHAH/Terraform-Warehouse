CREATE OR REPLACE TABLE DISC_PROD.DEVERO.DEVERO_BILLCODES (
	AGENCY VARCHAR(16777216),
	FORM VARCHAR(16777216),
	USERTYPE VARCHAR(16777216),
	BILLINGCODE VARCHAR(16777216),
	DESCRIPTION VARCHAR(16777216),
	ORDERS VARCHAR(16777216),
	BILLABLE VARCHAR(16777216),
	ACTIVE VARCHAR(16777216),
	EVVENABLED VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);