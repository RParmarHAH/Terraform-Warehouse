CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PATIENTPHYSICIANS (
	AGENCYID NUMBER(10,0),
	PATIENTPHYSICIANID NUMBER(19,0) NOT NULL,
	PATIENTID NUMBER(10,0),
	PHYSICIANID NUMBER(10,0),
	MDNAME VARCHAR(100),
	MDPHONE VARCHAR(100),
	MDADDRESS VARCHAR(500),
	ISPRIMARY VARCHAR(5),
	NOTE VARCHAR(500),
	PHYSICIANNPI VARCHAR(50),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	ADDRESS1 VARCHAR(100),
	ADDRESS2 VARCHAR(100),
	CITY VARCHAR(50),
	STATE VARCHAR(50),
	ZIP VARCHAR(10),
	MDFAX VARCHAR(30),
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