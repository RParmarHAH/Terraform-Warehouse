CREATE OR REPLACE TABLE DISC_PROD.HEALTH_NAVIGATOR.ALLERGYINTOLERANCE (
	ID VARCHAR(18),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	VERIFICATIONSTATUS VARCHAR(40),
	CATEGORY VARCHAR(4099),
	ALLERGY_INTOLERANCE_DETAILS__C VARCHAR(255),
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	NAME VARCHAR(255),
	ONSETENDDATETIME TIMESTAMP_NTZ(9),
	SL_EXTERNAL_ID__C VARCHAR(255),
	CREATEDBYID VARCHAR(18),
	OWNERID VARCHAR(18),
	RECORDCREATORID VARCHAR(18),
	SOURCESYSTEMIDENTIFIER VARCHAR(255),
	ASSERTIONSOURCEID VARCHAR(18),
	CODEID VARCHAR(18),
	PATIENTID VARCHAR(18),
	CLINICALENCOUNTERID VARCHAR(18),
	SOURCESYSTEMMODIFIED TIMESTAMP_NTZ(9),
	STATUS VARCHAR(40),
	ISDELETED BOOLEAN,
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	SEVERITY VARCHAR(40),
	LASTOCCURRENCEDATETIME TIMESTAMP_NTZ(9),
	RECORDCREATIONDATETIME TIMESTAMP_NTZ(9),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	TYPE VARCHAR(40),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBYID VARCHAR(18),
	ONSETSTARTDATETIME TIMESTAMP_NTZ(9),
	SOURCESYSTEM VARCHAR(64)
);