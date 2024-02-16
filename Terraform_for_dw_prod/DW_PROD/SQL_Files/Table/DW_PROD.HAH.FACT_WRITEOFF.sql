CREATE OR REPLACE TABLE DW_PROD.HAH.FACT_WRITEOFF (
	WRITEOFF_KEY VARCHAR(32) NOT NULL,
	REPORT_DATE DATE NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(32) NOT NULL,
	CONTRACT_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	PERIOD_DATE DATE NOT NULL,
	WRITEOFF_DATE DATE,
	BRANCH_NAME VARCHAR(100),
	CLIENT_NUMBER VARCHAR(50),
	CONTRACT_CODE VARCHAR(10),
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SERVICE_AREA VARCHAR(20),
	WRITEOFF_TYPE VARCHAR(50),
	WRITEOFF_REASON_CODE VARCHAR(50),
	WRITEOFF_REASON_DESCRIPTION VARCHAR(100),
	WRITEOFF_AMOUNT NUMBER(38,3),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	constraint PK_FACT_WRITEOFF primary key (WRITEOFF_KEY),
	constraint FK_FACT_WRITEOFF_DIM_SOURCE_SYSTEM foreign key (SOURCE_SYSTEM_ID) references DW_PROD.HAH.DIM_SOURCE_SYSTEM(SOURCE_SYSTEM_ID)
);