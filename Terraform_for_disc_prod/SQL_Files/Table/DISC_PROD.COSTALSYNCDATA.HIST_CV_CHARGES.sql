CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.HIST_CV_CHARGES (
	DB VARCHAR(128) NOT NULL,
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	PATIENT_NUMBER VARCHAR(9) NOT NULL,
	SERVICE_DATE TIMESTAMP_NTZ(9) NOT NULL,
	BILL_NUMBER VARCHAR(7) NOT NULL,
	SEQUENCE_NUMBER NUMBER(19,5) NOT NULL,
	SERVICE_THRU_DATE TIMESTAMP_NTZ(9),
	PROVIDER_CODE VARCHAR(7),
	BILLTO_STATUS_CODE VARCHAR(3),
	PLAN_CODE VARCHAR(7),
	PROCCODE VARCHAR(9),
	NUMBER_OF_UNIT NUMBER(19,5),
	UNIT_AMOUNT NUMBER(19,5),
	EXTENDED_AMOUNT NUMBER(19,5),
	PLACE_OF_SERVICE VARCHAR(3),
	FACILITY_CODE VARCHAR(3),
	TYPE_OF_SERVICE VARCHAR(3),
	MODIFIER1 VARCHAR(3),
	MODIFIER2 VARCHAR(3),
	MODIFIER3 VARCHAR(3),
	DIAGNOSTIC_REFERENCE1 VARCHAR(1),
	DIAGNOSTIC_REFERENCE2 VARCHAR(1),
	DIAGNOSTIC_REFERENCE3 VARCHAR(1),
	DIAGNOSTIC_REFERENCE4 VARCHAR(1),
	REMARK_20 VARCHAR(81),
	ACCEPT_ASSIGNMENT_BLANK NUMBER(3,0),
	APPROVED_AMOUNT10_2 NUMBER(19,5),
	BALANCE10_2 NUMBER(19,5),
	PATIENT_CHARGE NUMBER(19,5),
	PLAN_CHARGE NUMBER(19,5),
	BILLTO_AT_POST VARCHAR(3),
	PLAN_AT_POST VARCHAR(7),
	CLAIM_STATUS NUMBER(3,0),
	STATEMENT_STATUS NUMBER(3,0),
	CLAIM_COUNT VARCHAR(3),
	STATEMENT_COUNT VARCHAR(3),
	LAST_PAYMENT_DATE TIMESTAMP_NTZ(9),
	LAST_ADJUSTMENT_DATE TIMESTAMP_NTZ(9),
	LAST_BILLTO_DATE TIMESTAMP_NTZ(9),
	LAST_STATEMENT_DATE TIMESTAMP_NTZ(9),
	LAST_CLAIM_DATE TIMESTAMP_NTZ(9),
	POST_DATE TIMESTAMP_NTZ(9),
	BILL_TYPE NUMBER(3,0),
	JOURNAL_NUMBER VARCHAR(7),
	DDL_CHARGE_SELECT_NOSV NUMBER(5,0),
	LAST_POST_DATE TIMESTAMP_NTZ(9),
	USE_APPROVED NUMBER(3,0),
	APPROVED_AMOUNT82 NUMBER(19,5),
	CHARGE_AMOUNT82 NUMBER(19,5),
	PPR_PAYMENT_METHOD NUMBER(5,0),
	PAYMENT_AMOUNT82 NUMBER(19,5),
	LOCATION_CODE VARCHAR(3),
	PANEL_CODE VARCHAR(9),
	DEPARTMENT__CODE VARCHAR(3),
	SCHEDULE_NUMBER VARCHAR(11),
	TRANSFER_NUMBER VARCHAR(9),
	BILL_ADJUSTMENT_NUMBER VARCHAR(7),
	DDL_CHARGE_SOURCE NUMBER(5,0),
	NUMBER_OF_DAYS_HOURS NUMBER(19,5),
	DDL_BILL_TYPE NUMBER(5,0),
	INTERFACE_BILL_NUMBER VARCHAR(15),
	SCHEDULE_TIME TIMESTAMP_NTZ(9),
	DURATION VARCHAR(5),
	REFERRING_SOURCE_CODE VARCHAR(7),
	LAST_PAYMENT_POST_DATE TIMESTAMP_NTZ(9),
	CERT_TRAN_NUMBER VARCHAR(11),
	BATCH_NUMBER VARCHAR(11),
	ADMISSION_NUMBER VARCHAR(7),
	BILL_DATE TIMESTAMP_NTZ(9),
	TRANSACTION_SERVICE_DATE TIMESTAMP_NTZ(9),
	TRANSACTION_POST_DATE TIMESTAMP_NTZ(9),
	FIRST_TRAN_DATE TIMESTAMP_NTZ(9),
	FIRST_TRAN_POST_DATE TIMESTAMP_NTZ(9),
	MAX_TRAN_DATE TIMESTAMP_NTZ(9),
	MAX_TRAN_POST_DATE TIMESTAMP_NTZ(9),
	MODIFIER4 VARCHAR(3),
	CHARGE_SOURCE_ID VARCHAR(41),
	DEX_ROW_ID NUMBER(10,0),
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