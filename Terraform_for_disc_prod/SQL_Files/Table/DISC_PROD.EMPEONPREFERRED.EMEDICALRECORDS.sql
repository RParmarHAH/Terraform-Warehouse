CREATE OR REPLACE TABLE DISC_PROD.EMPEONPREFERRED.EMEDICALRECORDS (
	MEDICALRECORDID VARCHAR(36) NOT NULL,
	CO VARCHAR(10),
	ID VARCHAR(10),
	DATECOMPLETED DATE,
	EXPIRATIONDATE DATE,
	NOTES VARCHAR(4000),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	CLASSCODE VARCHAR(10),
	TYPE VARCHAR(10),
	ISACTIVE BOOLEAN,
	PROVIDER VARCHAR(50),
	DECLINED BOOLEAN,
	RESULT VARCHAR(20),
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