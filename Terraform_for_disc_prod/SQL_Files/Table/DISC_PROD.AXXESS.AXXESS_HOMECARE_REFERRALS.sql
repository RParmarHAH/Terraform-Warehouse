CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_HOMECARE_REFERRALS (
	REFERRAL_ID VARCHAR(16777216),
	AGENCY_ID VARCHAR(16777216),
	BRANCH_ID VARCHAR(16777216),
	AGENCY_NAME VARCHAR(16777216),
	BRANCH_NAME VARCHAR(16777216),
	REFERRAL_DATE VARCHAR(16777216),
	REFERRAL_FIRST_NAME VARCHAR(16777216),
	REFERRAL_LAST_NAME VARCHAR(16777216),
	ADMISSION_SOURCE VARCHAR(16777216),
	REFERRAL_DOB VARCHAR(16777216),
	REFERRAL_GENDER VARCHAR(16777216),
	REFERRAL_STATUS VARCHAR(16777216),
	REFERRAL_IS_NONMEDICAL VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);