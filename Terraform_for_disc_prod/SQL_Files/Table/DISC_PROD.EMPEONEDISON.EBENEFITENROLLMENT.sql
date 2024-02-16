CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.EBENEFITENROLLMENT (
	BENEFITENROLLMENTID VARCHAR(36) NOT NULL,
	BENEFITPLANID VARCHAR(36),
	CO VARCHAR(10),
	ID VARCHAR(10),
	STARTDATE DATE,
	EVENTDETAIL VARCHAR(256),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	EVENT VARCHAR(100),
	COVERAGELEVELOVERRIDE VARCHAR(25),
	ARREAR NUMBER(18,2),
	DEPENDENTID VARCHAR(10),
	ENDDATE DATE,
	TERMINATIONEVENT VARCHAR(100),
	TERMINATIONEVENTDETAIL VARCHAR(256),
	LASTDATE DATE,
	ARREARCAP NUMBER(18,2),
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