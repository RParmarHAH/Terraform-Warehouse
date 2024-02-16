CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_DIAGNOSIS (
	DIAG_ID NUMBER(10,0),
	DIAG_CODE VARCHAR(10),
	DIAG_DESCRIPTION VARCHAR(256),
	DIAG_DIAGNOSISCATEGORY NUMBER(10,0),
	DIAG_EFFECTIVESTARTDATE TIMESTAMP_NTZ(9),
	DIAG_EFFECTIVEENDDATE TIMESTAMP_NTZ(9),
	DIAG_SURGICALPROCEDURE BOOLEAN,
	DIAG_CREATEDDATE TIMESTAMP_NTZ(9),
	DIAG_CREATEDUSER VARCHAR(50),
	DIAG_MODIFIEDDATE TIMESTAMP_NTZ(9),
	DIAG_MODIFIEDUSER VARCHAR(50),
	DIAG_TS VARCHAR(100),
	DIAG_DIAGNOSISID NUMBER(10,0),
	DIAG_SURGICALPROCEDUREID NUMBER(10,0),
	DIAG_LONGDESCRIPTION VARCHAR(350),
	DIAG_VERSION NUMBER(3,0),
	DIAG_ACTIVE BOOLEAN,
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