CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEEDISON.HIST_CAREGIVERS (
	AGENCYID NUMBER(10,0),
	CAREGIVERID NUMBER(10,0),
	FIRSTNAME VARCHAR(50),
	MIDDLENAME VARCHAR(50),
	LASTNAME VARCHAR(50),
	INITIALS VARCHAR(4),
	GENDER VARCHAR(10),
	DATEOFBIRTH TIMESTAMP_NTZ(9),
	CAREGIVERCODE VARCHAR(6),
	TIMEANDATTENDANCEPIN VARCHAR(20),
	ALTERNATECAREGIVERCODE VARCHAR(500),
	SSN VARCHAR(50),
	ETHNICITY VARCHAR(200),
	REHIREDATE TIMESTAMP_NTZ(9),
	COUNTRYOFBIRTH VARCHAR(50),
	MARITALSTATUS VARCHAR(1),
	DEPENDENTS VARCHAR(10),
	EMPLOYEETYPE VARCHAR(1),
	STATUS VARCHAR(10),
	INACTIVEREASONID NUMBER(10,0),
	INACTIVENOTE VARCHAR(8000),
	TERMINATEDDATE TIMESTAMP_NTZ(9),
	SENT105 VARCHAR(1),
	EMPLOYMENTTYPE VARCHAR(8000),
	EMPLOYEEID VARCHAR(20),
	APPLICATIONDATE TIMESTAMP_NTZ(9),
	TEAMID NUMBER(10,0),
	LOCATIONID NUMBER(10,0),
	BRANCHID NUMBER(10,0),
	PAYER VARCHAR(5000),
	REGISTRYNUMBER VARCHAR(20),
	REGISTRYDATE TIMESTAMP_NTZ(9),
	REFERRALSOURCEID NUMBER(19,0),
	REFERRALPERSON VARCHAR(50),
	NYCREGISTRYCHECKEDON VARCHAR(1),
	NYCREGISTRYCHECKEDDATE TIMESTAMP_NTZ(9),
	EXCLUSIONLISTCHECKEDON TIMESTAMP_NTZ(9),
	EXCLUSIONLISTSTATUS VARCHAR(1),
	STREET1 VARCHAR(100),
	STREET2 VARCHAR(100),
	CITY VARCHAR(100),
	STATE VARCHAR(100),
	ZIP5 VARCHAR(100),
	ZIP4 VARCHAR(10),
	HOMEPHONE VARCHAR(30),
	PHONE2 VARCHAR(30),
	PHONE3 VARCHAR(30),
	EMERGENCY1NAME VARCHAR(200),
	EMERGENCY1ADDRESS VARCHAR(500),
	EMERGENCY1RELATIONSHIPID1 NUMBER(10,0),
	EMERGENCY1RELATIONSHIPNAME1 VARCHAR(100),
	EMERGENCY1RELATIONSHIPOTHER1 VARCHAR(50),
	EMERGENCY1PHONE1 VARCHAR(50),
	EMERGENCY1PHONE2 VARCHAR(50),
	EMERGENCY2NAME VARCHAR(50),
	EMERGENCY2ADDRESS VARCHAR(500),
	EMERGENCY2RELATIONSHIPID2 NUMBER(10,0),
	EMERGENCY2RELATIONSHIPNAME1 VARCHAR(100),
	EMERGENCY1RELATIONSHIPOTHER2 VARCHAR(50),
	EMERGENCY2PHONE1 VARCHAR(50),
	EMERGENCY2PHONE2 VARCHAR(50),
	NOTIFICATIONMETHOD VARCHAR(19),
	NOTIFICATIONEMAIL VARCHAR(100),
	NOTIFICATIONTEXTNUMBER VARCHAR(30),
	NOTIFICATIONVOICEMAIL VARCHAR(30),
	HIREDATE TIMESTAMP_NTZ(9),
	I9DOCUMENTID NUMBER(10,0),
	I9DOCUMENT2 VARCHAR(29),
	I9EXPIRATIONDATE TIMESTAMP_NTZ(9),
	I9VERIFIED VARCHAR(1),
	I9COMMENTS VARCHAR(500),
	REFERENCE1 VARCHAR(50),
	REFERENCE2 VARCHAR(50),
	DEGREE VARCHAR(50),
	CRIMINALBACKGROUNDDATE1 TIMESTAMP_NTZ(9),
	CRIMINALBACKGROUNDRESULT1 VARCHAR(16),
	CRIMINALBACKGROUNDRECEIVEDDATE1 TIMESTAMP_NTZ(9),
	CRIMINALBACKGROUNDDATE2 TIMESTAMP_NTZ(9),
	CRIMINALBACKGROUNDRESULT2 VARCHAR(16),
	CRIMINALBACKGROUNDRECEIVEDDATE2 TIMESTAMP_NTZ(9),
	CRIMINALBACKGROUNDDATE3 TIMESTAMP_NTZ(9),
	CRIMINALBACKGROUNDRESULT3 VARCHAR(16),
	CRIMINALBACKGROUNDRECEIVEDDATE3 TIMESTAMP_NTZ(9),
	LASTEMPLOYMENTAGENCY VARCHAR(100),
	LASTEMPLOYMENTSTARTDATE TIMESTAMP_NTZ(9),
	LASTEMPLOYMENTENDDATE TIMESTAMP_NTZ(9),
	PROFESSIONALLICENSENUMBER VARCHAR(50),
	LICENSEDATEVERIFIED TIMESTAMP_NTZ(9),
	PROFESSIONALREGISTRATIONEXPIRATIONDATE TIMESTAMP_NTZ(9),
	AUTOMOBILEINSURANCEEXPIRATIONDATE TIMESTAMP_NTZ(9),
	NOCAR VARCHAR(1),
	MALPRACTICEINSURANCEEXPIRATIONDATE TIMESTAMP_NTZ(9),
	CPRVERIFIEDON TIMESTAMP_NTZ(9),
	PICCCERTIFICATIONDATEVERIFIED TIMESTAMP_NTZ(9),
	NPINUMBER VARCHAR(50),
	LANGUAGE1 NUMBER(10,0),
	LANGUAGE2 NUMBER(10,0),
	LANGUAGE3 NUMBER(10,0),
	LANGUAGE4 NUMBER(10,0),
	OTHER VARCHAR(250),
	COCODE VARCHAR(50),
	FEDEXEMPTION VARCHAR(50),
	RATETYPE VARCHAR(50),
	PENSIONPROFITSHARING VARCHAR(1),
	EXEMPTIONFROMOVERTIME VARCHAR(1),
	DIRECTDEPOSIT VARCHAR(1),
	NYCRESIDENT VARCHAR(1),
	EMPLOYEE1099 VARCHAR(1),
	UNIONREDUCTION VARCHAR(1),
	MEDICALDEDUCTIONCODE VARCHAR(50),
	PAYCYCLE VARCHAR(9),
	OFFICEID NUMBER(10,0),
	MODIFIEDDATE TIMESTAMP_NTZ(9),
	UNIQUEMOBILEID NUMBER(10,0),
	UNIQUEMOBILETYPE NUMBER(5,0),
	BRANCHNAME VARCHAR(200),
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