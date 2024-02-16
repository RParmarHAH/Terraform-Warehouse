CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.TBL_LOCATION (
	STR_LOCATIONID VARCHAR(3) NOT NULL,
	STR_CREATEDBY VARCHAR(25),
	DTM_CREATED TIMESTAMP_NTZ(9),
	STR_UPDATEDBY VARCHAR(25),
	DTM_LASTUPDATED TIMESTAMP_NTZ(9),
	BIT_OVERRIDEOFFSET BOOLEAN,
	DEC_OFFSET NUMBER(5,2),
	TIMEZONEID NUMBER(10,0),
	DESCRIPTION VARCHAR(30),
	PROVIDERID VARCHAR(30),
	OVERRIDECOMPANYINFO BOOLEAN,
	LOCATIONCOMPANYNAME VARCHAR(50),
	LOCATIONTAXID VARCHAR(10),
	LOCATIONADDRESS VARCHAR(50),
	LOCATIONCITY VARCHAR(30),
	LOCATIONSTATE VARCHAR(2),
	LOCATIONZIP VARCHAR(9),
	LOCATIONPHONE VARCHAR(10),
	LOCATIONPAYROLLID VARCHAR(31),
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