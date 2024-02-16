CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.PAYROLL_HEADER_REPL (
	AGENCYID NUMBER(10,0),
	HEADERID NUMBER(10,0),
	BATCHID NUMBER(10,0),
	CAREGIVERID NUMBER(10,0),
	WEEKSTART TIMESTAMP_NTZ(9),
	WEEKEND TIMESTAMP_NTZ(9),
	TOTALHOURS NUMBER(10,0),
	TOTALOTHOURS NUMBER(10,0),
	TOTALAMOUNT NUMBER(18,2),
	TOTALOTAMOUNT NUMBER(18,2),
	TOTALHOLIDAYHOURS NUMBER(10,0),
	TOTALHOLIDAYAMOUNT NUMBER(18,2),
	PAYROLLSETUPID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	EXPENSEAMOUNT NUMBER(18,2),
	MILEAGEAMOUNT NUMBER(18,2),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBY NUMBER(10,0),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
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