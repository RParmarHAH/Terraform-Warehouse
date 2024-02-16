CREATE OR REPLACE TABLE DW_PROD.STAGE.ROSTER_FACT_CLIENT_STATUS_HISTORY (
	FACT_CLIENT_STATUS_HISTORY_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(20,0) NOT NULL,
	STATUS_SOURCE VARCHAR(25) NOT NULL,
	START_DATE DATE,
	END_DATE DATE,
	CURRENT_RECORD_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL
);