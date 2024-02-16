CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.PATIENTVISITCAREPATHOBSERVATIONS (
	AGENCYID NUMBER(10,0),
	VISITFEEDBACKDETAILID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	VISITID NUMBER(19,0),
	LANGUAGEID NUMBER(19,0),
	QUESTIONID NUMBER(19,0),
	DIAGNOSISQUESTIONID NUMBER(19,0),
	OBSERVATIONS VARCHAR(16777216),
	RESPONSE VARCHAR(16777216),
	ALERT VARCHAR(220),
	STATUS VARCHAR(15),
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