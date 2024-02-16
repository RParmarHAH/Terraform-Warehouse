CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.SCHEDULECHANGES (
	AGENCYID NUMBER(10,0),
	SCHEDULEID NUMBER(19,0) NOT NULL,
	INVOICEDETAILID NUMBER(19,0) NOT NULL,
	SCHEDULETYPE VARCHAR(2),
	VISITDATE TIMESTAMP_NTZ(9),
	PATIENTID NUMBER(19,0),
	SCHEDULEDSTARTTIME TIMESTAMP_NTZ(9),
	SCHEDULEDENDTIME TIMESTAMP_NTZ(9),
	CAREGIVERID NUMBER(10,0),
	PAYRATEID NUMBER(10,0),
	POCID NUMBER(19,0),
	PAYERID NUMBER(10,0),
	PRIMARYCONTRACTID NUMBER(10,0),
	PRIMARYSERVICECODEID NUMBER(10,0),
	VISITSTARTTIME TIMESTAMP_NTZ(9),
	VISITENDTIME TIMESTAMP_NTZ(9),
	ISMISSEDVISIT VARCHAR(1),
	TIMESHEETREQUIRED VARCHAR(1),
	EVVSTARTTIME TIMESTAMP_NTZ(9),
	EVVENDTIME TIMESTAMP_NTZ(9),
	VERIFIEDBY VARCHAR(13),
	VERIFIEDTEXT VARCHAR(500),
	DATEVERIFIED TIMESTAMP_NTZ(9),
	TIMEVERIFIED TIMESTAMP_NTZ(9),
	SUPERVISOR VARCHAR(500),
	TIMESHEETAPPROVED VARCHAR(1),
	DUTIESPERFORMED VARCHAR(4000),
	TRAVELTIMEMINUTES NUMBER(10,0),
	BILLED VARCHAR(1),
	BILLEDMINUTES VARCHAR(20),
	INVOICENUMBER VARCHAR(20),
	PAYROLLPAID VARCHAR(1),
	PAYROLLBATCHNUMBER VARCHAR(50),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	ISDELETED VARCHAR(1),
	OFFICEID NUMBER(10,0),
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