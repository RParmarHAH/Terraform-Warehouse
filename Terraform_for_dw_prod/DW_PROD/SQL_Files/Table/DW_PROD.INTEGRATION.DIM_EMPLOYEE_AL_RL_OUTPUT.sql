CREATE OR REPLACE TABLE DW_PROD.INTEGRATION.DIM_EMPLOYEE_AL_RL_OUTPUT (
	ID VARCHAR(16777216),
	EMPLOYEE_ID VARCHAR(50) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	EMPLOYEE_PID VARCHAR(32),
	EMPLOYEE_NUMBER VARCHAR(50),
	EMPLOYEE_DOB DATE,
	EMPLOYEE_DATE_OF_DEATH DATE,
	EMPLOYEE_HIRE_DATE DATE,
	EMPLOYEE_REHIRE_DATE DATE,
	EMPLOYEE_BENEFIT_START_DATE DATE,
	EMPLOYEE_FIRST_CHECK_DATE DATE,
	EMPLOYEE_LAST_CHECK_DATE DATE,
	EMPLOYEE_LAST_WORKED_DATE DATE,
	EMPLOYEE_TERMINATE_DATE DATE,
	REASON_TO_TERMINATE VARCHAR(50),
	ACTIVE_EMPLOYEE_FLAG BOOLEAN NOT NULL,
	ABLE_TO_REHIRE_FLAG BOOLEAN,
	EMPLOYEE_PREFIX VARCHAR(20),
	EMPLOYEE_FIRST_NAME VARCHAR(50),
	EMPLOYEE_MIDDLE_NAME VARCHAR(50),
	EMPLOYEE_LAST_NAME VARCHAR(50),
	EMPLOYEE_SUFFIX VARCHAR(20),
	EMPLOYEE_ADDRESS1 VARCHAR(150),
	EMPLOYEE_ADDRESS2 VARCHAR(150),
	EMPLOYEE_CITY VARCHAR(50),
	EMPLOYEE_STATE_CODE VARCHAR(2),
	EMPLOYEE_ZIP VARCHAR(11),
	EMPLOYEE_HOME_PHONE VARCHAR(20),
	EMPLOYEE_CELL_PHONE VARCHAR(20),
	EMPLOYEE_WORK_PHONE VARCHAR(20),
	EMPLOYEE_PERSONAL_EMAIL VARCHAR(150),
	EMPLOYEE_WORK_EMAIL VARCHAR(150),
	LINKED_IN_PROFILE_URL VARCHAR(250),
	EMPLOYEE_GENDER VARCHAR(6),
	EMPLOYEE_ETHNICITY VARCHAR(50),
	EMPLOYEE_LANGUAGE VARCHAR(25),
	EMPLOYEE_MARITAL_STATUS VARCHAR(20),
	EMPLOYEE_TYPE VARCHAR(20),
	EMPLOYEE_CATEGORY VARCHAR(15),
	EXEMPT_FLAG BOOLEAN,
	JOB_TITLE VARCHAR(100),
	JOB_DESCRIPTION VARCHAR(50),
	CLASS_ID VARCHAR(20),
	WORKERS_COMP VARCHAR(20),
	PAYROLL_ID VARCHAR(20),
	PERCENT_401K_DEDUCTION NUMBER(5,2),
	AMOUNT_401K_DEDUCTION NUMBER(7,2),
	JAZZHR_APPLICANT_ID VARCHAR(150),
	JAZZHR_USER_ID VARCHAR(150),
	JAZZHR_CONTACT_ID VARCHAR(150),
	WORK_STATE VARCHAR(2),
	SUTA_STATE VARCHAR(2),
	EMPLOYEE_DEPARTMENT VARCHAR(10),
	EMPLOYEE_OFFICE_CODE VARCHAR(5),
	PRIMARY_BRANCH_KEY VARCHAR(32),
	PRIMARY_BRANCH_STATE VARCHAR(2),
	PRIMARY_BRANCH_NAME VARCHAR(100),
	PRIMARY_BRANCH_SYSTEM_CODE VARCHAR(20),
	CASE_MANAGER_FLAG BOOLEAN,
	SUPERVISOR_FLAG BOOLEAN,
	COORDINATOR_FLAG BOOLEAN,
	LINKED_ID VARCHAR(50),
	SALARY VARCHAR(50),
	PAY_RATE VARCHAR(50),
	EFFECTIVE_FROM_DATE TIMESTAMP_NTZ(9) NOT NULL,
	EFFECTIVE_TO_DATE TIMESTAMP_NTZ(9) NOT NULL,
	MDM_DIM_EMPLOYEE_KEY VARCHAR(32),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN NOT NULL,
	CLUSTER_ID VARCHAR(16777216),
	RULE_ID VARCHAR(16777216),
	DEDUPE_INSERTED_DATE TIMESTAMP_NTZ(9)
);