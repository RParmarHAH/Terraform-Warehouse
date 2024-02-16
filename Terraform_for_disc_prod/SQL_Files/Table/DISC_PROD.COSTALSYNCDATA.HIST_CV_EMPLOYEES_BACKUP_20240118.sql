CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.HIST_CV_EMPLOYEES_BACKUP_20240118 (
	DB VARCHAR(128),
	USER_CODE VARCHAR(3),
	NURSE_ID VARCHAR(9),
	LAST_NAME VARCHAR(25),
	FIRST_NAME VARCHAR(15),
	LAST_FIRST_NAME VARCHAR(45),
	DISCIPLINE_CODE VARCHAR(7),
	SERVICE_CATEGORY_CODE VARCHAR(7),
	LOCATION_CODE VARCHAR(3),
	FACILITY_CODE VARCHAR(3),
	PROVIDER_CODE VARCHAR(7),
	ADDRESS VARCHAR(31),
	CITY VARCHAR(25),
	PHONE VARCHAR(11),
	WORK_PHONE VARCHAR(11),
	EMERGENCY_PHONE VARCHAR(11),
	BEEPER_NUMBER VARCHAR(11),
	ZONE_CODE VARCHAR(11),
	PAY_RATE NUMBER(19,5),
	DESCRIPTION30_FROM VARCHAR(31),
	DESCRIPTION30_THRU VARCHAR(31),
	SOCIAL_SECURITY_NUMBER VARCHAR(9),
	DEX_ROW_ID NUMBER(10,0),
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