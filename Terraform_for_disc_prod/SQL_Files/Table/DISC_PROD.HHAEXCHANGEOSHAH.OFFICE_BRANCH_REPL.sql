CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.OFFICE_BRANCH_REPL (
	AGENCYID NUMBER(10,0),
	BRANCHID NUMBER(10,0) NOT NULL,
	BRANCHNAME VARCHAR(100),
	DESCRIPTION VARCHAR(200),
	ACTIVE BOOLEAN,
	OFFICEID NUMBER(10,0),
	AGENCYBRANCHID NUMBER(10,0),
	MDORDERBRANCHADDRESS VARCHAR(10),
	STREET1 VARCHAR(100),
	STREET2 VARCHAR(100),
	CITY VARCHAR(50),
	STATE VARCHAR(50),
	ZIPCODE VARCHAR(50),
	PHONE VARCHAR(30),
	FAX VARCHAR(50),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDUTCDATE TIMESTAMP_NTZ(9),
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