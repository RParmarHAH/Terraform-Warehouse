CREATE OR REPLACE TABLE DW_PROD.REPORT.COVID_19_DAILYCLIENTCOUNT (
	WEEK_OF_YEAR NUMBER(38,0),
	WEEK VARCHAR(200),
	WEEKDAY VARCHAR(3),
	DAYOFWEEK NUMBER(38,0),
	SERVICE_DATE DATE,
	STATE VARCHAR(2),
	BRANCH_NAME VARCHAR(100),
	BRANCH_KEY VARCHAR(38),
	EVENT_STATUS VARCHAR(30),
	CURRENTWEEKCLIENTCOUNT NUMBER(38,0),
	PREVIOUSWEEKCLIENTCOUNT NUMBER(38,0),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN
);