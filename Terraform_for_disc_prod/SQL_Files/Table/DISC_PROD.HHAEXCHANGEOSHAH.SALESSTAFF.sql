CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.SALESSTAFF (
	AGENCYID NUMBER(10,0),
	SALESSTAFFID NUMBER(10,0) NOT NULL,
	FIRSTNAME VARCHAR(500),
	LASTNAME VARCHAR(500),
	SALESSTAFF VARCHAR(500),
	SALESSTAFFMANAGER VARCHAR(500),
	STATUS VARCHAR(500),
	OFFICES VARCHAR(4000),
	ATTRIBUTES VARCHAR(4000),
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