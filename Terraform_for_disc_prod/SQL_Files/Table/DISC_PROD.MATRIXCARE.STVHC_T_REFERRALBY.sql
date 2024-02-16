CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_REFERRALBY (
	REFBY_ID NUMBER(19,0),
	REFBY_REFERRALFACILITIESID NUMBER(19,0),
	REFBY_STATUSID NUMBER(10,0),
	REFBY_DEPARTMENT VARCHAR(50),
	REFBY_PRIMARY VARCHAR(50),
	REFBY_STAFFID NUMBER(10,0),
	REFBY_REFERRALRATINGID NUMBER(10,0),
	REFBY_REFERRALTERRITORYID NUMBER(10,0),
	REFBY_OLDID NUMBER(19,0),
	REFBY_SUPERVISORNAME VARCHAR(100),
	REFBY_USEADDRESSFROMPARENT BOOLEAN,
	REFBY_TOTALREFERRALS NUMBER(10,0),
	REFBY_TOTALADMISSIONSOC NUMBER(10,0),
	REFBY_TOTALADMISSIONACTIVE NUMBER(10,0),
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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