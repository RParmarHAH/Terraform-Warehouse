CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.CLINICALVISITINFO (
	AGENCYID NUMBER(10,0) NOT NULL,
	CLINICALVISITINFOID NUMBER(10,0) NOT NULL,
	PATIENTID NUMBER(10,0),
	VISITID NUMBER(10,0),
	VISITTYPE NUMBER(10,0),
	AIDEID NUMBER(10,0),
	AIDENAME VARCHAR(50),
	SUPERVISORYVISIT VARCHAR(16777216),
	SKILLEDNURSING VARCHAR(16777216),
	CARDIVASCULAR VARCHAR(16777216),
	RESPIRATORY VARCHAR(16777216),
	VIRALSIGN VARCHAR(16777216),
	VIRALSIGNSUMMARY VARCHAR(16777216),
	NEUROLOGICAL VARCHAR(16777216),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTUPDATEDBY NUMBER(10,0),
	LASTUPDATEDATE TIMESTAMP_NTZ(9),
	CLINICALDOCID NUMBER(10,0),
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