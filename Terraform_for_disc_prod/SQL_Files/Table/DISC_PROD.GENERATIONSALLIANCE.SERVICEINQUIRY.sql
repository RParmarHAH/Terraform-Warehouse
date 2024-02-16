CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.SERVICEINQUIRY (
	INQNO NUMBER(10,0) NOT NULL,
	FIRSTNAME VARCHAR(25),
	LASTNAME VARCHAR(25),
	ADDRESS1 VARCHAR(80),
	ADDRESS2 VARCHAR(80),
	CITY VARCHAR(30),
	STATE VARCHAR(2),
	ZIP VARCHAR(10),
	EMAIL VARCHAR(50),
	PHONE VARCHAR(50),
	ALTERNATEPHONE VARCHAR(50),
	HEARDTHROUGH VARCHAR(200),
	RELATIONSHIP VARCHAR(20),
	RECEPIENTCITY VARCHAR(30),
	RECEPIENTSTATE VARCHAR(2),
	RECEPIENTZIP VARCHAR(9),
	RECEPIENTLOCATION VARCHAR(50),
	ASSISTANCENEEDED VARCHAR(500),
	RECEPTIVENESS VARCHAR(30),
	HELPWITHIN VARCHAR(30),
	SUBMITTEDDATE TIMESTAMP_NTZ(9),
	IMPORTED BOOLEAN,
	HIDDEN BOOLEAN,
	BESTTTC VARCHAR(200),
	RECEIPIENTFIRSTNAME VARCHAR(25),
	RECEIPIENTLASTNAME VARCHAR(25),
	LOCATION VARCHAR(50),
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