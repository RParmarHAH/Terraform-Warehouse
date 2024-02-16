CREATE OR REPLACE TABLE DISC_PROD.ALAYACARE.BILLING_PERIOD (
	BILLING_PERIOD_ID NUMBER(38,0),
	START_DATE TIMESTAMP_NTZ(9),
	END_DATE TIMESTAMP_NTZ(9),
	CLOSED_AT TIMESTAMP_NTZ(9),
	CREATE_TIME TIMESTAMP_NTZ(9),
	UPDATE_TIME TIMESTAMP_NTZ(9),
	BACK_BILLING_DATE TIMESTAMP_NTZ(9),
	IDSTATUS VARCHAR(250),
	IS_CLOSED NUMBER(38,0),
	BRANCH_ID NUMBER(38,0),
	PROPERTIES_TBL_BILLING_PERIODS_ALLOW_SHIFT_CREATION VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_CREATE_TIME VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_CREATE_USER_ID VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_END_DATE VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_GUID VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_ID VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_IDMASTERACCOUNT VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_INVOICE_DATE VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_IS_CLOSED VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_PROGRAM_TYPE VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_TYPE VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_UPDATE_TIME VARCHAR(250),
	PROPERTIES_TBL_BILLING_PERIODS_UPDATE_USER_ID VARCHAR(250)
);