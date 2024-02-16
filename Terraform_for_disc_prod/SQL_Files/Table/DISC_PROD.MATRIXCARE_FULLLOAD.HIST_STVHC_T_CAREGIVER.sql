CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_CAREGIVER (
	CAR_ID NUMBER(19,0) NOT NULL,
	CAR_LASTNAME VARCHAR(50),
	CAR_FIRSTNAME VARCHAR(50),
	CAR_MIDDLENAME VARCHAR(50),
	CAR_STATUSID NUMBER(10,0),
	CAR_BRANCHID NUMBER(10,0),
	CAR_REGIONID NUMBER(10,0),
	CAR_INTERNALID VARCHAR(20),
	CAR_PHONE VARCHAR(30),
	CAR_PHONETYPE NUMBER(10,0),
	CAR_TITLE VARCHAR(50),
	CAR_SKILLCD NUMBER(10,0),
	CAR_ADDRESS1 VARCHAR(255),
	CAR_ADDRESS2 VARCHAR(60),
	CAR_CITY VARCHAR(50),
	CAR_STATEORPROVINCE VARCHAR(20),
	CAR_POSTALCODE VARCHAR(20),
	CAR_COUNTY VARCHAR(50),
	CAR_COUNTRY NUMBER(10,0),
	CAR_EMAIL1 VARCHAR(50),
	CAR_EMAIL2 VARCHAR(50),
	CAR_TEXTMESSAGE VARCHAR(50),
	CAR_BIRTHDATE TIMESTAMP_NTZ(9),
	CAR_SPOUSENAME VARCHAR(50),
	CAR_NOTES VARCHAR(4000),
	CAR_ADPFILENUM VARCHAR(50),
	CAR_NPI VARCHAR(10),
	CAR_EMPSUBCOD_UD VARCHAR(15),
	CAR_GROUP NUMBER(10,0),
	CAR_EMPOTFLAG BOOLEAN,
	CAR_TELEPHONYID VARCHAR(36),
	CAR_SUPERVISOR NUMBER(19,0),
	CAR_MANAGER NUMBER(19,0),
	CAR_INTERNALCASEMGR NUMBER(3,0),
	CAR_SHIFTDIFFFLAG BOOLEAN,
	CAR_PAYTYPE NUMBER(3,0),
	CAR_WAGECHARTID NUMBER(10,0),
	CAR_PAYRATE NUMBER(18,2),
	CAR_NUMALLOWANCES NUMBER(3,0),
	CAR_WITHHOLD NUMBER(18,2),
	CAR_PAYPREFERENCE VARCHAR(2),
	CAR_VACATIONHOURS NUMBER(18,0),
	CAR_DDBANKACCTTYPE VARCHAR(1),
	CAR_EXCLUDEHOLIDAY BOOLEAN,
	CAR_CREATEDDATE TIMESTAMP_NTZ(9),
	CAR_CREATEDUSER VARCHAR(50),
	CAR_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CAR_MODIFIEDUSER VARCHAR(50),
	CAR_TS VARCHAR(100),
	CAR_ROLE NUMBER(3,0),
	CAR_LEGACYID NUMBER(10,0),
	CAR_LEGACYBRANCHID NUMBER(10,0),
	CAR_EMPSSN VARCHAR(255),
	CAR_DDBANKROUTINGNUM VARCHAR(255),
	CAR_DDBANKACCTNUM VARCHAR(255),
	CAR_CALCUNIQUESSN VARCHAR(255),
	CAR_BONUSPOINTSTHERSHOLD NUMBER(18,0),
	CAR_EMPSEXID NUMBER(10,0),
	CAR_MARITALSTATID NUMBER(10,0),
	CAR_EMPSALUTID NUMBER(10,0),
	CAR_NICKNAME VARCHAR(32),
	CAR_ALLOWMASSEMAIL BOOLEAN,
	CAR_REFERRALTERRITORYID NUMBER(10,0),
	CAR_UPLOADTELEPHONY BOOLEAN,
	CAR_WSNUMALLOWANCES NUMBER(3,0),
	CAR_WSWITHHOLD NUMBER(18,2),
	CAR_SUISDI_TAXJURISDICTION VARCHAR(50),
	CAR_FEDFILINGSTATUS NUMBER(3,0),
	CAR_WSFILINGSTATUS NUMBER(10,0),
	CAR_WORKSTATE VARCHAR(50),
	CAR_RSNUMALLOWANCES NUMBER(3,0),
	CAR_RSWITHHOLD NUMBER(18,2),
	CAR_RSFILINGSTATUS NUMBER(10,0),
	CAR_TELEPHONYALLOWCAREGIVERPHONE BOOLEAN,
	CAR_EDIADDITIONALID VARCHAR(20),
	CAR_EDIADDITIONALIDTYPE VARCHAR(3),
	CAR_RACEID NUMBER(10,0),
	CAR_EMPMHFLAG BOOLEAN,
	INSERTDATE TIMESTAMP_NTZ(9),
	UPDATEDATE TIMESTAMP_NTZ(9),
	DELETEDFLAG BOOLEAN,
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