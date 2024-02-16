CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEOSHAH.HIST_PATIENTS (
	AGENCYID NUMBER(10,0),
	OFFICEID NUMBER(10,0),
	PAYERID NUMBER(10,0),
	PATIENTID NUMBER(10,0),
	FIRSTNAME VARCHAR(50),
	MIDDLENAME VARCHAR(50),
	LASTNAME VARCHAR(50),
	STATUSID NUMBER(10,0),
	ADMISSIONID VARCHAR(50),
	MRNUMBER VARCHAR(100),
	GENDER VARCHAR(10),
	DATEOFBIRTH TIMESTAMP_NTZ(9),
	PRIORITYCODE NUMBER(5,0),
	ACCEPTEDSERVICES VARCHAR(1000),
	MEDICAIDNUMBER VARCHAR(20),
	MEDICARENUMBER VARCHAR(25),
	SSN VARCHAR(50),
	ADDRESS1 VARCHAR(500),
	ADDRESS2 VARCHAR(55),
	CITY VARCHAR(50),
	STATE VARCHAR(50),
	ZIP5 VARCHAR(50),
	ZIP4 VARCHAR(10),
	CROSSSTREET VARCHAR(80),
	DIRECTION VARCHAR(500),
	HOMEPHONE VARCHAR(50),
	PHONE2 VARCHAR(50),
	PHONE2DESCRIPTION VARCHAR(50),
	PHONE3 VARCHAR(50),
	PHONE3DESCRIPTION VARCHAR(50),
	WAGEPARITY VARCHAR(1),
	WAGEPARITYFROMDATE1 TIMESTAMP_NTZ(9),
	WAGEPARITYTODATE1 TIMESTAMP_NTZ(9),
	WAGEPARITYFROMDATE2 TIMESTAMP_NTZ(9),
	WAGEPARITYTODATE2 TIMESTAMP_NTZ(9),
	ISALTERNATEBILLING VARCHAR(1),
	ALTERNATEBILLINGFIRSTNAME VARCHAR(50),
	ALTERNATEBILLINGLASTNAME VARCHAR(50),
	ALTERNATEBILLINGMIDDLENAME VARCHAR(50),
	ALTERNATEBILLINGSTREET VARCHAR(500),
	ALTERNATEBILLINGCITY VARCHAR(50),
	ALTERNATEBILLINGSTATE VARCHAR(50),
	ALTERNATEBILLINGZIPCODE VARCHAR(50),
	EMERGENCYCONTACT1NAME VARCHAR(50),
	EMERGENCYCONTACT1RELATIONSHIPID NUMBER(10,0),
	EMERGENCYCONTACT1RELATIONSHIPNAME VARCHAR(500),
	EMERGENCYCONTACT1RELATIONSHIPOTHER VARCHAR(500),
	EMERGENCYCONTACT1LIVESWITHPARENT VARCHAR(1),
	EMERGENCYCONTACT1HAVEKEYS VARCHAR(1),
	EMERGENCYCONTACT1PHONE1 VARCHAR(15),
	EMERGENCYCONTACT1PHONE2 VARCHAR(15),
	EMERGENCYCONTACT1ADDRESS VARCHAR(500),
	EMERGENCYCONTACT2NAME VARCHAR(500),
	EMERGENCYCONTACT2RELATIONSHIPID NUMBER(10,0),
	EMERGENCYCONTACT2RELATIONSHIPNAME VARCHAR(500),
	EMERGENCYCONTACT2RELATIONSHIPOTHER VARCHAR(500),
	EMERGENCYCONTACT2LIVESWITHPARENT VARCHAR(1),
	EMERGENCYCONTACT2HAVEKEYS VARCHAR(1),
	EMERGENCYCONTACT2PHONE1 VARCHAR(15),
	EMERGENCYCONTACT2PHONE2 VARCHAR(15),
	EMERGENCYCONTACT2ADDRESS VARCHAR(100),
	MOBILITYSTATUSID NUMBER(10,0),
	EVACUATIONZONEID NUMBER(10,0),
	EVACUATIONLOCATIONID NUMBER(10,0),
	OTHEREVACUATIONLOCATION VARCHAR(25),
	ELECTRICEQUIPMENTDEPENDENCY VARCHAR(16777216),
	EMERGENCYPREPAREDNESSDESCRIPTION VARCHAR(50),
	NURSEID NUMBER(10,0),
	COORDINATORS VARCHAR(500),
	FREQUENCY VARCHAR(50),
	CLUSTER VARCHAR(1),
	ISMUTUALLINKED VARCHAR(6),
	MUTUALLINKPATIENTID NUMBER(19,0),
	ISPRIMARYPATIENT VARCHAR(1),
	SERVICESTARTDATE TIMESTAMP_NTZ(9),
	PROJECTEDDCDATE TIMESTAMP_NTZ(9),
	SOURCEOFADMISSIONID NUMBER(10,0),
	LOCATIONID NUMBER(10,0),
	TEAMID NUMBER(10,0),
	BRANCHID NUMBER(10,0),
	ALERT VARCHAR(4000),
	REFERRALMASTERID NUMBER(10,0),
	REFERRALRECEIVEDDATE TIMESTAMP_NTZ(9),
	REFERRALSOURCEID NUMBER(10,0),
	REFERRALSTATUS VARCHAR(15),
	REFERRALLOSTREASONID NUMBER(10,0),
	REFERRALLOSTREASONNOTE VARCHAR(500),
	COMMISSIONSTATUS VARCHAR(8),
	REFERRALCONTACTID NUMBER(10,0),
	REFERRALINTAKEPERSONID NUMBER(10,0),
	ACCOUNTMANAGERID NUMBER(10,0),
	REQUESTSPECIALAGENCYID NUMBER(10,0),
	REQUESTGENDER VARCHAR(10),
	REQUESTPRIMARYLANGUAGE NUMBER(10,0),
	REQUESTSECONDARYLANGUAGE NUMBER(10,0),
	REQUESTOTHER VARCHAR(1000),
	EVVREQUIRED VARCHAR(1),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	BRANCHNAME VARCHAR(200),
	PAYERCOORDINATORS VARCHAR(500),
	PROFILEHEADERALERT VARCHAR(50),
	HOMEPHONELOCATIONADDRESS VARCHAR(500),
	HOMEPHONE2LOCATIONADDRESS VARCHAR(500),
	HOMEPHONE3LOCATIONADDRESS VARCHAR(500),
	OFFICEADMISSIONID VARCHAR(100),
	USEPAPERSHEET NUMBER(10,0),
	VALIDATEPAPERDUTYSHEET NUMBER(10,0),
	LINKEDPATIENT NUMBER(10,0),
	PAYERPRIORITYCODE VARCHAR(50),
	PROVIDERPRIORITYCODE NUMBER(10,0),
	RACE VARCHAR(100),
	ETHNICITY VARCHAR(100),
	DISCHARGEDATE TIMESTAMP_NTZ(9),
	LANGUAGE3 VARCHAR(50),
	LANGUAGE4 VARCHAR(50),
	PATIENTSNURSE VARCHAR(200),
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