CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.PAYROLL_OTHERCHARGESDETAILS_REPL (
	AGENCYID NUMBER(10,0),
	PAYROLLOTHERCHARGESDETAILID NUMBER(19,0) NOT NULL,
	BATCHID NUMBER(10,0),
	PATIENTID NUMBER(19,0),
	CAREGIVEREXPENSEID NUMBER(10,0),
	CAREGIVERID NUMBER(10,0),
	OTHERCHARGEID NUMBER(10,0),
	VISITID NUMBER(19,0),
	CHARGETYPE VARCHAR(10),
	CHARGETYPENAME VARCHAR(100),
	REGULARHOURS NUMBER(10,0),
	PAYAMOUNT NUMBER(18,2),
	PAYRATEID NUMBER(10,0),
	PAYRATE NUMBER(18,2),
	PAYRATE2 NUMBER(18,6),
	PAYRATECODE VARCHAR(50),
	RATETYPE VARCHAR(20),
	PAYROLLWEEKID NUMBER(10,0),
	PAYERID NUMBER(10,0),
	WAGEPARITY BOOLEAN,
	TRAVELTIMEDETAILID NUMBER(19,0),
	OTHOURS NUMBER(10,0),
	OTAMOUNT NUMBER(18,6),
	OTPAYRATEID NUMBER(10,0),
	OTPAYRATE NUMBER(18,6),
	OTPAYRATECODE VARCHAR(50),
	OTPAYRATE2 NUMBER(18,6),
	HOLIDAYHOURS NUMBER(10,0),
	HOLIDAYAMOUNT NUMBER(18,6),
	HOLIDAYPAYRATEID NUMBER(10,0),
	HOLIDAYPAYRATE NUMBER(18,6),
	HOLIDAYPAYRATECODE VARCHAR(50),
	HOLIDAYPAYRATE2 NUMBER(18,6),
	MILEAGEID NUMBER(19,0),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDUTCDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDUTCDATE TIMESTAMP_NTZ(9),
	VISITDATE TIMESTAMP_NTZ(9),
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