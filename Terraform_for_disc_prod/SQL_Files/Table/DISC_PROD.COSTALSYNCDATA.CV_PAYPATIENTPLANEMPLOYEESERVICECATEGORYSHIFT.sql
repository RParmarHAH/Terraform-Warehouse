CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_PAYPATIENTPLANEMPLOYEESERVICECATEGORYSHIFT (
	DB VARCHAR(20),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	START_DATE TIMESTAMP_NTZ(9),
	END_DATE TIMESTAMP_NTZ(9),
	DDL_PAT_PLAN NUMBER(3,0),
	PATIENT_NUMBER VARCHAR(9),
	PLAN_CODE VARCHAR(7),
	NURSE_ID VARCHAR(9),
	SERVICE_CATEGORY_CODE VARCHAR(7),
	SHIFT_CODE VARCHAR(3),
	BASE_RATE NUMBER(19,5),
	WEEKDAY_PAYRATE_TYPE NUMBER(5,0),
	WEEKEND_PAYRATE_TYPE NUMBER(5,0),
	WEEKEND_PAYRATE NUMBER(19,5),
	HOLIDAY_PAYRATETYPE_ARR3_1 NUMBER(5,0),
	HOLIDAY_PAYRATETYPE_ARR3_2 NUMBER(5,0),
	HOLIDAY_PAYRATETYPE_ARR3_3 NUMBER(5,0),
	HOLIDAY_PAYRATE_ARR3_1 NUMBER(19,5),
	HOLIDAY_PAYRATE_ARR3_2 NUMBER(19,5),
	HOLIDAY_PAYRATE_ARR3_3 NUMBER(19,5),
	ROW_ID NUMBER(10,0),
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);