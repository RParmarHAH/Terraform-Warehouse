CREATE OR REPLACE TABLE DISC_PROD.HEALTH_NAVIGATOR.RECOMMENDATION_2__C (
	ID VARCHAR(18),
	REASON_CATEGORY__C VARCHAR(100),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	DATE__C DATE,
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	RESPONSE__C VARCHAR(255),
	CLIENT__C VARCHAR(18),
	CODE__C VARCHAR(25),
	NAME VARCHAR(80),
	CREATEDBYID VARCHAR(18),
	OWNERID VARCHAR(18),
	REASON__C VARCHAR(18),
	REASON_SUB_TYPE__C VARCHAR(255),
	RIM_MAPPING__C VARCHAR(131072),
	QUESTION__C VARCHAR(255),
	ISDELETED BOOLEAN,
	ALERT__C VARCHAR(255),
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	INTERVENTION_SUB_TYPE__C VARCHAR(255),
	REASON_INTERVENTION__C VARCHAR(18),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	CREATEDDATE TIMESTAMP_NTZ(9),
	REASON_TYPE__C VARCHAR(100),
	INTERVENTION_TYPE__C VARCHAR(255),
	STATUS__C VARCHAR(255),
	LASTMODIFIEDBYID VARCHAR(18)
);