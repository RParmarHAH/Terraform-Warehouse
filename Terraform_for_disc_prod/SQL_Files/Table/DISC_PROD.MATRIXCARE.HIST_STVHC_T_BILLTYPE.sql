CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_BILLTYPE (
	BILTYP_ID NUMBER(10,0) NOT NULL,
	BILTYP_ACTIVE BOOLEAN,
	BILTYP_PRINTFORMAT VARCHAR(1),
	BILTYP_INVPROCESSID NUMBER(10,0),
	BILTYP_BILLINGSTATUSID NUMBER(10,0),
	BILTYP_NEWBILLINGSTATUSID NUMBER(10,0),
	BILTYP_REPORTNAME VARCHAR(50),
	BILTYP_ALLOWDETAILEXCLUDE BOOLEAN,
	BILTYP_CREATEDDATE TIMESTAMP_NTZ(9),
	BILTYP_CREATEDUSER VARCHAR(50),
	BILTYP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	BILTYP_MODIFIEDUSER VARCHAR(50),
	BILTYP_TS VARCHAR(100),
	BILTYP_NAME VARCHAR(50),
	BILTYP_DESCRIPTION VARCHAR(1000),
	BILTYP_DEFREVENUE BOOLEAN,
	BILTYP_ALLOWUICHANGE BOOLEAN,
	BILTYP_ALLOWEMAIL BOOLEAN,
	BILTYP_ALLOWMULTIPRINT BOOLEAN,
	BILTYP_REPORTID NUMBER(10,0),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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