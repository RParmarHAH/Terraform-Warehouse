CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.PATIENTCAREPATHQUESTIONS (
	ID NUMBER(10,0),
	AGENCYID NUMBER(10,0),
	QUESTIONSDETAILSID NUMBER(10,0),
	QUESTION VARCHAR(16777216),
	FREQUENCY VARCHAR(100),
	PRIORITY VARCHAR(100),
	ALERTISSUED VARCHAR(16777216),
	DISEASEID NUMBER(10,0),
	QUESTIONID NUMBER(10,0),
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