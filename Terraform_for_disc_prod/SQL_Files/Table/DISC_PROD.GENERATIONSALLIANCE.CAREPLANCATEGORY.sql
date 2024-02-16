CREATE OR REPLACE TABLE DISC_PROD.GENERATIONSALLIANCE.CAREPLANCATEGORY (
	CATEGORYID NUMBER(10,0) NOT NULL,
	CATEGORYNAME VARCHAR(250),
	SORTORDER NUMBER(5,0),
	ACTIVE BOOLEAN,
	SELECTIONTYPE NUMBER(5,0),
	NUMBEROFQUESTIONS NUMBER(5,0),
	NUMBEROFTEXTAREAS NUMBER(5,0),
	CREATEDBY VARCHAR(100),
	CREATED TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(100),
	LASTUPDATED TIMESTAMP_NTZ(9),
	CAREPLANTEMPLATEID NUMBER(10,0),
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