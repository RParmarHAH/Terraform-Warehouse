CREATE OR REPLACE TABLE DISC_PROD.DATA_CLEANSING.EMPLOYEE_STG_STANDARDIZED_ADDRESSES_TEST (
	SOURCE_SYSTEM_ID VARCHAR(16777216) NOT NULL,
	SYSTEM_CODE VARCHAR(16777216) NOT NULL,
	EMPLOYEE_NUMBER VARCHAR(16777216) NOT NULL,
	FIRST_NAME VARCHAR(16777216) COMMENT 'First name of employee',
	LAST_NAME VARCHAR(16777216) COMMENT 'Last name of employee',
	ADDRESS VARCHAR(16777216) COMMENT 'Address',
	CITY VARCHAR(16777216) COMMENT 'City',
	STATE VARCHAR(16777216) COMMENT 'State',
	ZIP VARCHAR(16777216) COMMENT 'Zip (5 digits)',
	POINTS VARCHAR(16777216) COMMENT '[lat,long] format of the coordinates',
	LATITUDE FLOAT COMMENT 'Latitude',
	LONGITUDE FLOAT COMMENT 'Longitude',
	LABEL VARCHAR(16777216) COMMENT 'Address label which does not include the secondary unit designator',
	ADDRESS_NUMBER VARCHAR(16777216) COMMENT 'The street address number',
	STREET VARCHAR(16777216) COMMENT 'Street address which includes the secondary unit designator',
	MUNICIPALITY VARCHAR(16777216) COMMENT 'Municipality - several counties or geographies can make up a municipality',
	REGION VARCHAR(16777216),
	SUB_REGION VARCHAR(16777216) COMMENT 'County designation in 48 states except Alaska - boroughs or Louisiana - parishes or District of Columbia',
	COUNTRY_CODE VARCHAR(16777216) COMMENT 'Country code - USA',
	ZIPCODE VARCHAR(16777216) COMMENT '5 digits ZIP code',
	PLUS_FOUR_CODE VARCHAR(16777216) COMMENT '4 digits ZIP code extension'
);