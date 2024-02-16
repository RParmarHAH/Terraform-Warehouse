CREATE OR REPLACE TABLE DW_PROD.REPORT.COVID_19_NEW_REFERRALS (
	STATE VARCHAR(2) NOT NULL,
	OFFICE_NUMBER NUMBER(38,0) NOT NULL,
	OFFICE_NAME VARCHAR(100) NOT NULL,
	BRANCH_KEY VARCHAR(32) NOT NULL,
	CLIENT_KEY VARCHAR(50) NOT NULL,
	CLIENT_NUMBER VARCHAR(50) NOT NULL,
	CLIENT_NAME VARCHAR(200) NOT NULL,
	YEAR NUMBER(4,0) NOT NULL,
	MONTH NUMBER(2,0) NOT NULL,
	PERIOD_BEGIN_DATE DATE NOT NULL,
	PERIOD_NAME VARCHAR(50) NOT NULL,
	IS_ACTIVE VARCHAR(3) NOT NULL,
	REFERRAL_DATE DATE NOT NULL,
	FIRST_DATE_OF_SERVICE DATE,
	DAYS_TO_SERVICE NUMBER(10,0),
	HASNOSCHEDULEANDSERVICE VARCHAR(3) NOT NULL,
	HASSCHEDULE VARCHAR(3) NOT NULL,
	HASSCHEDULEBUTNOSERVICE VARCHAR(3) NOT NULL,
	AGINGBUCKET VARCHAR(100) NOT NULL,
	VISITS_SCHEDULED NUMBER(20,0),
	VISITS_COMPLETED NUMBER(20,0),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	constraint PK_COVID_19_NEW_REFERRALS_STATE_CLIENTKEY primary key (STATE, CLIENT_KEY),
	constraint FK_COVID_19_NEW_REFERRALS_STATE foreign key (STATE) references DW_PROD.HAH.DIM_STATE(STATE_ISO_CODE)
);