CREATE OR REPLACE TABLE DISC_PROD.MATRIXCARE.STVHC_T_CLIENTINQUIRY (
	CLIINQ_ID NUMBER(19,0),
	CLIINQ_BRANCHID NUMBER(10,0),
	CLIINQ_DATE TIMESTAMP_NTZ(9),
	CLIINQ_CALLERRELATONID NUMBER(10,0),
	CLIINQ_CALLERADDRESS1 VARCHAR(50),
	CLIINQ_CALLERADDRESS2 VARCHAR(60),
	CLIINQ_CALLERCITY VARCHAR(50),
	CLIINQ_CALLERSTATEORPROVINCE VARCHAR(20),
	CLIINQ_CALLERPOSTALCODE VARCHAR(20),
	CLIINQ_CALLERCOUNTY VARCHAR(50),
	CLIINQ_CALLERCOUNTRY NUMBER(10,0),
	CLIINQ_CALLERPHONE1 VARCHAR(30),
	CLIINQ_CALLERPHONE2 VARCHAR(30),
	CLIINQ_CLIENTLASTNAME VARCHAR(50),
	CLIINQ_CLIENTFIRSTNAME VARCHAR(50),
	CLIINQ_CLIENTADDRESS1 VARCHAR(50),
	CLIINQ_CLIENTADDRESS2 VARCHAR(60),
	CLIINQ_CLIENTCITY VARCHAR(50),
	CLIINQ_CLIENTSTATEORPROVINCE VARCHAR(20),
	CLIINQ_CLIENTPOSTALCODE VARCHAR(20),
	CLIINQ_CLIENTCOUNTY VARCHAR(50),
	CLIINQ_CLIENTCOUNTRY NUMBER(10,0),
	CLIINQ_CLIENTBIRTHDATE TIMESTAMP_NTZ(9),
	CLIINQ_SECONDCLIENTNAME VARCHAR(50),
	CLIINQ_SECONDCLIENTRELATION VARCHAR(20),
	CLIINQ_SECONDCLIENTBIRTHDATE TIMESTAMP_NTZ(9),
	CLIINQ_REFERRALDATE TIMESTAMP_NTZ(9),
	CLIINQ_REFERRALTYPEID NUMBER(10,0),
	CLIINQ_LOCATIONISCLIENT BOOLEAN,
	CLIINQ_SERVICECALLADDRESS1 VARCHAR(50),
	CLIINQ_SERVICECALLADDRESS2 VARCHAR(60),
	CLIINQ_SERVICECALLCITY VARCHAR(50),
	CLIINQ_SERVICECALLSTATEORPROVINCE VARCHAR(20),
	CLIINQ_SERVICECALLPOSTALCODE VARCHAR(20),
	CLIINQ_SERVICECALLCOUNTY VARCHAR(50),
	CLIINQ_SERVICECALLCOUNTRY NUMBER(10,0),
	CLIINQ_SERVICECALLPHONE1 VARCHAR(30),
	CLIINQ_SERVICECALLPHONE2 VARCHAR(30),
	CLIINQ_NOTES VARCHAR(4000),
	CLIINQ_NONADMISSIONREASONID NUMBER(10,0),
	CLIINQ_ACTUALSOCDATE TIMESTAMP_NTZ(9),
	CLIINQ_BILLTO NUMBER(3,0),
	CLIINQ_PAYERID NUMBER(19,0),
	CLIINQ_CONVERTEDCLIENTID NUMBER(19,0),
	CLIINQ_CONVERTEDCLIENTDATE TIMESTAMP_NTZ(9),
	CLIINQ_CONVERTEDCLIENTUSER VARCHAR(50),
	CLIINQ_CREATEDDATE TIMESTAMP_NTZ(9),
	CLIINQ_CREATEDUSER VARCHAR(50),
	CLIINQ_MODIFIEDDATE TIMESTAMP_NTZ(9),
	CLIINQ_MODIFIEDUSER VARCHAR(50),
	CLIINQ_TS VARCHAR(100),
	CLIINQ_LEGACYID NUMBER(10,0),
	CLIINQ_CALLERFIRSTNAME VARCHAR(50),
	CLIINQ_CALLERLASTNAME VARCHAR(50),
	CLIINQ_CAREGIVERID NUMBER(19,0),
	CLIINQ_AMBULATORYFLAG BOOLEAN,
	CLIINQ_AMBULATORYNOTES VARCHAR(16777216),
	CLIINQ_MEDICATIONSFLAG BOOLEAN,
	CLIINQ_MEDICATIONSNOTES VARCHAR(16777216),
	CLIINQ_INCONTINENTFLAG BOOLEAN,
	CLIINQ_INCONTINENTNOTES VARCHAR(16777216),
	CLIINQ_ALLOWMASSEMAIL BOOLEAN,
	CLIINQ_CALLEREMAIL VARCHAR(50),
	CLIINQ_LOCATIONISSERVICECALL BOOLEAN,
	CLIINQ_CALLERBROCHURESENT BOOLEAN,
	CLIINQ_CLIENTBROCHURESENT BOOLEAN,
	CLIINQ_SERVICECALLBROCHURESENT BOOLEAN,
	CLIINQ_REFERRALENTITYTYPEID NUMBER(3,0),
	CLIINQ_REFERRALENTITYID NUMBER(19,0),
	CLIINQ_REFERRALCONTACTJOINID NUMBER(19,0),
	CLIINQ_STAFFID NUMBER(19,0),
	CLIINQ_OASISPHYSICIANID NUMBER(19,0),
	CLIINQ_REFERRALNOTES VARCHAR(16777216),
	CLIINQ_REFERRALCAMPAIGNID NUMBER(10,0),
	CLIINQ_REFERRALTAKENBY VARCHAR(50),
	CLIINQ_SERVICECALL_ACTIVITYID NUMBER(19,0),
	CLIINQ_CLIENTADDRESSFROM NUMBER(3,0),
	CLIINQ_SERVICECALLADDRESSFROM NUMBER(3,0),
	CLIINQ_CLIENTSALUTATIONID NUMBER(10,0),
	CLIINQ_CALLERSALUTATIONID NUMBER(10,0),
	CLIINQ_NONADMISSIONNOTES VARCHAR(1024),
	CLIINQ_REFERRALTAKENBYID NUMBER(19,0),
	CLIINQ_CLIENTEMAIL VARCHAR(50),
	CLIINQ_CLIENTALLOWMASSEMAIL BOOLEAN,
	CLIINQ_SERVICECALLSCHEDULEDBYID NUMBER(19,0),
	CLIINQ_REGIONID NUMBER(10,0),
	CLIINQ_CLIENTINQUIRYRATINGID NUMBER(10,0),
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