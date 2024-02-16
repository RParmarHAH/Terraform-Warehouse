CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.CONTRACTS (
	AGENCYID NUMBER(10,0),
	CONTRACTID NUMBER(10,0) NOT NULL,
	CHHAID NUMBER(10,0),
	CONTRACTNAME VARCHAR(50),
	ADDRESS1 VARCHAR(100),
	ADDRESS2 VARCHAR(100),
	CITY VARCHAR(100),
	STATE VARCHAR(100),
	ZIPCODE VARCHAR(100),
	PHONE VARCHAR(30),
	FAX VARCHAR(30),
	AUTHORIZATIONREQUIRED VARCHAR(1),
	VALIDATEPAPERDUTYSHEET VARCHAR(1),
	REQUIREDCOMPLIANCE VARCHAR(24),
	CONTACTPERSON VARCHAR(50),
	GENERALEMAIL VARCHAR(2000),
	PAYMENTTERMS NUMBER(10,0),
	REASON VARCHAR(200),
	QBEXPORTCONTRACTNUMBER VARCHAR(50),
	QBEXPORTTERMS VARCHAR(50),
	QBACCOUNTINGNAME VARCHAR(200),
	QBTERMSSPELLED VARCHAR(200),
	QBACCOUNTNUMBER VARCHAR(200),
	QBTERMSINDAYS NUMBER(10,0),
	NOTES VARCHAR(8000),
	ISREASONREQUIRED VARCHAR(1),
	WAGEPARITY VARCHAR(1),
	AUTOMATICALLYFLAGASTS VARCHAR(53),
	CUSTOMROLLOVER VARCHAR(18),
	BILLLINKINGUNRECOGNIZEDNUMBER VARCHAR(1),
	AUTOSELECTTIMESHEETREQUIREDFORUNRECOGNIZEDNUMBER VARCHAR(1),
	BILLTIMESHEETNOTAPPROVED VARCHAR(1),
	ISVNSCONTRACT VARCHAR(1),
	TIMELYFILINGLIMIT NUMBER(10,0),
	DUTYSHEETTIMETYPE VARCHAR(14),
	DUTYSHEETGROUPBY VARCHAR(50),
	DUTYSHEETDISPLAYBILLEDHOURS VARCHAR(1),
	DUTYSHEETDISPLAYDATEOFBIRTH VARCHAR(1),
	DUTYSHEETDISPLAYMEDICAIDNUMBER VARCHAR(1),
	AUDITVISITVERIFICATION VARCHAR(1),
	AUDITVISITDATEANDTIME VARCHAR(1),
	AUDITVISITSUPERVISOR VARCHAR(1),
	CONTRACTTYPENAME VARCHAR(100),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	AUTHORIZATIONWEEKID NUMBER(10,0),
	AUTHORIZATIONWEEK VARCHAR(50),
	LINKEDCONTRACTPAYERID NUMBER(10,0),
	BILLINGCONFIGURATIONROUNDINGMINSDURATION VARCHAR(11),
	BILLINGCONFIGURATIONROUNDINGMINSBY VARCHAR(7),
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