CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.MILEAGE (
	AGENCYID NUMBER(10,0),
	MILEAGEID NUMBER(19,0),
	MILEAGEDATE TIMESTAMP_NTZ(9),
	CAREGIVERID NUMBER(10,0),
	CAREGIVERNAME VARCHAR(100),
	VISITID NUMBER(19,0),
	MILES NUMBER(18,2),
	PATIENTID NUMBER(19,0),
	PATIENTNAME VARCHAR(200),
	NOTES VARCHAR(16777216),
	SHIFT VARCHAR(100),
	SERVICECODEID NUMBER(10,0),
	SERVICECODE VARCHAR(100),
	PAYRATEID NUMBER(10,0),
	PAYRATETEXT VARCHAR(100),
	PAYRATE NUMBER(18,6),
	CONTRACTID NUMBER(10,0),
	CONTRACT VARCHAR(100),
	PAYERID NUMBER(10,0),
	BILLRATE NUMBER(18,2),
	BILLRATEAFTERBILLED NUMBER(18,2),
	PAYRATEAFTERPAYROLL NUMBER(18,2),
	PAYROLLBATCHID NUMBER(10,0),
	PAYROLLBATCHNUMBER VARCHAR(50),
	INVOICENUMBER NUMBER(19,0),
	INVOICEHEADERID NUMBER(10,0),
	BATCHID NUMBER(19,0),
	AUTHORIZATIONID NUMBER(10,0),
	AUTHORIZATIONNUMBER VARCHAR(100),
	PAYROLLOTHERCHARGESDETAILID NUMBER(19,0),
	PAYROLLOTHERCHARGESADJUSTMENTID NUMBER(19,0),
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