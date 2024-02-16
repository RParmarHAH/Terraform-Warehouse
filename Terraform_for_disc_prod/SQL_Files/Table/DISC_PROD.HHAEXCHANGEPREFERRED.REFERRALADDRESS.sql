CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.REFERRALADDRESS (
	AGENCYID NUMBER(10,0),
	REFERRALADDRESSID NUMBER(10,0),
	REFERRALID NUMBER(10,0),
	ADDRESSLINE1 VARCHAR(100),
	ADDRESSLINE2 VARCHAR(100),
	CITY VARCHAR(255),
	STATE VARCHAR(100),
	COUNTY VARCHAR(100),
	ZIP VARCHAR(10),
	CROSSSTREET VARCHAR(100),
	PRIMARYADDRESS VARCHAR(3),
	ADDRESSTYPES VARCHAR(16777216),
	NOTE VARCHAR(16777216),
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