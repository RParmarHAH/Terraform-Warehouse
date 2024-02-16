CREATE OR REPLACE TABLE DISC_PROD.CCSI.BRANCH_MAPPING (
	SRNO NUMBER(38,0),
	BRANCH_CODE VARCHAR(10),
	BRANCH_NAME VARCHAR(100),
	ADDRESS VARCHAR(100),
	CITY VARCHAR(100),
	STATE VARCHAR(10),
	ZIP VARCHAR(100),
	PHONE VARCHAR(100),
	TOLL_FREE_PHONE VARCHAR(100),
	FAX VARCHAR(100),
	EMAIL VARCHAR(100),
	CREATED_DATE TIMESTAMP_NTZ(9),
	CREATED_BY VARCHAR(30),
	UPDATED_DATE TIMESTAMP_NTZ(9),
	UPDATED_BY VARCHAR(30)
);