CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE (
	LINEID NUMBER(10,0),
	DB VARCHAR(5),
	AUDITTRAILNUMBER VARCHAR(13),
	EMPLOYEEID VARCHAR(15),
	CHECKNUMBER VARCHAR(21),
	CHECKDATE TIMESTAMP_NTZ(9),
	DEPARTMENT VARCHAR(7),
	PAYCODETYPE NUMBER(5,0),
	PAYCODE VARCHAR(7),
	JOBTITLECODE VARCHAR(7),
	PAYPERIODBEGINDATE TIMESTAMP_NTZ(9),
	PAYPERIODENDDATE TIMESTAMP_NTZ(9),
	UNITS NUMBER(19,5),
	RATE NUMBER(19,5),
	AMOUNT NUMBER(19,5),
	STATECODE VARCHAR(3),
	SUTASTATE VARCHAR(3),
	EMPLOYEECLASS VARCHAR(15),
	GPROWID NUMBER(10,0),
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