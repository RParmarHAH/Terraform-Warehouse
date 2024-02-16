CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PATIENTINTERIMORDERS (
	AGENCYID NUMBER(10,0) NOT NULL,
	PATIENTID NUMBER(10,0),
	HEADERID NUMBER(10,0),
	DOCID VARCHAR(24),
	DETAILID NUMBER(10,0) NOT NULL,
	CREATIONDATE TIMESTAMP_NTZ(9),
	CERTIFICATIONSTARTDATE TIMESTAMP_NTZ(9),
	CERTIFICATIONENDDATE TIMESTAMP_NTZ(9),
	STATUS NUMBER(3,0),
	STATUSTEXT VARCHAR(11),
	CANDELETE NUMBER(10,0),
	CATEGORYID NUMBER(10,0),
	CATEGORY VARCHAR(50),
	ISAUTO VARCHAR(50),
	SCANFILENAME VARCHAR(1024),
	SCANFILEGUID VARCHAR(36),
	DATAVERSION NUMBER(3,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	FAXLOGSTATUS NUMBER(10,0),
	FAXLOGSTATUSTEXT VARCHAR(500),
	PHYSICIANFAX VARCHAR(50),
	PHYSICIANNAME VARCHAR(100),
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