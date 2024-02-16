CREATE OR REPLACE TABLE DISC_PROD.EMPLOYEESETUP.HIST_ES_ENTRIESDATA (
	ENTRYID VARCHAR(36) NOT NULL,
	SSN VARCHAR(15),
	LASTNAME VARCHAR(50),
	FIRSTNAME VARCHAR(50),
	MIDDLENAME VARCHAR(20),
	ADDRESS1 VARCHAR(100),
	ADDRESS2 VARCHAR(50),
	CITY VARCHAR(50),
	STATE VARCHAR(2),
	ZIP VARCHAR(20),
	PHONE VARCHAR(20),
	DOB TIMESTAMP_NTZ(9),
	SEX VARCHAR(1),
	RACE VARCHAR(1),
	REHIRE BOOLEAN,
	HIREDATE TIMESTAMP_NTZ(9),
	MARITALSTATUS VARCHAR(1),
	FEDERALEXEMPTIONS NUMBER(9,5),
	STATEEXEMPTIONS NUMBER(9,5),
	ADDITIONALFEDERALWITHHOLDINGS NUMBER(9,5),
	ADDITIONALSTATELWITHHOLDINGS NUMBER(9,5),
	POSITIONID VARCHAR(36),
	PAYSTATUS VARCHAR(1),
	EICELIG BOOLEAN,
	WHERETOCHECK VARCHAR(36),
	STATEFILLINGSTATUS VARCHAR(36),
	BACKGROUNDCHECK BOOLEAN,
	INUNION BOOLEAN,
	ORIGINALEMPLOYEEID VARCHAR(20),
	EMPLOYMENTTYPE VARCHAR(50),
	TRAVELCODE VARCHAR(10),
	SEQUENCEID NUMBER(10,0),
	EMPLOYEEID VARCHAR(15),
	NURSELICENSENUMBER VARCHAR(50),
	LICENSEEXPIREDATE TIMESTAMP_NTZ(9),
	PERFEREDCAREGIVER BOOLEAN,
	LOCALTAXCODE VARCHAR(50),
	CONTRACTTYPE VARCHAR(50),
	REPLACEMENT VARCHAR(50),
	TITLEID VARCHAR(36),
	REFERRAL VARCHAR(200),
	ORDERNEWPAYCARD BOOLEAN,
	MEDICAREID VARCHAR(50),
	PHONE2 VARCHAR(20),
	EMAILTO VARCHAR(150),
	PERSONALEMAIL VARCHAR(150),
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