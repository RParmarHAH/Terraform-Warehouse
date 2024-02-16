CREATE OR REPLACE TABLE DISC_PROD.ALAYACARE.HIST_EVV_VISIT (
	BRANCH_STATE_CODE VARCHAR(2),
	BRANCH_ID NUMBER(38,0),
	ALAYACARE_VISIT_ID NUMBER(38,0),
	INVOICE_NUMBER VARCHAR(300),
	APIRESPONSE VARIANT,
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);