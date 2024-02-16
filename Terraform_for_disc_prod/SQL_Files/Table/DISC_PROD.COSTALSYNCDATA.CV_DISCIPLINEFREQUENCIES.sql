CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_DISCIPLINEFREQUENCIES (
	DB VARCHAR(128),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	PATIENT_NUMBER VARCHAR(9),
	ADMISSION_NUMBER VARCHAR(7),
	SEQUENCE_NUMBER NUMBER(19,5),
	DISCIPLINE_SEQUENCE NUMBER(19,5),
	SERVICE_CATEGORY_CODE VARCHAR(7),
	LINE_NUMBER NUMBER(19,5),
	FREQUENCY_UNITS_ARR2_1 NUMBER(19,5),
	FREQUENCY_UNITS_ARR2_2 NUMBER(19,5),
	FREQUENCY_INT NUMBER(5,0),
	DDL_UNITS_FREQ_TYPE NUMBER(5,0),
	LENGTHVALUE NUMBER(5,0),
	DDL_VISITS_DURATION_TYPE NUMBER(5,0),
	FORMAT VARCHAR(31),
	ORDER_NUMBER VARCHAR(11),
	FREQUENCY_CODE VARCHAR(15),
	CB_DISCREPANCY NUMBER(3,0),
	DDL_REQUIREMENT_STATUS NUMBER(5,0),
	TREATMENT_START_DATE TIMESTAMP_NTZ(9),
	TREATMENT_END_DATE TIMESTAMP_NTZ(9),
	DISCIPLINE_ORDER_NUMBER VARCHAR(11),
	DISCHARGE_REASON_CODE VARCHAR(3),
	REASON_DATE TIMESTAMP_NTZ(9),
	WEEKLY_DAYS_ARRAY7_1 NUMBER(3,0),
	WEEKLY_DAYS_ARRAY7_2 NUMBER(3,0),
	WEEKLY_DAYS_ARRAY7_3 NUMBER(3,0),
	WEEKLY_DAYS_ARRAY7_4 NUMBER(3,0),
	WEEKLY_DAYS_ARRAY7_5 NUMBER(3,0),
	WEEKLY_DAYS_ARRAY7_6 NUMBER(3,0),
	WEEKLY_DAYS_ARRAY7_7 NUMBER(3,0),
	PHYSICIAN_ORDER_NUMBER VARCHAR(11),
	CERT_TRAN_NUMBER VARCHAR(11),
	CB_ORIGINAL NUMBER(3,0),
	NURSE_ID VARCHAR(9),
	ACTUAL_FREQUENCY_END_DT TIMESTAMP_NTZ(9),
	FREQ_START_TIME1_ARRAY_1 TIMESTAMP_NTZ(9),
	FREQ_START_TIME1_ARRAY_2 TIMESTAMP_NTZ(9),
	FREQ_START_TIME1_ARRAY_3 TIMESTAMP_NTZ(9),
	FREQ_START_TIME1_ARRAY_4 TIMESTAMP_NTZ(9),
	FREQ_START_TIME1_ARRAY_5 TIMESTAMP_NTZ(9),
	FREQ_START_TIME1_ARRAY_6 TIMESTAMP_NTZ(9),
	FREQ_START_TIME1_ARRAY_7 TIMESTAMP_NTZ(9),
	FREQ_END_TIME1_ARRAY_1 TIMESTAMP_NTZ(9),
	FREQ_END_TIME1_ARRAY_2 TIMESTAMP_NTZ(9),
	FREQ_END_TIME1_ARRAY_3 TIMESTAMP_NTZ(9),
	FREQ_END_TIME1_ARRAY_4 TIMESTAMP_NTZ(9),
	FREQ_END_TIME1_ARRAY_5 TIMESTAMP_NTZ(9),
	FREQ_END_TIME1_ARRAY_6 TIMESTAMP_NTZ(9),
	FREQ_END_TIME1_ARRAY_7 TIMESTAMP_NTZ(9),
	FREQ_START_TIME2_ARRAY_1 TIMESTAMP_NTZ(9),
	FREQ_START_TIME2_ARRAY_2 TIMESTAMP_NTZ(9),
	FREQ_START_TIME2_ARRAY_3 TIMESTAMP_NTZ(9),
	FREQ_START_TIME2_ARRAY_4 TIMESTAMP_NTZ(9),
	FREQ_START_TIME2_ARRAY_5 TIMESTAMP_NTZ(9),
	FREQ_START_TIME2_ARRAY_6 TIMESTAMP_NTZ(9),
	FREQ_START_TIME2_ARRAY_7 TIMESTAMP_NTZ(9),
	FREQ_END_TIME2_ARRAY_1 TIMESTAMP_NTZ(9),
	FREQ_END_TIME2_ARRAY_2 TIMESTAMP_NTZ(9),
	FREQ_END_TIME2_ARRAY_3 TIMESTAMP_NTZ(9),
	FREQ_END_TIME2_ARRAY_4 TIMESTAMP_NTZ(9),
	FREQ_END_TIME2_ARRAY_5 TIMESTAMP_NTZ(9),
	FREQ_END_TIME2_ARRAY_6 TIMESTAMP_NTZ(9),
	FREQ_END_TIME2_ARRAY_7 TIMESTAMP_NTZ(9),
	FREQ_START_TIME3_ARRAY_1 TIMESTAMP_NTZ(9),
	FREQ_START_TIME3_ARRAY_2 TIMESTAMP_NTZ(9),
	FREQ_START_TIME3_ARRAY_3 TIMESTAMP_NTZ(9),
	FREQ_START_TIME3_ARRAY_4 TIMESTAMP_NTZ(9),
	FREQ_START_TIME3_ARRAY_5 TIMESTAMP_NTZ(9),
	FREQ_START_TIME3_ARRAY_6 TIMESTAMP_NTZ(9),
	FREQ_START_TIME3_ARRAY_7 TIMESTAMP_NTZ(9),
	FREQ_END_TIME3_ARRAY_1 TIMESTAMP_NTZ(9),
	FREQ_END_TIME3_ARRAY_2 TIMESTAMP_NTZ(9),
	FREQ_END_TIME3_ARRAY_3 TIMESTAMP_NTZ(9),
	FREQ_END_TIME3_ARRAY_4 TIMESTAMP_NTZ(9),
	FREQ_END_TIME3_ARRAY_5 TIMESTAMP_NTZ(9),
	FREQ_END_TIME3_ARRAY_6 TIMESTAMP_NTZ(9),
	FREQ_END_TIME3_ARRAY_7 TIMESTAMP_NTZ(9),
	NUMBER_ARRAY_1 NUMBER(5,0),
	NUMBER_ARRAY_2 NUMBER(5,0),
	NUMBER_ARRAY_3 NUMBER(5,0),
	NUMBER_ARRAY_4 NUMBER(5,0),
	NUMBER_ARRAY_5 NUMBER(5,0),
	NUMBER_ARRAY_6 NUMBER(5,0),
	NUMBER_ARRAY_7 NUMBER(5,0),
	SERVICE_CATEGORY1_ARR7_1 VARCHAR(7),
	SERVICE_CATEGORY1_ARR7_2 VARCHAR(7),
	SERVICE_CATEGORY1_ARR7_3 VARCHAR(7),
	SERVICE_CATEGORY1_ARR7_4 VARCHAR(7),
	SERVICE_CATEGORY1_ARR7_5 VARCHAR(7),
	SERVICE_CATEGORY1_ARR7_6 VARCHAR(7),
	SERVICE_CATEGORY1_ARR7_7 VARCHAR(7),
	SERVICE_CATEGORY2_ARR7_1 VARCHAR(7),
	SERVICE_CATEGORY2_ARR7_2 VARCHAR(7),
	SERVICE_CATEGORY2_ARR7_3 VARCHAR(7),
	SERVICE_CATEGORY2_ARR7_4 VARCHAR(7),
	SERVICE_CATEGORY2_ARR7_5 VARCHAR(7),
	SERVICE_CATEGORY2_ARR7_6 VARCHAR(7),
	SERVICE_CATEGORY2_ARR7_7 VARCHAR(7),
	SERVICE_CATEGORY3_ARR7_1 VARCHAR(7),
	SERVICE_CATEGORY3_ARR7_2 VARCHAR(7),
	SERVICE_CATEGORY3_ARR7_3 VARCHAR(7),
	SERVICE_CATEGORY3_ARR7_4 VARCHAR(7),
	SERVICE_CATEGORY3_ARR7_5 VARCHAR(7),
	SERVICE_CATEGORY3_ARR7_6 VARCHAR(7),
	SERVICE_CATEGORY3_ARR7_7 VARCHAR(7),
	NURSE_ID1_ARR7_1 VARCHAR(9),
	NURSE_ID1_ARR7_2 VARCHAR(9),
	NURSE_ID1_ARR7_3 VARCHAR(9),
	NURSE_ID1_ARR7_4 VARCHAR(9),
	NURSE_ID1_ARR7_5 VARCHAR(9),
	NURSE_ID1_ARR7_6 VARCHAR(9),
	NURSE_ID1_ARR7_7 VARCHAR(9),
	NURSE_ID2_ARR7_1 VARCHAR(9),
	NURSE_ID2_ARR7_2 VARCHAR(9),
	NURSE_ID2_ARR7_3 VARCHAR(9),
	NURSE_ID2_ARR7_4 VARCHAR(9),
	NURSE_ID2_ARR7_5 VARCHAR(9),
	NURSE_ID2_ARR7_6 VARCHAR(9),
	NURSE_ID2_ARR7_7 VARCHAR(9),
	NURSE_ID3_ARR7_1 VARCHAR(9),
	NURSE_ID3_ARR7_2 VARCHAR(9),
	NURSE_ID3_ARR7_3 VARCHAR(9),
	NURSE_ID3_ARR7_4 VARCHAR(9),
	NURSE_ID3_ARR7_5 VARCHAR(9),
	NURSE_ID3_ARR7_6 VARCHAR(9),
	NURSE_ID3_ARR7_7 VARCHAR(9),
	RB_PATTERN_TYPE NUMBER(5,0),
	SERVICE_CATEGORY_2 VARCHAR(7),
	PATIENT_PLAN VARCHAR(7),
	CB_POC NUMBER(3,0),
	CB_DISCONTINUE NUMBER(3,0),
	DEX_ROW_ID NUMBER(10,0),
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