CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.HIST_CV_CLINICALTASKCDE (
	DB VARCHAR(20) NOT NULL,
	RECSTAT VARCHAR(1),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	CLINICAL_TASK_CODE VARCHAR(11) NOT NULL,
	CLINICAL_TASK_DESC VARCHAR(31),
	DISCIPLINE_CODE VARCHAR(7),
	CLINICAL_TASK_CTG_CODE VARCHAR(3),
	FREQUENCY_CODE VARCHAR(15),
	TIME_CODE VARCHAR(15),
	DDL_SCORING_OPTION NUMBER(5,0),
	SCORE NUMBER(5,0),
	ESTIMATED_TIME NUMBER(5,0),
	PROCCODE VARCHAR(9),
	CB_LOCK_TIME_SCORE NUMBER(3,0),
	CB_COPY_AIDE_CARE_PLAN NUMBER(3,0),
	CB_REQUIRE_COMMENT_NO NUMBER(3,0),
	CB_APC_TASK NUMBER(3,0),
	DEX_ROW_ID NUMBER(10,0),
	CLINICAL_TASK_NOTE VARCHAR(4096),
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