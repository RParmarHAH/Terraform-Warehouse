CREATE OR REPLACE TABLE DISC_PROD.DATA_CLEANSING.BRANCH_SRC_ATTRIBUTES_13_DEC_23 (
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SYSTEM_CODE VARCHAR(30),
	OFFICE_NUMBER NUMBER(38,0),
	OFFICE_CODE VARCHAR(5),
	OFFICE_NAME VARCHAR(100),
	SRC_BRANCH_ADDRESS VARCHAR(16777216),
	SRC_CITY VARCHAR(16777216),
	SRC_STATE_CODE VARCHAR(16777216),
	SRC_ZIP VARCHAR(16777216),
	SRC_BRANCH_ADDRESS_PROCESSED_FLAG BOOLEAN,
	SRC_BRANCH_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG BOOLEAN
);