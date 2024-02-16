CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.CUSTOMFIELDS (
	CUSTOMFIELDID NUMBER(10,0) NOT NULL,
	CUSTOMFIELDTYPE NUMBER(3,0),
	CUSTOMFIELDTYPETEXT VARCHAR(9),
	AGENCYID NUMBER(10,0) NOT NULL,
	COMPANYTYPE NUMBER(3,0),
	COMPANYTYPETEXT VARCHAR(7),
	CONTROLTYPE NUMBER(3,0),
	CONTROLTYPETEXT VARCHAR(8),
	CONTROLSEQ NUMBER(3,0),
	CONTROLVALUE VARCHAR(16777216),
	CONTROLCAPTION VARCHAR(50),
	CONTROLSTATUS BOOLEAN,
	CONTROLSTATUSTEXT VARCHAR(7),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	ISDATECONTROL BOOLEAN,
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