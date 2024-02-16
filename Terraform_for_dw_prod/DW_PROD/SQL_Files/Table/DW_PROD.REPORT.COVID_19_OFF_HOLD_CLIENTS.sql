CREATE OR REPLACE TABLE DW_PROD.REPORT.COVID_19_OFF_HOLD_CLIENTS (
	STATE VARCHAR(2) NOT NULL,
	OFFICE_NUMBER VARCHAR(5) NOT NULL,
	OFFICE_NAME VARCHAR(100) NOT NULL,
	ON_HOLD_END_DATE DATE NOT NULL,
	CLIENT_COUNT NUMBER(20,0) NOT NULL,
	BRANCH_KEY VARCHAR(38) NOT NULL,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	constraint FK_COVID_19_OFF_HOLD_STATE foreign key (STATE) references DW_PROD.HAH.DIM_STATE(STATE_ISO_CODE)
);