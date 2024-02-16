CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_INVOICEPROCESS (
	INVPR_ID NUMBER(10,0),
	INVPR_NAME VARCHAR(50),
	INVPR_ACTIVE BOOLEAN,
	INVPR_SPDRAFTNAME VARCHAR(50),
	INVPR_SPCHECKTSNAME VARCHAR(50),
	INVPR_SPFINALIZENAME VARCHAR(50),
	INVPR_SPUNBILLBATCH VARCHAR(50),
	INVPR_SPUNBILLINVOICE VARCHAR(50),
	INVPR_SPREVERSEINVOICE VARCHAR(50),
	INVPR_SPTRANSFERINVOICE VARCHAR(50),
	INVPR_INFOCLASSID NUMBER(10,0),
	INVPR_CREATEDDATE TIMESTAMP_NTZ(9),
	INVPR_CREATEDUSER VARCHAR(50),
	INVPR_MODIFIEDDATE TIMESTAMP_NTZ(9),
	INVPR_MODIFIEDUSER VARCHAR(50),
	INVPR_TS VARCHAR(100),
	INVPR_DESCRIPTION VARCHAR(1000),
	INVPR_SPCHECKEDITS VARCHAR(50),
	INVPR_GROUPBY NUMBER(3,0),
	INVPR_GROUPBYAUTH BOOLEAN,
	INVPR_SPGROUPINGLOGIC VARCHAR(50),
	INVPR_SPLATEGROUPING VARCHAR(50),
	INVPR_KEYPREPARECOB VARCHAR(20),
	INVPR_KEYCREATECOB VARCHAR(20),
	INVPR_PROCESSINGINSTRUCTIONS VARIANT,
	INVPR_ISPPS NUMBER(3,0),
	INVPR_BASEDRAFTTYPE NUMBER(3,0),
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