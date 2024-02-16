CREATE OR REPLACE TABLE DW_PROD.REPORT.GP_EMPLOYEE_LIST (
	CURRENT_PAYROLL_EMPLOYEE_ID VARCHAR(16777216),
	CURRENT_PAYROLL_SOURCE_SYSTEM VARCHAR(16777216),
	CURRENT_AMS_EMPLOYEE_ID VARCHAR(50),
	CURRENT_AMS_SOURCE_SYSTEM VARCHAR(20),
	WORKDAY_ID VARCHAR(50),
	MARKET VARCHAR(30),
	EMPLOYEE_BRANCH_NAME VARCHAR(16777216),
	EMPLOYEE_FIRST_NAME VARCHAR(16777216),
	EMPLOYEE_MIDDLE_NAME VARCHAR(16777216),
	EMPLOYEE_LAST_NAME VARCHAR(16777216),
	SSN VARCHAR(8388608),
	EMPLOYEE_DOB VARCHAR(16777216),
	LAST_PAY_CHECK_DATE VARCHAR(16777216),
	EMPLOYEE_BENEFIT_START_DATE VARCHAR(16777216),
	IS_MIGRATED BOOLEAN,
	LEGACY_PAYROLL_EMPLOYEE_ID VARCHAR(16777216),
	LEGACY_PAYROLL_SOURCE_SYSTEM VARCHAR(16777216),
	LEGACY_BRANCH_NAME VARCHAR(100)
)COMMENT='TABLE CREATED FOR ITXEE-1459'
;