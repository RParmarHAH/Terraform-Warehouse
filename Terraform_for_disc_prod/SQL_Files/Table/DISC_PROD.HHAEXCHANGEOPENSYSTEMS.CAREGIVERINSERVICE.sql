CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CAREGIVERINSERVICE (
	AGENCYID NUMBER(10,0) NOT NULL,
	CAREGIVERINSERVICEID NUMBER(19,0) NOT NULL,
	INSERVICEID NUMBER(19,0),
	CAREGIVERID NUMBER(10,0),
	INSERVICEDATE TIMESTAMP_NTZ(9),
	FROMTIME VARCHAR(4),
	ENDTIME VARCHAR(4),
	FROMENDTIME VARCHAR(9),
	TOPIC VARCHAR(16777216),
	LOCATION VARCHAR(8000),
	INSTRUCTOR VARCHAR(100),
	DESCRIPTION VARCHAR(8000),
	TYPE VARCHAR(1),
	HOURS VARCHAR(10),
	PAYROLLBILLED VARCHAR(3),
	NOSHOW NUMBER(5,0),
	NOSHOWTEXT VARCHAR(50),
	ISSTATUS NUMBER(5,0),
	ISSTATUSTEXT VARCHAR(50),
	REASON VARCHAR(50),
	BATCHNUMBER VARCHAR(50),
	CREATEDBYUSER VARCHAR(200),
	CREATEDBYUSERID NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	PAYRATEID NUMBER(10,0),
	PAYRATECODE VARCHAR(50),
	PAYRATEID2 NUMBER(10,0),
	PAYRATECODE2 VARCHAR(50),
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