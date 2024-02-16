CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.PATIENTMDORDER (
	AGENCYID NUMBER(10,0),
	MDORDERID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	MDORDER_NUMBER VARCHAR(20),
	CERTSTARTDATE TIMESTAMP_NTZ(9),
	CERTENDDATE TIMESTAMP_NTZ(9),
	STATUS VARCHAR(20),
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