CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.HIST_STVHC_T_ADDRESSBOOK (
	ADDBK_ID NUMBER(19,0) NOT NULL,
	ADDBK_BRANCHID NUMBER(10,0),
	ADDBK_FIRSTNAME VARCHAR(50),
	ADDBK_LASTNAME VARCHAR(50),
	ADDBK_COMPANYNAME VARCHAR(60),
	ADDBK_TITLE VARCHAR(60),
	ADDBK_CONTACTNAME VARCHAR(50),
	ADDBK_POSITION VARCHAR(50),
	ADDBK_BIRTHDATE TIMESTAMP_NTZ(9),
	ADDBK_TYPEID NUMBER(10,0),
	ADDBK_NOTES VARCHAR(16777216),
	ADDBK_ADDRESS1 VARCHAR(255),
	ADDBK_ADDRESS2 VARCHAR(60),
	ADDBK_CITY VARCHAR(50),
	ADDBK_STATEORPROVINCE VARCHAR(20),
	ADDBK_POSTALCODE VARCHAR(20),
	ADDBK_COUNTY VARCHAR(50),
	ADDBK_COUNTRY NUMBER(10,0),
	ADDBK_EMAIL VARCHAR(50),
	ADDBK_EMAIL2 VARCHAR(50),
	ADDBK_CREATEDUSER VARCHAR(50),
	ADDBK_CREATEDDATE TIMESTAMP_NTZ(9),
	ADDBK_MODIFIEDDATE TIMESTAMP_NTZ(9),
	ADDBK_MODIFIEDUSER VARCHAR(50),
	ADDBK_TS VARCHAR(255),
	ADDBK_ALLOWMASSEMAIL BOOLEAN,
	ADDBK_LEGACYID NUMBER(10,0),
	ADDBK_LEGACYBRANCHID NUMBER(10,0),
	ADDBK_SALUTATIONID NUMBER(10,0),
	ADDBK_CONTACTTYPEBITWISE NUMBER(3,0),
	ADDBK_HOBBIES VARCHAR(256),
	ADDBK_TEXTMESSAGE VARCHAR(50),
	ADDBK_REGIONID NUMBER(10,0),
	ADDBK_WEBSITE VARCHAR(192),
	TEMP_ID NUMBER(19,0),
	TEMP_TABLE VARCHAR(50),
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