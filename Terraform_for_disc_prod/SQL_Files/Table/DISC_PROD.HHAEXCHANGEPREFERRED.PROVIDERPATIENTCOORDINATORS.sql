CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.PROVIDERPATIENTCOORDINATORS (
	AGENCYID NUMBER(10,0),
	PROVIDERCOORDINATORID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	COORDINATORID NUMBER(10,0),
	COORDINATORNAME VARCHAR(50),
	COORDINATORSRNO NUMBER(10,0),
	CREATEDBY NUMBER(10,0),
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEDBY NUMBER(10,0),
	UPDATEDDATE TIMESTAMP_NTZ(9),
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