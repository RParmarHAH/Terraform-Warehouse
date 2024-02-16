CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_SCHEDULESTATUS (
	SCHST_ID NUMBER(10,0) NOT NULL,
	SCHST_NAME VARCHAR(50),
	SCHST_BACKCOLOR NUMBER(10,0),
	SCHST_FORECOLOR NUMBER(10,0),
	SCHST_CONFLICTCHECK BOOLEAN,
	SCHST_OTCHECK BOOLEAN,
	SCHST_ACTIVE BOOLEAN,
	SCHST_RECSAMESTARTENDACTION NUMBER(3,0),
	SCHST_RECONLYSAMESTARTACTION NUMBER(3,0),
	SCHST_RECSAMEDATEDIFSTARTACTION NUMBER(3,0),
	SCHST_RECNOMATCHACTION NUMBER(3,0),
	SCHST_RECROOTSCHEDCHANGEACTION NUMBER(3,0),
	SCHST_MODIFIEDDATE TIMESTAMP_NTZ(9),
	SCHST_MODIFIEDUSER VARCHAR(50),
	SCHST_CREATEDDATE TIMESTAMP_NTZ(9),
	SCHST_CREATEDUSER VARCHAR(50),
	SCHST_TS VARCHAR(100),
	SCHST_LISTITEMTYPE NUMBER(3,0),
	SCHST_RPTGROUPID NUMBER(10,0),
	SCHST_BRANCHID NUMBER(10,0),
	SCHST_OVERRIDEID NUMBER(10,0),
	SCHST_DESCRIPTION VARCHAR(1000),
	SCHST_ISACAREGIVERLASTVISIT BOOLEAN,
	SCHST_UPLOADTELEPHONY BOOLEAN,
	SCHST_AVAILCHECK BOOLEAN,
	SCHST_DNUCHECK BOOLEAN,
	SCHST_EXPIRCHECK BOOLEAN,
	SCHST_AUTHCHECK BOOLEAN,
	SCHST_CALCRATES BOOLEAN,
	SCHST_DISPLAYONCLIENTPORTAL BOOLEAN,
	SCHST_DISPLAYONCAREGIVERPORTAL BOOLEAN,
	SCHST_INCLUDEINTHERAPYCOUNT BOOLEAN,
	SCHST_SKILLGROUPCHECK BOOLEAN,
	SCHST_AUTOCALCTRAVEL BOOLEAN,
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