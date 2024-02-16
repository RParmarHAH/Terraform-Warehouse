CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.HIST_CV_CPTSKCDE (
	DB VARCHAR(15) NOT NULL,
	CARE_PLAN_NUMBER VARCHAR(15) NOT NULL,
	CLINICAL_TASK_CTG_CODE VARCHAR(3),
	CLINICAL_TASK_CODE VARCHAR(11) NOT NULL,
	CP_TASK_MEMO VARCHAR(8000),
	DISCIPLINE_CODE VARCHAR(7),
	FREQUENCY_CODE VARCHAR(11),
	TIME_CODE VARCHAR(15),
	NUMBER_OF_TIMES NUMBER(5,0),
	ESTIMATED_TIME NUMBER(5,0),
	DDL_CP_TASK_STATUS NUMBER(5,0),
	CP_TASK_STATUS_DATE TIMESTAMP_NTZ(9),
	LINE_NUMBER_INT NUMBER(5,0),
	CB_COPY_TO_PLANOFCARE NUMBER(3,0),
	CB_REQUIRE_COMMENT_NO NUMBER(3,0),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
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