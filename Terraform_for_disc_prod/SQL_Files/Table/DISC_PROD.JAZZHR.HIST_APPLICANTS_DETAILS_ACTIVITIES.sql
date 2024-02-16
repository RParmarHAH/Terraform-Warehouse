CREATE OR REPLACE TABLE DISC_PROD.JAZZHR.HIST_APPLICANTS_DETAILS_ACTIVITIES (
	ACTIVITY_ID VARCHAR(16777216),
	APPLICANT_ID VARCHAR(16777216),
	ACTIVITY_DETAILS VARCHAR(16777216),
	ACTIVITY_DATE VARCHAR(16777216),
	ACTIVITY_TIME VARCHAR(16777216),
	APPLY_DATE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);