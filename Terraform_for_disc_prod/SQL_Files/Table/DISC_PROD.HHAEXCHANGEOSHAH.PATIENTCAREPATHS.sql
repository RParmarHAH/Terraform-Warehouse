CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.PATIENTCAREPATHS (
	AGENCYID NUMBER(10,0),
	CAREPATHSETUPID NUMBER(10,0) NOT NULL,
	PATIENTID NUMBER(10,0),
	CAREPATHS VARCHAR(2000),
	ENROLLMENTSTARTDATE TIMESTAMP_NTZ(9),
	ENROLLMENTENDDATE TIMESTAMP_NTZ(9),
	STATUS VARCHAR(10),
	CREATEDDATE TIMESTAMP_NTZ(9),
	DISEASEID NUMBER(10,0),
	ILLNESSMASTERID NUMBER(10,0),
	DIAGNOSISQUESTIONID NUMBER(10,0),
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