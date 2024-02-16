CREATE OR REPLACE TABLE DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTCONTRACTS (
	DBNAME VARCHAR(10),
	CLIENTNUMBER NUMBER(10,0),
	CONTRACTCODE VARCHAR(10),
	BEGINSERVICEDATE DATE,
	ENDSERVICEDATE DATE,
	AUTHSTATUS VARCHAR(20),
	AUTHTYPE VARCHAR(20),
	IDNUMBER VARCHAR(50),
	WEEKLYMAXHOURS NUMBER(18,5),
	MONTHLYMAXHOURS NUMBER(18,5),
	PAYORSOURCE VARCHAR(5),
	BILLCODESVALUES VARCHAR(16777216),
	AUTHORIZATIONVALUES VARCHAR(16777216),
	PAYRATE NUMBER(18,5),
	SERVICEAREA VARCHAR(12),
	OLDAUTHORIZEDHOURS NUMBER(18,5),
	CASENUMBER VARCHAR(20),
	CASEWORKERMANAGER VARCHAR(50),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEBATCH VARCHAR(36),
	UPDATEDTIME TIMESTAMP_NTZ(9),
	DATEADDED DATE,
	DATECHANGED DATE,
	SYS_CHANGE_VERSION NUMBER(18,0),
	SYS_CHANGE_OPERATION VARCHAR(1),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(100),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(100),
	ETL_DELETED_FLAG BOOLEAN
);