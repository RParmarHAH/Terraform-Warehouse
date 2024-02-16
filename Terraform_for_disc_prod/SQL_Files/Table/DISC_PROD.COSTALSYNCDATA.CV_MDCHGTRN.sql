CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_MDCHGTRN (
	DB VARCHAR(25),
	RECSTAT VARCHAR(1),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	CRLF VARCHAR(3),
	PATIENT_NUMBER VARCHAR(9),
	SERVICE_DATE TIMESTAMP_NTZ(9),
	BILL_NUMBER VARCHAR(7),
	SEQUENCE_NUMBER NUMBER(19,5),
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
	FAMILY_PLAN NUMBER(3,0),
	EMERGENCY NUMBER(3,0),
	COORDINATION__BENEFITS NUMBER(3,0),
	JOURNAL_NUMBER VARCHAR(7),
	PATIENT_BALANCE12_2 NUMBER(19,5),
	PLAN_BALANCE12_2 NUMBER(19,5),
	DDL_CHARGE_SELECT_NOSV NUMBER(5,0),
	EQUIPMENT_TRAN_NUMBER VARCHAR(7),
	RX_NUMBER VARCHAR(11),
	RECLAIM_STATUS VARCHAR(1),
	LAST_POST_DATE TIMESTAMP_NTZ(9),
	START_TIME TIMESTAMP_NTZ(9),
	END_TIME TIMESTAMP_NTZ(9),
	TIME_UNIT NUMBER(19,5),
	EMERGENCY_UNIT NUMBER(19,5),
	PHYSICAL_UNIT NUMBER(19,5),
	POSTING_STATUS VARCHAR(1),
	USE_APPROVED NUMBER(3,0),
	APPROVED_AMOUNT82 NUMBER(19,5),
	CHARGE_ADJUSTMENT NUMBER(3,0),
	CHARGE_AMOUNT82 NUMBER(19,5),
	PPR_PAYMENT_METHOD NUMBER(5,0),
	PAYMENT_AMOUNT82 NUMBER(19,5),
	LOCATION_CODE VARCHAR(3),
	PANEL_CODE VARCHAR(9),
	DEPARTMENT__CODE VARCHAR(3),
	NUMBER_OF_VISIT NUMBER(10,0),
	SCHEDULE_NUMBER VARCHAR(11),
	TRANSFER_NUMBER VARCHAR(9),
	DISCOUNT_AMOUNT NUMBER(19,5),
	UNIT_DISCOUNTED_FEE NUMBER(19,5),
	DISCOUNTED_FEE NUMBER(19,5),
	UNIT_COST NUMBER(19,5),
	COST NUMBER(19,5),
	UNIT_PROFESSIONAL_FEE NUMBER(19,5),
	PROFESSIONAL_FEE NUMBER(19,5),
	UNIT_MAXIMUM_AMOUNT NUMBER(19,5),
	MAXIMUM_AMOUNT NUMBER(19,5),
	UNIT_CO_PAYMENT_CHARGE NUMBER(19,5),
	CO_PAYMENT__CHARGE NUMBER(19,5),
	BILL_ADJUSTMENT_NUMBER VARCHAR(7),
	CB_SECONDARY_CLAIM NUMBER(3,0),
	CB_CO_PAY_TRANSFER NUMBER(3,0),
	DDL_CHARGE_SOURCE NUMBER(5,0),
	DEBIT_BILL_NUMBER VARCHAR(7),
	DEBIT_BILL_NUMBER_SEQ NUMBER(19,5),
	TRANSACTION_NUMBER VARCHAR(5),
	UNIFIED_TRANSACTION_NUM VARCHAR(7),
	CB_NON_COVERED_CHARGES NUMBER(3,0),
	UNIT_OF_MEASURE VARCHAR(11),
	NUMBER_OF_DAYS_HOURS NUMBER(19,5),
	DDL_BILL_TYPE NUMBER(5,0),
	CB_DELETED NUMBER(3,0),
	INTERFACE_BILL_NUMBER VARCHAR(15),
	SCHEDULE_TIME TIMESTAMP_NTZ(9),
	DURATION VARCHAR(5),
	REFERRING_SOURCE_CODE VARCHAR(7),
	LAST_PAYMENT_POST_DATE TIMESTAMP_NTZ(9),
	CERT_TRAN_NUMBER VARCHAR(11),
	BATCH_NUMBER VARCHAR(11),
	ADMISSION_NUMBER VARCHAR(7),
	BILL_DATE TIMESTAMP_NTZ(9),
	FIRST_PAYMENT_DATE TIMESTAMP_NTZ(9),
	FIRST_PAYMENT_POST_DATE TIMESTAMP_NTZ(9),
	TRANSACTION_SERVICE_DATE TIMESTAMP_NTZ(9),
	TRANSACTION_POST_DATE TIMESTAMP_NTZ(9),
	FIRST_TRAN_DATE TIMESTAMP_NTZ(9),
	FIRST_TRAN_POST_DATE TIMESTAMP_NTZ(9),
	MAX_TRAN_DATE TIMESTAMP_NTZ(9),
	MAX_TRAN_POST_DATE TIMESTAMP_NTZ(9),
	MODIFIER4 VARCHAR(3),
	SOURCE_SERIAL NUMBER(19,5),
	SOURCE_SEQUENCE NUMBER(19,5),
	NDC_NUMBER VARCHAR(15),
	UNIT_PRICE NUMBER(19,5),
	NDC_UNIT_MEASURE VARCHAR(11),
	UNIT_QUANTITY NUMBER(19,5),
	PRESCRIPTION_NUMBER VARCHAR(21),
	MDS_NUMBER VARCHAR(15),
	CHARGE_SOURCE_ID VARCHAR(41),
	DEX_ROW_ID NUMBER(10,0),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);