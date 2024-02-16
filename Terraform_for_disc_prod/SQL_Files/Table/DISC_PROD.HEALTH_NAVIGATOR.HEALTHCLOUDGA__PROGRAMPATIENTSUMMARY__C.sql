CREATE OR REPLACE TABLE DISC_PROD.HEALTH_NAVIGATOR.HEALTHCLOUDGA__PROGRAMPATIENTSUMMARY__C (
	ID VARCHAR(18),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	HEALTHCLOUDGA__RISKSCORE__C NUMBER(8,3),
	HEALTHCLOUDGA__NEWPATIENT__C BOOLEAN,
	HEALTHCLOUDGA__NUMBEROFCONDITIONS__C VARCHAR(3),
	HEALTHCLOUDGA__ACCOUNT__C VARCHAR(18),
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	HEALTHCLOUDGA__PROGRAMPATIENTAFFILIATION__C VARCHAR(18),
	HEALTHCLOUDGA__ENROLLMENTTYPE__C VARCHAR(255),
	HEALTHCLOUDGA__UNIQUE__C VARCHAR(1300),
	NAME VARCHAR(80),
	HEALTHCLOUDGA__EFFECTIVEDATE__C DATE,
	CREATEDBYID VARCHAR(18),
	OWNERID VARCHAR(18),
	HEALTHCLOUDGA__MOSTRECENT__C BOOLEAN,
	RECORDTYPEID VARCHAR(18),
	HEALTHCLOUDGA__AGE__C NUMBER(3,0),
	HEALTHCLOUDGA__MONTH__C VARCHAR(2),
	ISDELETED BOOLEAN,
	HEALTHCLOUDGA__TIMESPENT__C NUMBER(4,0),
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	HEALTHCLOUDGA__HCCCODES__C VARCHAR(255),
	HEALTHCLOUDGA__INSTITUTION__C BOOLEAN,
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	HEALTHCLOUDGA__STAGE__C VARCHAR(255),
	HEALTHCLOUDGA__GENDER__C VARCHAR(255),
	HEALTHCLOUDGA__AGEBAND__C VARCHAR(1300),
	HEALTHCLOUDGA__LOWINCOME__C BOOLEAN,
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTACTIVITYDATE DATE,
	HEALTHCLOUDGA__CONDITIONS__C VARCHAR(131072),
	HEALTHCLOUDGA__DISABILITYSTATUS__C BOOLEAN,
	LASTMODIFIEDBYID VARCHAR(18),
	HEALTHCLOUDGA__YEAR__C VARCHAR(4)
);