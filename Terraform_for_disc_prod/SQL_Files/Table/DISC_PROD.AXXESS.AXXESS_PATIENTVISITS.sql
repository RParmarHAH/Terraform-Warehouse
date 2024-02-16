CREATE OR REPLACE TABLE DISC_PROD.AXXESS.AXXESS_PATIENTVISITS (
	VISIT_ID VARCHAR(16777216),
	BRANCH_ID VARCHAR(16777216),
	EPISODE_ID VARCHAR(16777216),
	PATIENT_ID VARCHAR(16777216),
	ACCOUNT VARCHAR(16777216),
	BRANCH VARCHAR(16777216),
	PAYOR_TYPE VARCHAR(16777216),
	PAYOR_CLASS VARCHAR(16777216),
	EPISODE_PRIMARY_INSURANCE VARCHAR(16777216),
	CURRENT_PRIMARY_INSURANCE VARCHAR(16777216),
	START_OF_CARE_DATE VARCHAR(16777216),
	EPISODE_START_DATE VARCHAR(16777216),
	EPISODE_END_DATE VARCHAR(16777216),
	EPISODE_DISCHARGE_DATE VARCHAR(16777216),
	MRN VARCHAR(16777216),
	PATIENT_FIRST_NAME VARCHAR(16777216),
	PATIENT_LAST_NAME VARCHAR(16777216),
	PATIENT_STATUS VARCHAR(16777216),
	ADMISSION_STATUS VARCHAR(16777216),
	DATE_OF_BIRTH VARCHAR(16777216),
	PATIENT_AGE VARCHAR(16777216),
	CITY VARCHAR(16777216),
	COUNTY VARCHAR(16777216),
	STATE VARCHAR(16777216),
	ZIP_CODE VARCHAR(16777216),
	VISIT_NAME VARCHAR(16777216),
	VISIT_TYPE VARCHAR(16777216),
	VISIT_STATUS VARCHAR(16777216),
	VISIT_DATE VARCHAR(16777216),
	VISIT_TIME_IN VARCHAR(16777216),
	VISIT_TIME_OUT VARCHAR(16777216),
	SCHEDULE_DATE VARCHAR(16777216),
	CLINICIAN_NAME VARCHAR(16777216),
	IS_MISSED_VISIT VARCHAR(16777216),
	ADDRESSLINE_1 VARCHAR(16777216),
	ADDRESSLINE_2 VARCHAR(16777216),
	IS_ORDER_FOR_NEXT_EPISODE VARCHAR(16777216),
	IS_VISIT_AUTHORIZATION_REQUIRED VARCHAR(16777216),
	IS_VISIT_AUTHORIZED VARCHAR(16777216),
	ORDER_NUMBER VARCHAR(16777216),
	ORDER_EPISODE_ID VARCHAR(16777216),
	ORDER_CERTIFICATION_START_DATE VARCHAR(16777216),
	ORDER_CERTIFICATION_END_DATE VARCHAR(16777216),
	ORDER_MD_SIGNATURE_DATE VARCHAR(16777216),
	ORDER_PHYSICIAN VARCHAR(16777216),
	ORDER_RECEIVED_BY VARCHAR(16777216),
	ORDER_RECEIVED_DATE VARCHAR(16777216),
	ORDER_SENT_DATE VARCHAR(16777216),
	ORDER_TYPE VARCHAR(16777216),
	FACT_AR_ID VARCHAR(16777216),
	ISBILLABLE VARCHAR(16777216),
	IS_COMPLETED_VISIT VARCHAR(16777216),
	CASE_MANAGER_ID VARCHAR(16777216),
	CLINICIAN_ID VARCHAR(16777216),
	INSURANCE_FEE_SCHEDULE_ID VARCHAR(16777216),
	INSURANCE_ID VARCHAR(16777216),
	PAYER_ID VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG BOOLEAN
);