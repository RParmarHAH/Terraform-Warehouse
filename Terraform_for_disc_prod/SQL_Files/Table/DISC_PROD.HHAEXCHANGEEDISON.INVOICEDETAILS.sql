CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.INVOICEDETAILS (
	AGENCYID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	INVOICEDETAILID NUMBER(19,0),
	INVOICEHEADERID NUMBER(10,0),
	VISITID NUMBER(19,0),
	VISITDATE TIMESTAMP_NTZ(9),
	PATIENTID NUMBER(19,0),
	AIDEID NUMBER(10,0),
	SCHEDULESTARTTIME TIMESTAMP_NTZ(9),
	SCHEDULEENDTIME TIMESTAMP_NTZ(9),
	VISITSTARTTIME TIMESTAMP_NTZ(9),
	VISITENDTIME TIMESTAMP_NTZ(9),
	BILLEDHOURS NUMBER(10,0),
	BILLEDRATE NUMBER(18,6),
	OVERTIMEHOURS NUMBER(10,0),
	OVERTIMERATE NUMBER(18,2),
	TRAVELTIMEHOURS NUMBER(10,0),
	TRAVELTIMERATE NUMBER(18,2),
	BILLEDUNITS NUMBER(8,2),
	BILLEDAMOUNT NUMBER(18,2),
	THIRDPARTY NUMBER(18,2),
	PAYERID NUMBER(19,0),
	INVSERVICECODEID NUMBER(10,0),
	INVPAYRATEID NUMBER(10,0),
	INVPAYRATE NUMBER(18,2),
	INVRATETYPE VARCHAR(10),
	AUTHORIZATIONNUMBER VARCHAR(50),
	NONBILLABLE VARCHAR(1),
	PAYMENTSTATUS VARCHAR(14),
	PAYAMOUNT NUMBER(18,2),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	ISDELETED VARCHAR(1),
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