CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_BRANCHINFO (
	BRANCH_ID VARCHAR(16777216),
	ADDRESS_LINE_1 VARCHAR(16777216),
	ADDRESS_ZIPCODE VARCHAR(16777216),
	ADDRESS_STATECODE VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);