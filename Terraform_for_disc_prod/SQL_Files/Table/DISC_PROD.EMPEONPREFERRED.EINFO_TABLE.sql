CREATE OR REPLACE TABLE DISC_PROD.EMPEONPREFERRED.EINFO_TABLE (
	CO VARCHAR(10),
	ID VARCHAR(10),
	LASTNAME VARCHAR(40),
	FIRSTNAME VARCHAR(40),
	MIDDLENAME VARCHAR(20),
	ADDRESS1 VARCHAR(50),
	ADDRESS2 VARCHAR(50),
	CITY VARCHAR(30),
	STATE VARCHAR(20),
	ZIP VARCHAR(10),
	COUNTY VARCHAR(30),
	COUNTRY VARCHAR(30),
	SSN VARCHAR(11),
	BIRTHDATE TIMESTAMP_NTZ(9),
	SEX VARCHAR(1),
	PAYGROUP VARCHAR(10),
	HIREDATE TIMESTAMP_NTZ(9),
	REHIREDATE TIMESTAMP_NTZ(9),
	ADJSENIORITYDATE TIMESTAMP_NTZ(9),
	TERMDATE TIMESTAMP_NTZ(9),
	NEWHIREREPORTDATE TIMESTAMP_NTZ(9),
	CC VARCHAR(54),
	CC1 VARCHAR(10),
	CC2 VARCHAR(10),
	CC3 VARCHAR(10),
	CC4 VARCHAR(10),
	CC5 VARCHAR(10),
	WCC VARCHAR(10),
	CLOCK VARCHAR(10),
	PAYGRADE VARCHAR(10),
	BASERATE NUMBER(14,6),
	RATEPER VARCHAR(10),
	SALARY NUMBER(14,2),
	DEFAULTHOURS NUMBER(14,6),
	PAYFREQUENCY VARCHAR(10),
	ANNUALSALARY NUMBER(14,2),
	AUTOPAY VARCHAR(10),
	JOBCODE VARCHAR(20),
	TIPPED VARCHAR(5),
	GUIDFIELD VARCHAR(36),
	LASTCHANGE TIMESTAMP_NTZ(9),
	LASTCHANGEUSER VARCHAR(50),
	PASSWORD VARCHAR(50),
	SALUTATION VARCHAR(10),
	SURNAME VARCHAR(10),
	NICKNAME VARCHAR(50),
	PRIORLASTNAME VARCHAR(30),
	HOMEPHONE VARCHAR(20),
	ETHNICITY VARCHAR(10),
	MARITALSTATUS VARCHAR(10),
	DISABILITYDESC VARCHAR(50),
	VETERANDESC VARCHAR(50),
	SMOKER BOOLEAN,
	POSITIONCODE VARCHAR(20),
	POSITIONINFOLOCKED BOOLEAN,
	TITLE VARCHAR(50),
	EEOCLASS VARCHAR(10),
	FLSAOTEXEMPT BOOLEAN,
	WORKPHONE VARCHAR(20),
	WORKPHONEEXT VARCHAR(10),
	MAILSTOP VARCHAR(10),
	EMAILADDRESS VARCHAR(50),
	TAXFORM VARCHAR(10),
	PENSION BOOLEAN,
	STATUTORY BOOLEAN,
	DECEASED BOOLEAN,
	DEFERREDCOMP BOOLEAN,
	LEGALREP BOOLEAN,
	DOMESTICEMPL BOOLEAN,
	SEASONAL BOOLEAN,
	I9VERIFIED BOOLEAN,
	I9REVERIFY TIMESTAMP_NTZ(9),
	CITIZENSHIP VARCHAR(30),
	VISATYPE VARCHAR(10),
	VISAEXPIRATION TIMESTAMP_NTZ(9),
	UNIONCODE VARCHAR(10),
	UNIONDATE TIMESTAMP_NTZ(9),
	UNIONINITFEES BOOLEAN,
	UNIONDUES BOOLEAN,
	SUPERVISORID VARCHAR(10),
	SUPERVISORNAME VARCHAR(30),
	LASTRAISEDATE TIMESTAMP_NTZ(9),
	LASTRAISEAMOUNT NUMBER(14,6),
	LASTRAISEREASON VARCHAR(10),
	NEXTRAISEDATE TIMESTAMP_NTZ(9),
	LASTREVIEWDATE TIMESTAMP_NTZ(9),
	LASTREVIEWRATING VARCHAR(10),
	NEXTREVIEWDATE TIMESTAMP_NTZ(9),
	USER1 VARCHAR(50),
	USER2 VARCHAR(50),
	USER3 VARCHAR(50),
	USER4 VARCHAR(50),
	USER5 VARCHAR(50),
	USER6 VARCHAR(50),
	USER7 VARCHAR(50),
	USER8 VARCHAR(50),
	MISCCHECK1 BOOLEAN,
	MISCCHECK2 BOOLEAN,
	MISCCHECK3 BOOLEAN,
	MISCCHECK4 BOOLEAN,
	MISCCHECK5 BOOLEAN,
	EE401KDEFERRAL NUMBER(14,6),
	EE401KCALC VARCHAR(10),
	EE401KCONTINUE BOOLEAN,
	EE401KELIGIBLEDATE TIMESTAMP_NTZ(9),
	EE401KSTATUS VARCHAR(20),
	EE401KSUSPENDDATE TIMESTAMP_NTZ(9),
	ER401KMATCH NUMBER(14,6),
	HIGHCOMP BOOLEAN,
	OWNER BOOLEAN,
	OWNERPERCENT NUMBER(3,0),
	OWNERRELATED BOOLEAN,
	OWNERSSN VARCHAR(11),
	MEMO VARCHAR(4000),
	SHOWMEMO BOOLEAN,
	NEWHIRECALENDARID VARCHAR(36),
	NEWHIRESB NUMBER(3,0),
	WORKSTATE VARCHAR(5),
	OFFICER BOOLEAN,
	WAGETYPE VARCHAR(1),
	FAMILY BOOLEAN,
	PROBATION BOOLEAN,
	DISTRIBUTIONCODES VARCHAR(128),
	CELLPHONE VARCHAR(20),
	MASTERRECORDFORACA BOOLEAN,
	CMSPBJID VARCHAR(21),
	ADDRESSNOTES VARCHAR(4000),
	CONTACTNOTES VARCHAR(4000),
	DEMOGRAPHICNOTES VARCHAR(4000),
	FACEBOOK VARCHAR(50),
	FILESTORAGEUSED NUMBER(18,2),
	JOBCATEGORY VARCHAR(50),
	JOBNOTES VARCHAR(4000),
	LANGUAGESSPOKEN VARCHAR(4000),
	LINKEDIN VARCHAR(50),
	SKYPE VARCHAR(50),
	TWITTERUSERNAME VARCHAR(50),
	ESSACCOUNTCREATED BOOLEAN,
	NEWHIREHANDLED BOOLEAN,
	ISPBJ BOOLEAN,
	ISMANAGER BOOLEAN,
	PROFILEIMG VARCHAR(50),
	FULLNAME VARCHAR(103),
	UNIONDEDAUTH BOOLEAN,
	TIMEZONEID VARCHAR(50),
	CLOCKCARDNO VARCHAR(100),
	CLOCKFILTER VARCHAR(200),
	CLOCKMANAGER BOOLEAN,
	CLOCKPW VARCHAR(25),
	LEGACYELIGIBLEFORREHIRE BOOLEAN,
	LEGACYEMPSTATUS VARCHAR(20),
	LEGACYEMPTYPE VARCHAR(10),
	LEGACYTERMREASON VARCHAR(10),
	TERMREASON VARCHAR(1),
	EMPTYPE VARCHAR(1),
	EMPSTATUS VARCHAR(1),
	ELIGIBLEFORREHIRE VARCHAR(1),
	PAYTOSCHEDULE BOOLEAN,
	ATTENDANCEEXCLUDED BOOLEAN,
	WEBCLOCK BOOLEAN,
	ONBOARDINGID NUMBER(10,0),
	PBJEMPID VARCHAR(10),
	PBJEMPTYPE VARCHAR(10),
	ALLOWMISSINGPUNCH BOOLEAN,
	WORKAUTHORIZATIONSTATUS VARCHAR(200),
	WORKEMAIL VARCHAR(50),
	FIRSTPAYDATE TIMESTAMP_NTZ(9),
	LASTPAYDATE TIMESTAMP_NTZ(9),
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