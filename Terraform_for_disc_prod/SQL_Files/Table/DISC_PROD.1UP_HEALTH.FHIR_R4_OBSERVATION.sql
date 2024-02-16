create or replace TABLE DISC_PROD."1UP_HEALTH".FHIR_R4_OBSERVATION (
	OBSERVATION_ONEUP_KEY VARCHAR(16777216),
	PATIENT_ONEUP_KEY VARCHAR(16777216),
	ENCOUNTER_ONEUP_KEY VARCHAR(16777216),
	OBSERVATIONDATE TIMESTAMP_NTZ(9),
	OBSERVATIONPUBLISHEDDATE TIMESTAMP_NTZ(9),
	OBSERVATIONSTATUS VARCHAR(16777216),
	IDENTIFIER VARCHAR(16777216),
	OBSERVATION_ID VARCHAR(16777216),
	OBSERVATIONPRIMARYID VARCHAR(16777216),
	LOINCCODE VARCHAR(16777216),
	LOINCCODEDESCRIPTION VARCHAR(16777216),
	SNOMEDCTCODE VARCHAR(16777216),
	SNOMEDCTCODEDESCRIPTION VARCHAR(16777216),
	OTHEROBSERVATIONSYSTEMNAME VARCHAR(16777216),
	OTHEROBSERVATIONCODE VARCHAR(16777216),
	OTHEROBSERVATIONCODEDESCRIPTION VARCHAR(16777216),
	OBSERVATIONCODETEXT VARCHAR(16777216),
	OBSERVATION_INTERPRETATIONCODE VARCHAR(16777216),
	OBSERVATION_INTERPRETATIONDESCRIPTION VARCHAR(16777216),
	OBSERVATION_UNIT VARCHAR(16777216),
	OBSERVATION_VALUE VARCHAR(16777216),
	OBSERVATION_METHODCODE VARCHAR(16777216),
	METHODDESCRIPTION VARCHAR(16777216),
	OBSERVATION_VALUE_RANGE VARCHAR(16777216),
	OBSERVATION_VALUE_RANGE_UNIT VARCHAR(16777216),
	OBSERVATION_VALUE_RANGE_VALUE VARCHAR(16777216),
	PERFORMEDBY VARCHAR(16777216),
	METAEVENTTYPE VARCHAR(16777216),
	METAMESSAGETYPE VARCHAR(16777216),
	METAEVENTTIMESTAMP TIMESTAMP_NTZ(9),
	METAPROCESSTIMESTAMP TIMESTAMP_NTZ(9),
	METASOURCERECORDID VARCHAR(16777216),
	METAPROCESSCLIENTID VARCHAR(16777216),
	METALASTUPDATED TIMESTAMP_NTZ(9),
	METASOURCE VARCHAR(16777216),
	FILENAME VARCHAR(16777216),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216)
);