CREATE OR REPLACE TABLE DW_PROD.STAGE.TRUSTPOINTDATA_DIM_PAYCODE_MAPPING (
	PAYCODE_MAPPING_KEY VARCHAR(32) NOT NULL,
	SOURCE_SYSTEM_ID NUMBER(38,0) NOT NULL,
	SYSTEM_CODE VARCHAR(20) NOT NULL,
	STATE_CODE VARCHAR(2) COMMENT 'Abbreviation for the state the code applies to',
	PAY_CODE VARCHAR(50) NOT NULL,
	PAY_CODE_DESCRIPTION VARCHAR(2000),
	PAY_CODE_TYPE VARCHAR(10),
	PAY_CODE_CATEGORY VARCHAR(50) COMMENT 'Benefits, Bereavement, Bonus, Holiday, On-Call, Overtime, Regular Pay, Reimbursement, Tax, Travel Time, Training, Union Dues, Vacation',
	FINANCE_CATEGORY VARCHAR(50),
	REVENUE_CATEGORY VARCHAR(50),
	REVENUE_SUBCATEGORY_CODE VARCHAR(10),
	REVENUE_SUBCATEGORY_NAME VARCHAR(50),
	FIRST_USED_DATE DATE,
	MOST_RECENT_USED_DATE DATE,
	NUMBER_EMPLOYEES_USED NUMBER(38,0),
	ACTIVE_FLAG BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'Active or Inactive',
	ADMIN_PAY_RATE_FLAG BOOLEAN,
	FIELD_PAY_RATE_FLAG BOOLEAN,
	INCLUDE_SALARY_PAYRATE_CALC_FLAG BOOLEAN,
	INCLUDE_FULL_TIME_HOURS_CALC_FLAG BOOLEAN,
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL,
	constraint PK_DIM_PAYCODE_MAPPING primary key (PAYCODE_MAPPING_KEY)
)COMMENT='Map pay codes to categories for use in data extracts'
;