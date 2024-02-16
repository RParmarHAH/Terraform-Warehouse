CREATE OR REPLACE TABLE DISC_PROD.GPSYNCDATA.UPR40700 (
	DEX_ROW_ID NUMBER(10,0),
	DSCRIPTN VARCHAR(31),
	NOTEINDX NUMBER(19,5),
	STATECD VARCHAR(3),
	WCMOTMTH NUMBER(5,0),
	WCWGLIMT NUMBER(19,5),
	WKCMPAMT NUMBER(19,5),
	WKCMPCNT NUMBER(10,0),
	WKCMPMTH NUMBER(5,0),
	WKCMPUNT NUMBER(19,5),
	WRKRCOMP VARCHAR(7),
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