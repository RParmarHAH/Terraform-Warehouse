CREATE OR REPLACE TABLE DISC_PROD.PUBLIC.DFINVOICEDETAILS_FULLLOAD_20230901 (
	DBNAME VARCHAR(12),
	REFERENCENO NUMBER(10,0),
	INVOICENO NUMBER(10,0),
	DATEFROM DATE,
	DATETO DATE,
	HOURS NUMBER(18,5),
	AMOUNT NUMBER(18,5),
	AMOUNTPAID NUMBER(18,5),
	BILLCODE VARCHAR(10),
	CLIENTNUMBER NUMBER(10,0),
	EMPLOYEENO1 NUMBER(10,0),
	EMPLOYEENO2 NUMBER(10,0),
	EMPLOYEENO3 NUMBER(10,0),
	CONTRACTCODE VARCHAR(5),
	PREAUTHNUMBER VARCHAR(50),
	STARTTIME TIMESTAMP_NTZ(9),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEBATCH VARCHAR(36),
	UPDATEDTIME TIMESTAMP_NTZ(9),
	DATASOURCE VARCHAR(12),
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