CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.TBLCOORDINATOR_REPL (
	AGENCYID NUMBER(10,0),
	COORDINATORID NUMBER(10,0) NOT NULL,
	COORDINATORNAME VARCHAR(50),
	COORDINATORNUMBER VARCHAR(6),
	ISDEFAULT BOOLEAN,
	ISACTIVE BOOLEAN,
	DELETED BOOLEAN,
	PAYERID NUMBER(10,0),
	USERID NUMBER(10,0),
	EMAIL VARCHAR(500),
	OFFICENAMES VARCHAR(16777216),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBY NUMBER(10,0),
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