CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.PATIENTLINKEDCONTRACTCHANGES (
	AGENCYID NUMBER(10,0),
	CONTRACTCHANGEID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	PLACEMENTID NUMBER(10,0),
	PAYERID NUMBER(10,0),
	ISPRIMARYCONTRACT VARCHAR(50),
	ALTPATIENTID VARCHAR(50),
	STARTDATE TIMESTAMP_NTZ(9),
	SOURCEOFADMISSIONID NUMBER(10,0),
	SERVICECODEID NUMBER(10,0),
	DISCHARGEDATE TIMESTAMP_NTZ(9),
	DISCHARGETO NUMBER(10,0),
	ACTIONDATEUTC TIMESTAMP_NTZ(9),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
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