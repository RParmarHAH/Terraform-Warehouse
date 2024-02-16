CREATE OR REPLACE TABLE DISC_PROD.CLEARCARE.REFERRAL_SOURCES_REFERRALSOURCE (
	ID NUMBER(38,0) NOT NULL,
	AGENCY_ID NUMBER(38,0),
	CLIENT_COUNT NUMBER(38,0),
	PROSPECT_COUNT NUMBER(38,0),
	CAREGIVER_COUNT NUMBER(38,0),
	APPLICANT_COUNT NUMBER(38,0),
	UNIQUE_KEY VARCHAR(16383),
	CREATED TIMESTAMP_TZ(9),
	UPDATED TIMESTAMP_TZ(9),
	REFERRAL_SOURCE_TYPE_ID NUMBER(38,0),
	LIFETIME_VALUE FLOAT,
	OWNER_ID NUMBER(38,0),
	ACTIVITY_ALERT_DAYS NUMBER(38,0),
	ACTIVITY_ALERT_DAYS_MODIFIED DATE,
	WEB_ADDRESS VARCHAR(16383),
	DELETED TIMESTAMP_TZ(9),
	ORIGINATOR_ID NUMBER(38,0),
	LAST_UPDATED_BY_ID NUMBER(38,0),
	DELETED_BY_ID NUMBER(38,0),
	COMMUNITY_COUNT NUMBER(38,0),
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