CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_REPORTGROUPS (
	RPTGRP_ID NUMBER(10,0),
	RPTGRP_NAME VARCHAR(50),
	RPTGRP_TYPEID NUMBER(10,0),
	RPTGRP_ACTIVE BOOLEAN,
	RPTGRP_CREATEDDATE TIMESTAMP_NTZ(9),
	RPTGRP_CREATEDUSER VARCHAR(50),
	RPTGRP_MODIFIEDDATE TIMESTAMP_NTZ(9),
	RPTGRP_MODIFIEDUSER VARCHAR(50),
	RPTGRP_TS VARCHAR(100),
	RPTGRP_DESCRIPTION VARCHAR(1000),
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