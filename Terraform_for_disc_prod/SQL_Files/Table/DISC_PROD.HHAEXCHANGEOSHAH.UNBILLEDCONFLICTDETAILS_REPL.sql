CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.UNBILLEDCONFLICTDETAILS_REPL (
	AGENCYID NUMBER(10,0),
	UNBILLEDCONFLICTDETAILID NUMBER(19,0) NOT NULL,
	PATIENTID NUMBER(10,0),
	PATIENTNAME VARCHAR(200),
	ADMISSIONID VARCHAR(100),
	PAYERID NUMBER(10,0),
	PAYERNAME VARCHAR(200),
	AGENCYNAME VARCHAR(200),
	CAREGIVERID NUMBER(19,0),
	CAREGIVERNAME VARCHAR(200),
	CAREGIVERCODE VARCHAR(100),
	CAREGIVERSSN VARCHAR(100),
	VISITID NUMBER(19,0),
	AGENCYPHONENUMBER VARCHAR(100),
	VISITDATE TIMESTAMP_NTZ(9),
	VISITSTARTTIME TIMESTAMP_NTZ(9),
	VISITENDTIME TIMESTAMP_NTZ(9),
	BILLEDHOURS VARCHAR(50),
	BILLEDMINUTES NUMBER(10,0),
	BILLEDDATE TIMESTAMP_NTZ(9),
	SCHEDULEDHOURS VARCHAR(50),
	SCHEDULEDMINUTES NUMBER(10,0),
	CONFLICTINGHOURS VARCHAR(20),
	CONFLICTPATIENTID NUMBER(10,0),
	CONFLICTPATIENTNAME VARCHAR(200),
	CONFLICTADMISSIONID VARCHAR(200),
	CONFLICTPAYERID NUMBER(10,0),
	CONFLICTPAYERNAME VARCHAR(200),
	CONFLICTAGENCYID NUMBER(10,0),
	CONFLICTAGENCYNAME VARCHAR(200),
	CONFLICTCAREGIVERID NUMBER(10,0),
	CONFLICTCAREGIVERNAME VARCHAR(200),
	CONFLICTCAREGIVERCODE VARCHAR(100),
	CONFLICTCAREGIVERSSN VARCHAR(100),
	CONFLICTVISITID NUMBER(19,0),
	CONFLICTAGENCYPHONENUMBER VARCHAR(100),
	CONFLICTVISITDATE TIMESTAMP_NTZ(9),
	CONFLICTVISITSTARTTIME TIMESTAMP_NTZ(9),
	CONFLICTVISITENDTIME TIMESTAMP_NTZ(9),
	CONFLICTSCHEDULEDSTARTTIME TIMESTAMP_NTZ(9),
	CONFLICTSCHEDULEDENDTIME TIMESTAMP_NTZ(9),
	CONFLICTSTATUS NUMBER(3,0),
	NOTE VARCHAR(16777216),
	NOTECREATEDDATE TIMESTAMP_NTZ(9),
	NOTECREATEDBY NUMBER(10,0),
	CAREGIVERLASTNAME VARCHAR(50),
	CAREGIVERFIRSTNAME VARCHAR(50),
	SCHEDULEDTIME VARCHAR(10),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBY NUMBER(10,0),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
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