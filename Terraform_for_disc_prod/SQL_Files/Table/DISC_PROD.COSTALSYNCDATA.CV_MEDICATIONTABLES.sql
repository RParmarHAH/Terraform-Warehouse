CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.CV_MEDICATIONTABLES (
	DB VARCHAR(25),
	RECSTAT VARCHAR(1),
	ENTRY_USER VARCHAR(3),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(3),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	MEDICATION_CODE VARCHAR(31),
	MEDICATION_DESCRIPTION VARCHAR(101),
	MEDICATION_DOSE VARCHAR(21),
	ROUTE_NUMBER VARCHAR(11),
	MEDICATION_FREQUENCY VARCHAR(21),
	FORM VARCHAR(25),
	MEDICATION_CATEGORY VARCHAR(11),
	MEDICATION_NDC_NUMBER VARCHAR(21),
	COST NUMBER(19,5),
	ORDER_TYPE VARCHAR(15),
	FIRM_NUMBER VARCHAR(7),
	DDL_RXOTC NUMBER(5,0),
	FDB_MED_STATUS_CD VARCHAR(1),
	FDB_MED_STREN VARCHAR(15),
	FDB_MED_STREN_UOM VARCHAR(15),
	FDB_GCN_SEQNO NUMBER(10,0),
	FDB_GTC NUMBER(10,0),
	DDL_SRC NUMBER(5,0),
	CB_SQL_UPGRADE_01 NUMBER(3,0),
	FDB_MEDID NUMBER(10,0),
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