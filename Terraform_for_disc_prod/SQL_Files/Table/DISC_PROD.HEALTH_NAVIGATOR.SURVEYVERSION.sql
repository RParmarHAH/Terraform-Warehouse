CREATE OR REPLACE TABLE DISC_PROD.HEALTH_NAVIGATOR.SURVEYVERSION (
	ID VARCHAR(18),
	BRANDINGSETID VARCHAR(18),
	ISTEMPLATE BOOLEAN,
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	ISDELETED BOOLEAN,
	DESCRIPTION VARCHAR(65535),
	SURVEYID VARCHAR(18),
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	VERSIONNUMBER NUMBER(9,0),
	NAME VARCHAR(255),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	CREATEDBYID VARCHAR(18),
	SURVEYSTATUS VARCHAR(255),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBYID VARCHAR(18)
);