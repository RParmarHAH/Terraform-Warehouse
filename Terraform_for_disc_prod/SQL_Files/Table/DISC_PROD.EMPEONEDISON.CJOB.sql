CREATE OR REPLACE TABLE DISC_PROD.EMPEONEDISON.CJOB (
	CO VARCHAR(10) NOT NULL,
	JOBCODE VARCHAR(20),
	DESCRIPTION VARCHAR(200),
	ADDRESS1 VARCHAR(50),
	ADDRESS2 VARCHAR(50),
	CITY VARCHAR(30),
	STATE VARCHAR(20),
	ZIP VARCHAR(10),
	COUNTY VARCHAR(30),
	COUNTRY VARCHAR(30),
	OVERRIDESHIFT VARCHAR(10),
	OVERRIDERATECODE VARCHAR(10),
	OVERRIDERATE NUMBER(14,6),
	ADDTORATE NUMBER(14,6),
	CERTIFIEDJOB BOOLEAN,
	RATEMULTIPLIER NUMBER(14,6),
	STARTDATE TIMESTAMP_NTZ(9),
	ENDDATE TIMESTAMP_NTZ(9),
	GUIDFIELD VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	ADDLTAXDATA1 VARCHAR(50),
	CMSLABORJOBCODE VARCHAR(20),
	OBSOLETE BOOLEAN,
	CSTARTDATE TIMESTAMP_NTZ(9),
	FEDEIN VARCHAR(10),
	FINALFILINGQ NUMBER(10,0),
	FINALFILINGY VARCHAR(4),
	LOCALTAXCODE VARCHAR(20),
	LOCALTAXID VARCHAR(10),
	SITWFREQ VARCHAR(10),
	STATEEIN VARCHAR(10),
	STATUS VARCHAR(10),
	SUIRATE NUMBER(4,3),
	SUITAXID VARCHAR(15),
	LOCATION VARCHAR(10),
	SUBJECTWP BOOLEAN,
	PBJCODE NUMBER(10,0),
	HPPDTYPE VARCHAR(10),
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