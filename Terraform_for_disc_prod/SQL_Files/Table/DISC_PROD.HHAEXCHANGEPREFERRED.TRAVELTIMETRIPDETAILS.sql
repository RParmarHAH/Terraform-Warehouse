CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.TRAVELTIMETRIPDETAILS (
	AGENCYID NUMBER(10,0),
	TRAVELTIMETRIPDETAILID NUMBER(19,0),
	TRAVELTIMEDETAILID NUMBER(19,0),
	TRAVELTIMECALCULATEDDETAILID NUMBER(19,0),
	TRAVELTIMEBATCHID NUMBER(19,0),
	TRAVELDATE TIMESTAMP_NTZ(9),
	GAPTIME VARCHAR(10),
	CAREGIVERCODE VARCHAR(20),
	CAREGIVERNAME VARCHAR(200),
	CAREGIVERID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	VISITID1 NUMBER(19,0),
	VISITID2 NUMBER(19,0),
	VISITHOURS1 VARCHAR(10),
	VISITHOURS2 VARCHAR(10),
	VISITSCHEDULEDHOURS1 VARCHAR(10),
	VISITSCHEDULEDHOURS2 VARCHAR(10),
	PATIENTID1 NUMBER(10,0),
	PATIENTID2 NUMBER(10,0),
	PATIENTNAME1 VARCHAR(300),
	PATIENTNAME2 VARCHAR(300),
	TRAVELTIMEVALUE NUMBER(10,0),
	TRANSPORTATIONMETHOD VARCHAR(200),
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