CREATE OR REPLACE TABLE DW_PROD.STAGE.ALAYACARE_DIM_SERVICES_1_0 (
	SERVICE_KEY VARCHAR(50),
	SYSTEM_CODE VARCHAR(20),
	SOURCE_SYSTEM_ID NUMBER(38,0),
	SERVICE_CODE_ID VARCHAR(10),
	NAME VARCHAR(50),
	BILL_CODE_ID NUMBER(10,0),
	IS_EXPENSE BOOLEAN,
	IS_MULTIPLE BOOLEAN,
	OTHER_CODE VARCHAR(20),
	DEFAULT_COST NUMBER(18,2),
	DEFAULT_PAY_UNIT_FLAG NUMBER(5,0),
	DEFAULT_BILL_UNIT_FLAG NUMBER(5,0),
	CATEGORY_ID NUMBER(10,0),
	PAYROLL_CODE VARCHAR(50),
	DEFAULT_REIMBURSMENT NUMBER(18,2),
	WC VARCHAR(50),
	SHIFT_PAY BOOLEAN,
	OT_PAY NUMBER(3,0),
	BILL_EXCLUDE_HOLIDAY BOOLEAN,
	PAY_EXCLUDED_HOLIDAY BOOLEAN,
	IS_CAT BOOLEAN,
	COMMISSION_RATE NUMBER(18,0),
	BONUS_POINTS NUMBER(18,0),
	ACTIVE BOOLEAN,
	REVENUE_CODE NUMBER(3,0),
	PAY BOOLEAN,
	POC_FIRST_BIL_LABLE_FLAG BOOLEAN,
	EXPENCE_TYPE_ID NUMBER(10,0),
	CREATED_DATE TIMESTAMP_NTZ(9),
	CREATED_USER VARCHAR(50),
	MODIFIED_DATE TIMESTAMP_NTZ(9),
	MODIFIED_USER VARCHAR(50),
	TS VARCHAR(100),
	LIST_ITEM_TYPE NUMBER(3,0),
	RPT_GROUP_ID NUMBER(10,0),
	BRANCH_ID NUMBER(10,0),
	OVERRIDE_ID NUMBER(10,0),
	DESCRIPTION VARCHAR(1000),
	TAX_GROUP_ID NUMBER(10,0),
	LEGACY_ID NUMBER(10,0),
	LEGACY_BRANCH_ID NUMBER(10,0),
	ACCT_ID NUMBER(10,0),
	UPLOAD_TELEPHONY BOOLEAN,
	TELEPHONY_TASK_ID VARCHAR(4),
	INCLUDE_EFT BOOLEAN,
	PROJECTED_AVG_BILL_VISIT NUMBER(18,2),
	PROJECTED_AVG_PAY_VISIT NUMBER(18,2),
	PROJECTED_AVG_PAY_HOURLY NUMBER(18,2),
	PROJECTED_AVG_BILL_HOURLY NUMBER(18,2),
	IS_COPY BOOLEAN,
	IS_WORKING BOOLEAN,
	DEDUCTE_ARN VARCHAR(5),
	LIVE_IN_RPT_HRS NUMBER(18,0),
	ACCT_CODE VARCHAR(50),
	DISPLAY_ON_CLIENT_PORTAL BOOLEAN,
	DISPLAY_ON_CAREGIVER_PORTAL BOOLEAN,
	THERAPY_COUNTING_TYPE NUMBER(3,0),
	MEDICARE_DISCIPLINE NUMBER(3,0),
	DOC_TYPE NUMBER(3,0),
	IS_MULTIPLE_SERVICE BOOLEAN,
	INSERT_DATE TIMESTAMP_NTZ(9),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	DELETED_FLAG BOOLEAN,
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN,
	ETL_INFERRED_MEMBER_FLAG BOOLEAN
);