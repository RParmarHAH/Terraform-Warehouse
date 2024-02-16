CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.UNTOUCHEDVISITS (
	AGENCYID NUMBER(10,0) NOT NULL,
	ADMISSIONID VARCHAR(16777216),
	OFFICEPATIENTCODE VARCHAR(16777216),
	PATIENTNAME VARCHAR(16777216),
	MEDICAIDNUMBER VARCHAR(16777216),
	ALTPATIENTID VARCHAR(16777216),
	VISITDATE VARCHAR(16777216),
	SCHEDULETIME VARCHAR(8000),
	AIDENAME VARCHAR(16777216),
	AIDECODE VARCHAR(16777216),
	DISCIPLINE VARCHAR(100),
	VISITSTATUS NUMBER(10,0),
	VISITSTATUSTEXT VARCHAR(50),
	BILLED VARCHAR(50),
	SERVICECODE VARCHAR(16777216),
	CHHANAME VARCHAR(16777216),
	VISITTIME VARCHAR(8000),
	PAYRATE NUMBER(18,2),
	SCHEDULEDMINS NUMBER(10,0),
	VISITMINS NUMBER(10,0),
	VISITHRS VARCHAR(16777216),
	COORDINATORNAME VARCHAR(16777216),
	TIMESHEETREQUIRE VARCHAR(50),
	PAYRATECODE VARCHAR(16777216),
	CREATEDDATE TIMESTAMP_NTZ(9),
	VENDORINVOICENUMBER VARCHAR(16777216),
	VISITCREATEDDATE TIMESTAMP_NTZ(9),
	VISITMODIFIEDDATE TIMESTAMP_NTZ(9),
	VISITID NUMBER(19,0) NOT NULL,
	ONHOLDVISIT VARCHAR(50),
	MISSEDVISIT VARCHAR(50),
	COUNTYNAME VARCHAR(16777216),
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