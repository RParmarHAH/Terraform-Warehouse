CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.ADMIN_OPTIONS1 (
	COMPANYNAME VARCHAR(50) NOT NULL,
	BIT_ONLINEAPPLICATIONENABLED BOOLEAN,
	BIT_ONLINESERVICEENABLED BOOLEAN,
	ONLINEAPPLICATIONEMAILS VARCHAR(1000),
	APPLICATIONURLTOREDIRECT VARCHAR(1000),
	APPLICATIONCUSTOMMESSAGE VARCHAR(1000),
	SERVICEURLTOREDIRECT VARCHAR(1000),
	SERVICECUSTOMMESSAGE VARCHAR(1000),
	ONLINESERVICEEMAILS VARCHAR(1000),
	BIT_ENABLEDAILYSCHEDULEREMINDER BOOLEAN,
	USEREMAILFORSCHEDULEREMINDERSUMMARY VARCHAR(8000),
	EMAILACCOUNT_SCHEDULEREMINDER VARCHAR(100),
	BITCONVICTEDCRIME BOOLEAN,
	CERTIFICATIONTEXT VARCHAR(16777216),
	BITREQUIRESSN BOOLEAN,
	BITREMOVEEODISCLAIMER BOOLEAN,
	BITEMERGENCYCONTACTINFO BOOLEAN,
	EO_DISCLAIMER VARCHAR(1000),
	BIT_INCLUDECGAPPNOTIFICATION BOOLEAN,
	BIT_INCLUDECGTEXTNOTIFICATION BOOLEAN,
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