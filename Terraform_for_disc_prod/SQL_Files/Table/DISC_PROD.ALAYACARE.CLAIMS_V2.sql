CREATE OR REPLACE TABLE DISC_PROD.ALAYACARE.CLAIMS_V2 (
	CLAIM_ID VARCHAR(250),
	CLIENT_ID NUMBER(38,0),
	BILLCODE_ID NUMBER(38,0),
	FUNDER_ID NUMBER(38,0),
	VISIT_ID NUMBER(38,0),
	INVOICE_ID NUMBER(38,0),
	INTERNAL_CLAIM_NUMBER VARCHAR(250),
	INTERNAL_CLAIM_CONTROL_NUMBER VARCHAR(250),
	CLAIM_STATUS VARCHAR(250),
	IS_PREPARING NUMBER(1,0),
	IS_OPEN NUMBER(38,0),
	IS_MARKED_FOR_SUBMISSION NUMBER(1,0),
	UPDATE_FLOW VARCHAR(250),
	SERVICED_AT_DATE TIMESTAMP_NTZ(9),
	DELAY_REASON_CODE VARCHAR(250),
	DENIAL_REASON VARCHAR(16777216),
	QUANTITY NUMBER(13,2),
	BALANCE NUMBER(13,2),
	DUE NUMBER(13,2),
	PAID NUMBER(13,2),
	CURRENT_STATUS_DATE TIMESTAMP_NTZ(9),
	BANKING_BALANCE NUMBER(1,0),
	BANK_USED VARCHAR(250),
	BANK_AMOUNT NUMBER(13,2),
	INVOICE_ITEM_QTY NUMBER(13,2)
);