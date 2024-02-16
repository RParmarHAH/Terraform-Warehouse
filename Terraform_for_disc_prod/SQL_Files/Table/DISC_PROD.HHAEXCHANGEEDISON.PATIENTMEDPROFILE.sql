CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.PATIENTMEDPROFILE (
	AGENCYID NUMBER(10,0),
	MEDPROFILEID NUMBER(10,0),
	MEDDESCRIPTION VARCHAR(1000),
	PATIENTID NUMBER(10,0),
	STATUS VARCHAR(50),
	PHYSICIANNAME VARCHAR(200),
	DOSE VARCHAR(16777216),
	DOSEOTHER VARCHAR(500),
	FORM VARCHAR(200),
	FORMOTHER VARCHAR(100),
	ROUTE VARCHAR(200),
	ROUTEOTHER VARCHAR(100),
	AMOUNT VARCHAR(50),
	CLASS VARCHAR(50),
	FREQUENCYDESCRIPTION VARCHAR(200),
	STARTDATE TIMESTAMP_NTZ(9),
	ORDERDATE TIMESTAMP_NTZ(9),
	TAUGHTDATE TIMESTAMP_NTZ(9),
	DISCONTINUEDATE TIMESTAMP_NTZ(9),
	DISCONTINUEORDERDATE TIMESTAMP_NTZ(9),
	PHARMACYNAME VARCHAR(100),
	COMMENTS VARCHAR(500),
	CREATEDUSERNAME VARCHAR(50),
	CERTIFICATIONSTARTDATE TIMESTAMP_NTZ(9),
	CERTIFICATIONENDDATE TIMESTAMP_NTZ(9),
	OTHERFREQUENCYTEXT VARCHAR(100),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	ISDELETED VARCHAR(10),
	MEDICATIONID NUMBER(10,0),
	PHYSICIANID NUMBER(10,0),
	DOCID VARCHAR(100),
	PAYERID NUMBER(10,0),
	CERTIFICATIONPERIODID NUMBER(10,0),
	DOSEID NUMBER(10,0),
	FORMID NUMBER(10,0),
	ROUTEID NUMBER(10,0),
	FREQUENCYID NUMBER(10,0),
	PREFERREDPHARMACYID NUMBER(10,0),
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