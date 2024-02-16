CREATE OR REPLACE TABLE DISC_PROD.CLEARCARE.BILLING_RATESCHEDULE (
	ID NUMBER(38,0) NOT NULL,
	UPDATED TIMESTAMP_TZ(9),
	CREATED TIMESTAMP_TZ(9),
	AGENCY_ID NUMBER(38,0),
	RATE_TYPE NUMBER(38,0),
	NAME VARCHAR(16383),
	BILL_AMOUNT FLOAT,
	PAY_AMOUNT FLOAT,
	PAYROLL_CODE VARCHAR(16383),
	PRO_RATE BOOLEAN,
	ACTIVE BOOLEAN,
	RATE_CATEGORY_ID NUMBER(38,0),
	RATE_DEPT_CODE VARCHAR(16383),
	DELETED TIMESTAMP_TZ(9),
	ORIGINATOR_ID NUMBER(38,0),
	LAST_UPDATED_BY_ID NUMBER(38,0),
	DELETED_BY_ID NUMBER(38,0),
	META VARCHAR(16383),
	DATE_DELETED TIMESTAMP_TZ(9),
	FRANCHISOR_ID NUMBER(38,0),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);