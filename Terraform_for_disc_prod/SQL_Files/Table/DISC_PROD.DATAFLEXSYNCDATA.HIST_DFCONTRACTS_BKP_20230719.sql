CREATE OR REPLACE TABLE DISC_PROD.DATAFLEXSYNCDATA.HIST_DFCONTRACTS_BKP_20230719 (
	DBNAME VARCHAR(12) NOT NULL,
	CONTRACTCODE VARCHAR(5) NOT NULL,
	CONTRACTNAME VARCHAR(50),
	PAYMENTMETHOD VARCHAR(5),
	BILLPERSONCODE VARCHAR(5),
	RATE1 NUMBER(18,5),
	RATE2 NUMBER(18,5),
	RATEEFFECTIVEDATE1 DATE,
	RATEEFFECTIVEDATE2 DATE,
	BILLABLE BOOLEAN,
	ISMEDWAIVER BOOLEAN,
	OVERHEADRATE1 NUMBER(18,5),
	OVERHEADRATE2 NUMBER(18,5),
	ISSKILLED BOOLEAN,
	BILLEDBYQUARTERHOURS BOOLEAN,
	USEBILLCODE BOOLEAN,
	PAYROLLCODE VARCHAR(15),
	BILLBYHALFHOURS BOOLEAN,
	LISTRATE1 NUMBER(18,5),
	LISTRATE2 NUMBER(18,5),
	DEFAULTBILLCODE VARCHAR(25),
	ISMILEAGE BOOLEAN,
	ALLOWQUARTERHOURS BOOLEAN,
	PAYTRAVELS BOOLEAN,
	PAYORCODE VARCHAR(10),
	PAYABLE BOOLEAN,
	CREATEDDATE TIMESTAMP_NTZ(9),
	UPDATEBATCH VARCHAR(36),
	UPDATEDTIME TIMESTAMP_NTZ(9),
	PAYINUNITS BOOLEAN,
	PAYINDOLLARS BOOLEAN,
	PAYINDOLLARPAYCODE VARCHAR(10),
	PAYINDOLLARRATE NUMBER(18,5),
	ISEVV BOOLEAN,
	REVENUECATEGORY VARCHAR(10),
	RATE3 NUMBER(18,5),
	RATE4 NUMBER(18,5),
	RATEEFFECTIVEDATE3 DATE,
	RATEEFFECTIVEDATE4 DATE,
	LISTRATE3 NUMBER(18,5),
	LISTRATE4 NUMBER(18,5),
	PAYTRAVELSCODE VARCHAR(3),
	REVENUESUBCATEGORY VARCHAR(10),
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