CREATE OR REPLACE TABLE DISC_PROD.HEALTH_NAVIGATOR.TRIGGER_REASON__C (
	ID VARCHAR(18),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	ISDELETED BOOLEAN,
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	NAME VARCHAR(80),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	CREATEDBYID VARCHAR(18),
	OWNERID VARCHAR(18),
	CREATEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBYID VARCHAR(18),
	ACTIVE__C BOOLEAN,
	REASON_STATUS__C VARCHAR(255),
	REASON_SUB_TYPE__C VARCHAR(255)
);