CREATE OR REPLACE TABLE DISC_PROD.ALAYACARE.CLAIMS_TRANSACTION (
	MAIN_TRANSACTION_ID NUMBER(38,0),
	MAIN_TRANSACTION_POSTING_DATE DATE,
	PAYMENT_METHOD_TYPE VARCHAR(250),
	MAIN_TRANSACTION_AMOUNT NUMBER(20,4),
	MAIN_TRANSACTION_MEMO VARCHAR(2500)
);