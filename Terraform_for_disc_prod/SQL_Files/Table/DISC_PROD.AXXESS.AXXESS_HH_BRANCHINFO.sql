CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_HH_BRANCHINFO (
	BRANCH_ID VARCHAR(16777216),
	CREATE_TIMESTAMP VARCHAR(16777216),
	UPDATE_TIMESTAMP VARCHAR(16777216),
	NAME VARCHAR(16777216),
	TAX_ID VARCHAR(16777216),
	NATIONAL_PROVIDER_NUMBER VARCHAR(16777216),
	MEDICARE_PROVIDER_NUMBER VARCHAR(16777216),
	MEDICAID_PROVIDER_NUMBER VARCHAR(16777216),
	LOCATION_NAME VARCHAR(16777216),
	LOCATION_ADDRESS_LINE1 VARCHAR(16777216),
	LOCATION_ADDRESS_LINE2 VARCHAR(16777216),
	LOCATION_ADDRESS_CITY_NAME VARCHAR(16777216),
	LOCATION_ADDRESS_STATE_CODE VARCHAR(16777216),
	LOCATION_ADDRESS_ZIP_CODE VARCHAR(16777216),
	PRIMARY_PHONE_NUMBER VARCHAR(16777216),
	FAX_NUMBER VARCHAR(16777216),
	AGENCY_ID VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);