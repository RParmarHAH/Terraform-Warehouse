CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.EDIHISTORY (
	EDIHISTORYID NUMBER(10,0) NOT NULL,
	CONTROLNUMBER NUMBER(10,0),
	PAYOR VARCHAR(100),
	LOCATION VARCHAR(3),
	DATEFROM TIMESTAMP_NTZ(9),
	DATETHROUGH TIMESTAMP_NTZ(9),
	CLAIM VARCHAR(16777216),
	CREATEDDTM TIMESTAMP_NTZ(9),
	CREATEDBY VARCHAR(100),
	PARAMETERS VARIANT,
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