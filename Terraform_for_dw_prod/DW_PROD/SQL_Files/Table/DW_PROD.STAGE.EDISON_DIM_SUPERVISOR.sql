CREATE OR REPLACE TABLE DW_PROD.STAGE.EDISON_DIM_SUPERVISOR (
	SUPERVISOR_KEY VARCHAR(32) NOT NULL,
	SUPERVISOR_CODE VARCHAR(50) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SUPERVISOR_NAME VARCHAR(100),
	SUPERVISOR_STATE_CODE VARCHAR(30),
	SUPERVISOR_JOB_CODE VARCHAR(255),
	SUPERVISOR_JOB_TITLE VARCHAR(255),
	EFFECTIVE_FROM_DATE TIMESTAMP_NTZ(9) NOT NULL,
	EFFECTIVE_TO_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN NOT NULL,
	constraint PK_DIM_SUPERVISOR primary key (SUPERVISOR_KEY)
);