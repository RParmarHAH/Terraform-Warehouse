CREATE OR REPLACE TABLE DISC_PROD.HEALTH_NAVIGATOR.ASSESSMENTQUESTIONRESPONSE (
	ID VARCHAR(18),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	QUESTION_TEXT__C VARCHAR(1300),
	PARENTASMTQUESTIONVERSIONID VARCHAR(18),
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	ISTRUEORFALSEVALUE BOOLEAN,
	NAME VARCHAR(255),
	CREATEDBYID VARCHAR(18),
	OWNERID VARCHAR(18),
	DATEVALUE DATE,
	RESPONSEVALUE VARCHAR(32000),
	DECIMALRESPONSEVALUE NUMBER(12,2),
	TIMEVALUE VARCHAR(16777216),
	ISDELETED BOOLEAN,
	DATETIMEVALUE TIMESTAMP_NTZ(9),
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	RESPONDENTTIMEZONE VARCHAR(255),
	RESPONSETYPE VARCHAR(50),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	ASSESSMENTQUESTIONID VARCHAR(18),
	CHOICEVALUE VARCHAR(1000),
	CURRENCYVALUE NUMBER(18,0),
	ASSESSMENTID VARCHAR(18),
	CREATEDDATE TIMESTAMP_NTZ(9),
	RESPONSETEXT VARCHAR(32000),
	INTEGERRESPONSEVALUE NUMBER(9,0),
	LASTMODIFIEDBYID VARCHAR(18)
);