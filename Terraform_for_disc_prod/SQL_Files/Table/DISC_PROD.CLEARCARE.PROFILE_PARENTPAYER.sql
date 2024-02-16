CREATE OR REPLACE TABLE DISC_PROD.CLEARCARE.PROFILE_PARENTPAYER (
	ID NUMBER(38,0) NOT NULL,
	CREATED TIMESTAMP_TZ(9),
	UPDATED TIMESTAMP_TZ(9),
	AGENCY_ID NUMBER(38,0),
	PAYEE_ID VARCHAR(16383),
	INVOICE_TYPE NUMBER(38,0),
	MULTI_CLIENT_INVOICE BOOLEAN,
	INVOICE_DUEDATE_TERMS NUMBER(38,0),
	PROVIDER_NPI VARCHAR(16383),
	QUALIFIER VARCHAR(16383),
	PAYER_ID VARCHAR(16383),
	DEFAULT_MILEAGE_RATE FLOAT,
	ONE_AUTHORIZATION_PER_INVOICE BOOLEAN,
	HEALTH_PLAN_ID VARCHAR(16383),
	PARENT_PAYER_IN_BOX_38 BOOLEAN,
	SHOW_CARELOG_START_AND_END_IN_DESCRIPTION BOOLEAN,
	PAYS_EXPENSES BOOLEAN,
	PAYS_TAX BOOLEAN,
	BOX_23_ON_MULTIPAGE_INVOICES VARCHAR(16383),
	DELETED TIMESTAMP_TZ(9),
	ORIGINATOR_ID NUMBER(38,0),
	LAST_UPDATED_BY_ID NUMBER(38,0),
	DELETED_BY_ID NUMBER(38,0),
	PLAN_TYPE NUMBER(38,0),
	BOX_31_CUSTOM_NAME VARCHAR(16383),
	TRACK_IN_N_MINUTE_UNITS NUMBER(38,0),
	LAIM_SUBMISSION_METHOD NUMBER(38,0),
	REQUIRES_CARE_LOGS BOOLEAN,
	BUSINESS_ENTITY_ID VARCHAR(16383),
	BUSINESS_ENTITY_MEDICAID_ID VARCHAR(16383),
	USER_ID VARCHAR(16383),
	ENCRYPTED_PASSWORD VARCHAR(16383),
	SFTP_URL VARCHAR(16383),
	SFTP_USER_ID VARCHAR(16383),
	ENCRYPTED_SFTP_PASSWORD VARCHAR(16383),
	EVV_MANDATED BOOLEAN,
	EVV_PROVIDER VARCHAR(16383),
	CLAIM_LINE_ITEM_CONTENT NUMBER(38,0),
	LINE_ITEMS_PER_CLAIM NUMBER(38,0),
	BILLING_PROVIDER_TAXONOMY_CODE VARCHAR(16383),
	INTERCHANGE_RECEIVER_ID VARCHAR(16383),
	INTERCHANGE_RECEIVER_ID_QUALIFIER NUMBER(38,0),
	INTERCHANGE_SENDER_ID VARCHAR(16383),
	INTERCHANGE_SENDER_ID_QUALIFIER NUMBER(38,0),
	PAYER_IDENTIFIER VARCHAR(16383),
	PAYER_TYPE NUMBER(38,0),
	RECEIVER_PRIMARY_IDENTIFIER VARCHAR(16383),
	CLAIM_PLAN_TYPE VARCHAR(16383),
	PAYER_PROVIDER NUMBER(38,0),
	DATE_DELETED TIMESTAMP_TZ(9),
	FRANCHISOR_ID NUMBER(38,0),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_TASK_KEY NUMBER(38,0) NOT NULL,
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_INSERTED_BY VARCHAR(100) NOT NULL,
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9) NOT NULL,
	ETL_LAST_UPDATED_BY VARCHAR(100) NOT NULL,
	ETL_DELETED_FLAG BOOLEAN NOT NULL
);