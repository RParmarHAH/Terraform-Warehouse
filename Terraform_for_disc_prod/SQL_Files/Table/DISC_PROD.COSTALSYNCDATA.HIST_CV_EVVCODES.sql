CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.HIST_CV_EVVCODES (
	DB VARCHAR(25) NOT NULL,
	RECSTAT VARCHAR(1),
	ENTRY_USER VARCHAR(16),
	ENTRY_DATE TIMESTAMP_NTZ(9),
	UPDATE_USER VARCHAR(16),
	UPDATE_DATE TIMESTAMP_NTZ(9),
	EVV_CODE VARCHAR(16) NOT NULL,
	EVV_DESCRIPTION VARCHAR(512),
	BUSINESS_ENTITY_ID VARCHAR(50),
	LOCATION_CODES VARCHAR(1024),
	FACILITY_CODES VARCHAR(1024),
	PLAN_CODES VARCHAR(1024),
	PROVIDERQUALIFIER VARCHAR(20),
	PROVIDERID VARCHAR(50),
	EVV_USER_NAME VARCHAR(1024),
	EVV_PASSWORD VARCHAR(8000),
	PATIENT_MESSAGE_URL VARCHAR(4000),
	EMPLOYEE_MESSAGE_URL VARCHAR(4000),
	VISIT_MESSAGE_URL VARCHAR(4000),
	SQLSERVER_INSTANCE_NAME VARCHAR(1024),
	SYS_DB_NAME VARCHAR(1024),
	COMPANY_DB_NAME VARCHAR(1024),
	COMPANY_CODE VARCHAR(32),
	TEST_OR_PRODUCTION VARCHAR(1),
	EVV_INTERFACE_TYPE VARCHAR(64),
	DDL_FACILITY_PLAN NUMBER(10,0),
	FTP_URL VARCHAR(4000),
	SSHHOSTKEYFINGERPRINT VARCHAR(8000),
	FTP_DOWNLOAD_FOLDER VARCHAR(4000),
	USER_DOWNLOAD_FOLDER VARCHAR(4000),
	PORT_NUMBER NUMBER(10,0),
	SFTP_INFOLDER VARCHAR(1024),
	SFTP_OUTFOLDER VARCHAR(1024),
	LOCAL_EXPORTIMPORT_FOLDER VARCHAR(4000),
	PROVIDER_NAME VARCHAR(255),
	PROVIDER_NPI VARCHAR(10),
	PROVIDER_EIN_TAXID VARCHAR(64),
	SENDONLYBILLABLESVCFLAG NUMBER(3,0),
	SENDONLYMAPPEDVISITSFLAG NUMBER(3,0),
	SENDVERIFIEDVISITSFLAG NUMBER(3,0),
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