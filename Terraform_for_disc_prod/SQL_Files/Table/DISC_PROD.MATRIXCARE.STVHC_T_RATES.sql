CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_RATES (
	RATE_ID NUMBER(19,0),
	RATE_OVERRIDETYPE NUMBER(3,0),
	RATE_RATETYPE NUMBER(3,0),
	RATE_SERVICECODEID NUMBER(10,0),
	RATE_BRANCHID NUMBER(10,0),
	RATE_REGIONID NUMBER(10,0),
	RATE_CLIENTID NUMBER(19,0),
	RATE_CAREGIVERID NUMBER(19,0),
	RATE_PAYERID NUMBER(19,0),
	RATE_RATE1 NUMBER(18,2),
	RATE_RATE2 NUMBER(18,2),
	RATE_RATE3 NUMBER(18,2),
	RATE_RATE4 NUMBER(18,2),
	RATE_RATE5 NUMBER(18,2),
	RATE_RATE6 NUMBER(18,2),
	RATE_UNITFLAG NUMBER(5,0),
	RATE_UNITSPECIFIC BOOLEAN,
	RATE_NOTES VARCHAR(255),
	RATE_EFFECTIVESTARTDATE TIMESTAMP_NTZ(9),
	RATE_EFFECTIVEENDDATE TIMESTAMP_NTZ(9),
	RATE_CREATEDDATE TIMESTAMP_NTZ(9),
	RATE_CREATEDUSER VARCHAR(50),
	RATE_MODIFIEDDATE TIMESTAMP_NTZ(9),
	RATE_MODIFIEDUSER VARCHAR(50),
	RATE_TS VARCHAR(100),
	RATE_OTRATE NUMBER(18,2),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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