CREATE OR REPLACE TABLE DW_PROD.PUBLIC.DIM_BRANCH_MERGED_BCKP_09152023 (
	ORIGINAL_BRANCH_KEY VARCHAR(32),
	ORIGINAL_BRANCH_NAME VARCHAR(100),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(38,0),
	ORIGINAL_SYSTEM_CODE VARCHAR(30),
	ORIGINAL_OFFICE_CODE VARCHAR(5),
	BRANCH_KEY VARCHAR(32),
	BRANCH_NAME VARCHAR(100),
	SYSTEM_CODE VARCHAR(30),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SOURCE_SYSTEM_TYPE VARCHAR(50),
	OFFICE_NUMBER NUMBER(38,0),
	OFFICE_CODE VARCHAR(5),
	OFFICE_NAME VARCHAR(100),
	OFFICE_NAME_ALT VARCHAR(100),
	DEPARTMENT_NAME VARCHAR(100),
	BRANCH_SERVICE_LINE VARCHAR(20),
	PARENT_FLAG BOOLEAN,
	PARENT_BRANCH_KEY VARCHAR(32),
	PARENT_OFFICE_NUMBER NUMBER(38,0),
	PARENT_OFFICE_CODE VARCHAR(5),
	PARENT_BRANCH_NAME VARCHAR(100),
	OFFICE_ADDRESS1 VARCHAR(150),
	OFFICE_ADDRESS2 VARCHAR(150),
	OFFICE_CITY VARCHAR(50),
	OFFICE_STATE_CODE VARCHAR(2),
	OFFICE_ZIP VARCHAR(12),
	OFFICE_PHONE VARCHAR(20),
	OFFICE_TOLL_FREE_PHONE VARCHAR(20),
	OFFICE_FAX VARCHAR(20),
	DETAILED_OFFICE_NAME VARCHAR(100),
	REGION_NUMBER NUMBER(38,0),
	REGION_NAME VARCHAR(50),
	REGION_MANAGER VARCHAR(50),
	REGION_MANAGER_EMPLOYEE_KEY VARCHAR(32),
	SUBREGION_NAME VARCHAR(30),
	PRIMARY_BRANCH_MANAGER_NAME VARCHAR(100),
	PRIMARY_BRANCH_EMAIL VARCHAR(250),
	PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY VARCHAR(32),
	SECONDARY_BRANCH_MANAGER_NAME VARCHAR(100),
	SECONDARY_BRANCH_EMAIL VARCHAR(250),
	SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY VARCHAR(32),
	RISKCONNECT_NODE_KEY VARCHAR(50),
	RISKCONNECT_NAME VARCHAR(100),
	HR_OFFICE_NUMBER VARCHAR(5),
	HR_OFFICE_NAME VARCHAR(100),
	ACTIVE_FLAG BOOLEAN,
	EFFECTIVE_FROM_DATE TIMESTAMP_NTZ(9),
	EFFECTIVE_TO_DATE TIMESTAMP_NTZ(9),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN,
	PARENT_BRANCH_NAME_SHORTENED VARCHAR(16777216),
	CONSOLIDATE_FLAG BOOLEAN,
	CONSOLIDATE_DATE DATE
);