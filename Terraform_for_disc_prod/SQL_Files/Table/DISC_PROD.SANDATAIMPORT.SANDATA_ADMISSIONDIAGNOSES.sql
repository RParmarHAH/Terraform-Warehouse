CREATE OR REPLACE TABLE DISC_PROD.SANDATAIMPORT.SANDATA_ADMISSIONDIAGNOSES (
	ID NUMBER(10,0),
	AGENCYID VARCHAR(25),
	DIAGID NUMBER(10,0),
	ADMISSIONID NUMBER(10,0),
	PERIODID NUMBER(10,0),
	ICD9CODE VARCHAR(10),
	DESCRIPTION VARCHAR(25),
	RANK VARCHAR(2),
	SEVERITY NUMBER(10,0),
	ONSET DATE,
	ISEXACERBATION BOOLEAN,
	ICD10CODE VARCHAR(10),
	CREATEDAT TIMESTAMP_NTZ(9),
	UPDATEDAT TIMESTAMP_NTZ(9),
	HASHEDROWVALUES VARCHAR(250),
	BATCHID NUMBER(10,0),
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