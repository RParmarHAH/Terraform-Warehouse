CREATE OR REPLACE TABLE DISC_PROD.HHAEXCHANGEPREFERRED.ZIPCODES (
	ZIP FLOAT,
	F2 VARCHAR(255),
	TYPE VARCHAR(255),
	DECOMMISSIONED FLOAT,
	PRIMARY_CITY VARCHAR(255),
	ACCEPTABLE_CITIES VARCHAR(255),
	UNACCEPTABLE_CITIES VARCHAR(16777216),
	STATE VARCHAR(255),
	COUNTY VARCHAR(255),
	TIMEZONE VARCHAR(255),
	AREA_CODES FLOAT,
	WORLD_REGION VARCHAR(255),
	COUNTRY VARCHAR(255),
	LATITUDE FLOAT,
	LONGITUDE FLOAT,
	IRS_ESTIMATED_POPULATION_2015 FLOAT,
	EMAILS VARCHAR(200),
	COUNTYNAME VARCHAR(50),
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