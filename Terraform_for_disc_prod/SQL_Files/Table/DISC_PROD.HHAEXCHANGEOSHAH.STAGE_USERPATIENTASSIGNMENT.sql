CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.STAGE_USERPATIENTASSIGNMENT (
	AGENCYID NUMBER(10,0),
	USERPATIENTMAPPINGID NUMBER(10,0) NOT NULL,
	PATIENTID NUMBER(10,0),
	USERID NUMBER(10,0),
	USEROFFICEID NUMBER(10,0),
	PAYERID NUMBER(10,0),
	ACCESSFROMDATE TIMESTAMP_NTZ(9),
	ACCESSTODATE TIMESTAMP_NTZ(9),
	CONTINUOUSACCESS VARCHAR(3),
	ACCESSTOMAXDATE TIMESTAMP_NTZ(9),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
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