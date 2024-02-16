CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION (
	AGENCYID NUMBER(10,0),
	PATIENTID NUMBER(19,0),
	AUTHORIZATIONID NUMBER(10,0),
	CONTRACTID NUMBER(10,0),
	AUTHORIZATIONNUMBER VARCHAR(50),
	FROMDATE TIMESTAMP_NTZ(9),
	TODATE TIMESTAMP_NTZ(9),
	DISCIPLINE VARCHAR(50),
	SERVICECODEID NUMBER(10,0),
	TYPE VARCHAR(6),
	MAXUNITSFORAUTH VARCHAR(20),
	PERIOD VARCHAR(13),
	BANKEDHOURS VARCHAR(1),
	SATHOURS NUMBER(6,2),
	SUNHOURS NUMBER(6,2),
	MONHOURS NUMBER(6,2),
	TUEHOURS NUMBER(6,2),
	WEDHOURS NUMBER(6,2),
	THUHOURS NUMBER(6,2),
	FRIHOURS NUMBER(6,2),
	MAXUNITSFORPERIOD NUMBER(11,2),
	NOTES VARCHAR(4000),
	REMAININGUNITS NUMBER(38,2),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	ISDELETED VARCHAR(1),
	AUTHATTACHMENT VARCHAR(5),
	SERVICETYPEID NUMBER(10,0),
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