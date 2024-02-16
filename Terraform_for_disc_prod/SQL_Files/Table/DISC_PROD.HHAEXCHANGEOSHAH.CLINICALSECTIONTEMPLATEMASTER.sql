CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.CLINICALSECTIONTEMPLATEMASTER (
	AGENCYID NUMBER(10,0) NOT NULL,
	SECTIONTEMPLATEMASTERID NUMBER(10,0) NOT NULL,
	PAGETEMPLATEMASTERID NUMBER(10,0),
	SECTIONKEY VARCHAR(50),
	SECTIONNAME VARCHAR(150),
	STATUS BOOLEAN,
	DISPLAYORDER NUMBER(10,0),
	ISASYMPTOMATICOPTION BOOLEAN,
	CONTROLNAME VARCHAR(100),
	FIELDNAME VARCHAR(100),
	HTMLFILENAME VARCHAR(500),
	MASTER485CONTROLNAME VARCHAR(100),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDBY NUMBER(10,0),
	LASTUPDATEDATE TIMESTAMP_NTZ(9),
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