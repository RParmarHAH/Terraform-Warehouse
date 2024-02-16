CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.LINKEDCONTRACTRATES (
	AGENCYID NUMBER(5,0),
	VENDORRATEID NUMBER(19,0),
	OFFICEID NUMBER(10,0),
	PAYERID NUMBER(10,0),
	FROMDATE TIMESTAMP_NTZ(9),
	TODATE TIMESTAMP_NTZ(9),
	STATUS VARCHAR(8),
	SERVICECATEGORY VARCHAR(1),
	SERVICECODE VARCHAR(50),
	SERVICETYPE VARCHAR(50),
	RATEAMOUNT NUMBER(18,6),
	RATETYPE VARCHAR(10),
	ALLOWPROVIDEREDITBILLINGRATES NUMBER(10,0),
	UNITS NUMBER(7,2),
	MINHR VARCHAR(10),
	SERVICECODEID NUMBER(10,0),
	ISNONBILLABLE NUMBER(10,0),
	ISEXPANDCOLLAPSVISIBLE NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	AREARATESDEFINED BOOLEAN,
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