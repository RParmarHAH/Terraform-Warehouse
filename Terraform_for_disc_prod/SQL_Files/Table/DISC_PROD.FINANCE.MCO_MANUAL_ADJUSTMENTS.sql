CREATE OR REPLACE TABLE DISC_PROD.FINANCE.MCO_MANUAL_ADJUSTMENTS (
	STATE_NAME VARCHAR(30),
	YEAR VARCHAR(4),
	MONTH VARCHAR(15),
	PAYOR_CATEGORY VARCHAR(100),
	AMOUNT NUMBER(38,3),
	INCLUDE_FLAG BOOLEAN,
	DESCRIPTION VARCHAR(1000),
	TYPE VARCHAR(100),
	UPDATED_DATE TIMESTAMP_NTZ(9),
	MONTH_YEAR DATE,
	CONTRACT_NAME VARCHAR(255),
	REVENUE_CATEGORY VARCHAR(100),
	REVENUE_SUBCATEGORY VARCHAR(100),
	DISC_OPS_FLAG VARCHAR(100),
	CARVE_OUT_FLAG VARCHAR(100),
	CONTRACT_KEY VARCHAR(100),
	constraint MCO_MANUAL_ADJUSTMENTS_UN unique (PAYOR_CATEGORY),
	constraint MCO_MANUAL_ADJUSTMENTS_PK primary key (STATE_NAME, YEAR, MONTH, PAYOR_CATEGORY, AMOUNT, INCLUDE_FLAG, DESCRIPTION, TYPE, UPDATED_DATE, MONTH_YEAR)
);