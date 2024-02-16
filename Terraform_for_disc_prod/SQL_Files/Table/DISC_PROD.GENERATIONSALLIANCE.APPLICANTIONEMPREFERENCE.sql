CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.APPLICANTIONEMPREFERENCE (
	ID NUMBER(10,0) NOT NULL,
	NAME VARCHAR(50),
	RELATIONSHIP VARCHAR(20),
	YEARSKNOWN VARCHAR(2),
	PHONE VARCHAR(21),
	APPID NUMBER(10,0),
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