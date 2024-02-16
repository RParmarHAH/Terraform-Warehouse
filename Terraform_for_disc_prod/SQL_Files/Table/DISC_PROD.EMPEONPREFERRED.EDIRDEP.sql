CREATE OR REPLACE TABLE DISC_PROD.EMPEONPREFERRED.EDIRDEP (
	CO VARCHAR(10) NOT NULL,
	ID VARCHAR(10),
	SEQUENCE NUMBER(10,0),
	TRANSIT VARCHAR(9),
	ACCOUNT VARCHAR(20),
	CHECKING BOOLEAN,
	AMOUNTCODE VARCHAR(10),
	AMOUNT NUMBER(14,2),
	EXCLUDESPECIAL BOOLEAN,
	PRENOTEDATE TIMESTAMP_NTZ(9),
	NAMEONACCOUNT VARCHAR(30),
	STARTDATE TIMESTAMP_NTZ(9),
	ENDDATE TIMESTAMP_NTZ(9),
	GUIDFIELD VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	DATEENDED TIMESTAMP_NTZ(9),
	RETURNCODE VARCHAR(10),
	RETURNDESCRIPTION VARCHAR(500),
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