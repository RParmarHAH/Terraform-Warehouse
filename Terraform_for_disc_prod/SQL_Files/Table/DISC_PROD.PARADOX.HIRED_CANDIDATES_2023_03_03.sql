CREATE OR REPLACE TABLE DISC_PROD.PARADOX.HIRED_CANDIDATES_2023_03_03 (
	CANDIDATE_ID NUMBER(16,0),
	"First Name" VARCHAR(255),
	"Middle Name" VARCHAR(255),
	"Last Name" VARCHAR(255),
	"Social Security Number" VARCHAR(255),
	"Date of Birth" VARCHAR(255),
	"Email" VARCHAR(255),
	"Time zone" VARCHAR(16777216),
	"Address" VARCHAR(255),
	"Address Line 2" VARCHAR(255),
	"City" VARCHAR(255),
	"County" VARCHAR(16777216),
	"State" VARCHAR(765),
	"Zip Code" VARCHAR(255),
	COUNTRY VARCHAR(40),
	"Branch (Group)" VARCHAR(100),
	"Branch STATE" VARCHAR(15),
	"Phone" VARCHAR(255),
	"Home Phone" VARCHAR(255),
	"Gender" VARCHAR(255),
	"AlayaCare Group ID" NUMBER(38,0),
	"AlayaCare Cost Center ID" NUMBER(38,0),
	"Position/Job" VARCHAR(100),
	"AlayaCare Admin Role ID" NUMBER(38,0),
	"AlayaCare Field Role Portal ID" NUMBER(38,0),
	"HAH office number" NUMBER(38,0),
	CREATED_DATE TIMESTAMP_NTZ(9),
	UPDATED_DATE TIMESTAMP_NTZ(9)
);