CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CDDOCTYPES (
	AGENCYID NUMBER(10,0),
	DOCTYPEID NUMBER(10,0) NOT NULL,
	DOCTYPE VARCHAR(200),
	DESCRIPTION VARCHAR(5000),
	STATUS BOOLEAN,
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	CURRENTVERSIONID NUMBER(10,0),
	INCLUDEMDORDER BOOLEAN,
	FORMTYPEID NUMBER(10,0),
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