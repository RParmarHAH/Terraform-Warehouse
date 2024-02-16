CREATE OR REPLACE TABLE DISC_PROD.RISKONNECT.POLICY (
	ID VARCHAR(50),
	OWNERID VARCHAR(50),
	ISDELETED BOOLEAN,
	NAME VARCHAR(50),
	RECORDTYPEID VARCHAR(50),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDBYID VARCHAR(50),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBYID VARCHAR(50),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	LASTACTIVITYDATE TIMESTAMP_NTZ(9),
	BROKER_COMMISSION_PERCENT__C NUMBER(38,2),
	BROKER_COMPENSATION_TYPE__C VARCHAR(20),
	BROKER_FEE__C NUMBER(38,2),
	BROKER__C VARCHAR(50),
	CARRIER_COVERAGE__C VARCHAR(50),
	CARRIER__C VARCHAR(50),
	COVERAGE_LINE__C VARCHAR(50),
	DATE_EXCESS_CARRIER_NOTIFIED__C DATE,
	DATE_POLICY_CANCELED__C DATE,
	DATE_POLICY_EFFECTIVE__C DATE,
	DATE_POLICY_EXPIRATION__C DATE,
	EXCESS_POLICY__C VARCHAR(50),
	EXCISE_FEES__C NUMBER(38,2),
	FRONTING_FEES__C NUMBER(38,2),
	GROSS_PREMIUM__C VARCHAR(50),
	HIERARCHY_LEVEL__C VARCHAR(50),
	ID_PRIOR__C VARCHAR(50),
	LAYER_NUMBER__C VARCHAR(50),
	NAMED_INSURED_ADDRESS__C VARCHAR(50),
	NAMED_INSURED__C VARCHAR(50),
	NET_PREMIUM__C NUMBER(38,2),
	NOTIFY_EXCESS_CARRIER__C BOOLEAN,
	OCCURRENCE_ATTACHMENT_POINT__C VARCHAR(50),
	OTHER_FEES__C NUMBER(38,2),
	POLICY_AGGREGATE_LIMIT__C NUMBER(38,2),
	POLICY_BASIS__C VARCHAR(50),
	POLICY_DESCRIPTION__C VARCHAR(500),
	POLICY_DOCUMENT__C VARCHAR(5000),
	POLICY_OCCURRENCE_LIMIT__C NUMBER(38,0),
	POLICY_TYPE__C VARCHAR(50),
	PRIMARY__C BOOLEAN,
	PRO_RATA_SHARE__C VARCHAR(50),
	PRODUCER__C VARCHAR(50),
	RENEWAL_POLICY__C VARCHAR(50),
	RETENTION_AMOUNT__C NUMBER(38,0),
	RETENTION_TYPE__C VARCHAR(50),
	SURPLUS_FEES__C NUMBER(38,0),
	TAX__C NUMBER(38,0),
	BROKER_PAID__C NUMBER(38,0),
	FEES_PAID__C NUMBER(38,0),
	GROSS_PREMIUM_PAID__C NUMBER(38,0),
	NET_PREMIUM_PAID__C NUMBER(38,0),
	TAXES_PAID__C NUMBER(38,0),
	CARRIER_RATING_LOOKUP__C VARCHAR(50),
	POLICY_DETAILS__C VARCHAR(50),
	TPA__C VARCHAR(50),
	RECORD__C VARCHAR(50),
	COVERAGES__C VARCHAR(50),
	COMP_DEDUCTIBLE__C NUMBER(38,0),
	COLLISON_DEDUCTIBLE__C NUMBER(38,0),
	LIABILITY_DEDUCTIBLE__C NUMBER(38,0),
	ETL_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_TASK_KEY NUMBER(38,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);