CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.SERVICEREQUEST (
	CLIENTID NUMBER(10,0) NOT NULL,
	SERVICEREQUESTID NUMBER(10,0) NOT NULL,
	SERVICECODE NUMBER(10,0),
	STARTDATE TIMESTAMP_NTZ(9),
	ENDDATE TIMESTAMP_NTZ(9),
	STARTTIME TIMESTAMP_NTZ(9),
	ENDTIME TIMESTAMP_NTZ(9),
	COSTPERUNIT NUMBER(18,2),
	FREQUENCY NUMBER(5,0),
	OCCURANCE NUMBER(5,0),
	SUNDAY BOOLEAN,
	MONDAY BOOLEAN,
	TUESDAY BOOLEAN,
	WEDNESDAY BOOLEAN,
	THURSDAY BOOLEAN,
	FRIDAY BOOLEAN,
	SATURDAY BOOLEAN,
	NOTES VARCHAR(255),
	DAYOFMONTH VARCHAR(50),
	FLEXIBLETIME BOOLEAN,
	TOTALHOURS NUMBER(18,2),
	DEFAULT BOOLEAN,
	TOTALAPPROVEDUNITS NUMBER(16,2),
	TOTALAPPROVEDAMT NUMBER(16,3),
	UNITSPERHOUR NUMBER(3,0),
	CREATEDBY VARCHAR(15),
	CREATED TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(15),
	LASTUPDATED TIMESTAMP_NTZ(9),
	AUTHNUMBER VARCHAR(50),
	PAYORID NUMBER(10,0),
	FLEXIBLEDAY BOOLEAN,
	TOTALAPPROVEDVISITS NUMBER(10,0),
	MANUALOVERRIDEBY VARCHAR(15),
	SERVICESTATUS VARCHAR(1),
	PATIENTNUMBER VARCHAR(24),
	MANUALOVERRIDEDATE TIMESTAMP_NTZ(9),
	DAYOFWEEK VARCHAR(15),
	INCLUDEMODIFIERIN837I BOOLEAN,
	ARPROVIDERID VARCHAR(10),
	CAREBRIDGEPROVIDERID VARCHAR(20),
	SANTRAXPROVIDERID VARCHAR(10),
	PROVIDERATYPICALID VARCHAR(8),
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