CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PHYSICIAN (
	PHYS_ID NUMBER(19,0) NOT NULL,
	PHYS_FIRSTNAME VARCHAR(50),
	PHYS_LASTNAME VARCHAR(50),
	PHYS_ACTIVE BOOLEAN,
	PHYS_BRANCHID NUMBER(10,0),
	PHYS_COMPANYNAME VARCHAR(50),
	PHYS_MIDDLEINITIAL VARCHAR(2),
	PHYS_TITLE VARCHAR(20),
	PHYS_SEX VARCHAR(1),
	PHYS_SUFFIX VARCHAR(50),
	PHYS_CONTACTNAME VARCHAR(35),
	PHYS_BIRTHDAY TIMESTAMP_NTZ(9),
	PHYS_ADDRESS1 VARCHAR(255),
	PHYS_ADDRESS2 VARCHAR(60),
	PHYS_CITY VARCHAR(50),
	PHYS_STATEORPROVINCE VARCHAR(20),
	PHYS_POSTALCODE VARCHAR(20),
	PHYS_COUNTY VARCHAR(50),
	PHYS_COUNTRY NUMBER(10,0),
	PHYS_PHONE VARCHAR(30),
	PHYS_PHONETYPE NUMBER(10,0),
	PHYS_SPECIALTY VARCHAR(50),
	PHYS_LICENSENUM VARCHAR(50),
	PHYS_UPIN VARCHAR(15),
	PHYS_DEANUMBER VARCHAR(50),
	PHYS_DEADATE TIMESTAMP_NTZ(9),
	PHYS_EXPIREDT TIMESTAMP_NTZ(9),
	PHYS_DATACURRENT TIMESTAMP_NTZ(9),
	PHYS_CONTACTDATE TIMESTAMP_NTZ(9),
	PHYS_DEGREE VARCHAR(50),
	PHYS_LICENSESTATUS VARCHAR(50),
	PHYS_ACTIVITYSTATUS VARCHAR(50),
	PHYS_TAXID VARCHAR(50),
	PHYS_TAXTYPE VARCHAR(30),
	PHYS_NPI VARCHAR(10),
	PHYS_EDIADDITIONALID VARCHAR(20),
	PHYS_EDIADDITIONALIDTYPE VARCHAR(3),
	PHYS_EMAIL VARCHAR(128),
	PHYS_INFOREQUESTED VARCHAR(500),
	PHYS_NOTES VARCHAR(500),
	PHYS_REGIONID NUMBER(10,0),
	PHYS_CREATEDDATE TIMESTAMP_NTZ(9),
	PHYS_CREATEDUSER VARCHAR(50),
	PHYS_MODIFIEDDATE TIMESTAMP_NTZ(9),
	PHYS_MODIFIEDUSER VARCHAR(50),
	PHYS_TS VARCHAR(255),
	PHYS_STATUSID NUMBER(10,0),
	PHYS_OASISINTERFACEID VARCHAR(50),
	PHYS_ALLOWMASSEMAIL BOOLEAN,
	PHYS_DEAR NUMBER(10,0),
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