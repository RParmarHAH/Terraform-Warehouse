CREATE OR REPLACE TABLE DISC_PROD.CCSI.RAWVRFP_LATEST (
	RECORD_NUMBER NUMBER(38,0),
	CLIENT_NAME VARCHAR(500),
	SERVICE_TYPE VARCHAR(50),
	HOURS_WORKED VARCHAR(100),
	EMPLOYEE_NUMBER VARCHAR(100),
	RECORD_ACCEPTED VARCHAR(50),
	OPERATOR_RESPONSE VARCHAR(50),
	PROCESSED_BY_WHICH_MODULE VARCHAR(10),
	RATE_OF_PAY VARCHAR(100),
	AREA VARCHAR(100),
	CONTRACT_NO VARCHAR(100),
	AGREEMENT_NO VARCHAR(100),
	PERIOD_DATE VARCHAR(100),
	PAY_PERIOD_ENDING_DATE VARCHAR(100),
	PAY_EMPLOYEE VARCHAR(100),
	TRANSACTION_TYPE VARCHAR(100),
	MILEAGE VARCHAR(100),
	EXTRA_HOURS VARCHAR(100),
	NON_BILLABLE_HOURS VARCHAR(100),
	TRAINING_HOURS VARCHAR(100),
	OVERTIME VARCHAR(100),
	SUPPLEMENTAL_EARNINGS VARCHAR(100),
	VACATION VARCHAR(100),
	SICK VARCHAR(100),
	HOME_HOLIDAY_HOURS VARCHAR(100),
	CLIENT_DESK VARCHAR(100),
	EMP_DESK VARCHAR(100),
	TRAVEL VARCHAR(100),
	PRIVATE_HOME VARCHAR(100),
	TRAINING_DATE VARCHAR(100),
	CREATED_BY_2 VARCHAR(100),
	CREATION_DATE VARCHAR(100),
	CREATED_AT VARCHAR(100),
	NO_UNITS VARCHAR(100),
	UNITS VARCHAR(100),
	CITY_OPTED_OUT VARCHAR(100),
	AREA_2 VARCHAR(100),
	TRAVEL_HOURS VARCHAR(100),
	DAY_OF_WEEK VARCHAR(100),
	WEEK_AND_YEAR VARCHAR(100),
	CREATED_DATE VARCHAR(100),
	CREATED_BY VARCHAR(100),
	UPDATED_DATE VARCHAR(100),
	UPDATED_BY VARCHAR(100),
	UPDATE_1_ON VARCHAR(100),
	UPDATE_1_BY VARCHAR(100),
	UPDATE_1_AT VARCHAR(100),
	UPDATE_2_ON VARCHAR(100),
	UPDATE_2_BY VARCHAR(100),
	UPDATE_2_AT VARCHAR(100),
	UPDATE_3_ON VARCHAR(100),
	UPDATE_3_BY VARCHAR(100),
	UPDATE_3_AT VARCHAR(100),
	DAY_OF_SERVICE VARCHAR(100),
	CLIENT_ID VARCHAR(100),
	BILLING_NUMBER VARCHAR(100),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);