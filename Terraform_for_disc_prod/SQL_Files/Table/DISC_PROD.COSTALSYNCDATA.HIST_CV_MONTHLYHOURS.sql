CREATE OR REPLACE TABLE DISC_PROD.COSTALSYNCDATA.HIST_CV_MONTHLYHOURS (
	DB VARCHAR(25) NOT NULL,
	OFFICENAME VARCHAR(100),
	LOCATION_CODE VARCHAR(10),
	SUPERVISORCODE VARCHAR(10),
	SUPERVISORNAME VARCHAR(100),
	SERVICEMONTH NUMBER(10,0) NOT NULL,
	SERVICEYEAR NUMBER(10,0) NOT NULL,
	AUTHDATACOULDBEUPDATED BOOLEAN,
	CLIENTNUMBER NUMBER(10,0) NOT NULL,
	CLIENTNAME VARCHAR(100),
	CONTRACTCODE VARCHAR(10) NOT NULL,
	CONTRACTNAME VARCHAR(50),
	HOURSAUTHORIZED NUMBER(12,2),
	HOURSSERVED NUMBER(12,2),
	REFERRALDATE DATE,
	FIRSTDATEOFSERVICE DATE,
	FIRSTDATEOFSERVICE_CONTRACTCODE VARCHAR(10),
	FIRSTDATEOFSERVICE_CONTRACTNAME VARCHAR(100),
	LASTDATEOFSERVICE_SERVICEMONTH DATE,
	ACTIVE BOOLEAN,
	BILLRATE NUMBER(18,5),
	EMPLOYEEID VARCHAR(12) NOT NULL,
	PAYRATE NUMBER(18,2),
	PAYHOURS NUMBER(12,2),
	TOTALPAY NUMBER(18,2),
	ADMIT_DATE TIMESTAMP_NTZ(9),
	DISCHARGE_DATE TIMESTAMP_NTZ(9),
	CLIENT_PLAN_FIRSTDATEOFSERVICE TIMESTAMP_NTZ(9),
	CLIENT_PLAN_LASTDATEOFSERVICE TIMESTAMP_NTZ(9),
	NUMBEROFSCHEDULES NUMBER(10,0),
	HOURSBILLED NUMBER(18,5),
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