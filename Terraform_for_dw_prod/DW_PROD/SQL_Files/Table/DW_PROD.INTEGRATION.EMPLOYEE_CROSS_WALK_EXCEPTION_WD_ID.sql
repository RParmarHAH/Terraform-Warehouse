CREATE OR REPLACE TABLE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID (
	EMPLOYEE_ENTERPRISE_ID NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	WORKDAY_INTERNAL_ID VARCHAR(50),
	WORKDAY_ID_OF_MAPPING VARCHAR(50),
	primary key (EMPLOYEE_ENTERPRISE_ID)
);