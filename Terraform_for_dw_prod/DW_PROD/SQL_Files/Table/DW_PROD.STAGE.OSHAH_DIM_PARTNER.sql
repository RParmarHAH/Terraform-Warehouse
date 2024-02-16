CREATE OR REPLACE TABLE DW_PROD.STAGE.OSHAH_DIM_PARTNER (
	PARTNER_KEY VARCHAR(32) NOT NULL,
	PARENT_PARTNER_KEY VARCHAR(32),
	PARENT_PARTNER_NAME VARCHAR(32),
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SYSTEM_CODE VARCHAR(100) NOT NULL,
	PARTNER_NAME VARCHAR(100),
	PARTNER_CODE VARCHAR(30),
	ACTIVE_FLAG BOOLEAN,
	START_DATE DATE,
	END_DATE DATE,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN
);