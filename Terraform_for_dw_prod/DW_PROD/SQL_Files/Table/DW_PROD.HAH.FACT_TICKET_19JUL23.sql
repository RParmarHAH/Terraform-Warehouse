CREATE OR REPLACE TABLE DW_PROD.HAH.FACT_TICKET_19JUL23 (
	SYSTEM_CODE VARCHAR(20),
	TICKET_KEY VARCHAR(32),
	ID VARCHAR(20),
	SOURCE_SYSTEM_ID NUMBER(2,0),
	VIA VARCHAR(20),
	STATUS VARCHAR(20),
	PRIORITY VARCHAR(20),
	TYPE VARCHAR(30),
	REQUESTER_ID VARIANT,
	SUBMITTER_ID VARIANT,
	WH_EMPLOYEE_KEY VARCHAR(32),
	EMPLOYEE_KEY VARCHAR(32),
	SUBMITTER_KEY VARCHAR(32),
	ASSIGNEE_ID VARIANT,
	RECIPIENT VARCHAR(70),
	SATISFACTION_RATING VARCHAR(30),
	IS_PUBLIC VARIANT,
	SUBJECT VARCHAR(500),
	DESCRIPTION VARCHAR(16777216),
	ORGANIZATION_ID VARIANT,
	BRAND_ID VARIANT,
	COLLABORATOR_IDS VARIANT,
	EMAIL_CC_IDS VARIANT,
	EXTERNAL_ID VARIANT,
	FOLLOWER_IDS VARIANT,
	FOLLOWUP_IDS VARIANT,
	GROUP_ID VARIANT,
	SHARING_AGREEMENT_IDS VARIANT,
	TICKET_FORM_ID VARIANT,
	URL VARCHAR(1000),
	CREATED_AT VARCHAR(100),
	UPDATED_AT VARCHAR(100),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);