CREATE OR REPLACE TABLE DISC_PROD.RISKONNECT.HIERARCHY_NODE (
	ID VARCHAR(50),
	OWNERID VARCHAR(100),
	ISDELETED BOOLEAN,
	NAME VARCHAR(100),
	CREATEDDATE TIMESTAMP_NTZ(9),
	CREATEDBYID VARCHAR(50),
	LASTMODIFIEDDATE TIMESTAMP_NTZ(9),
	LASTMODIFIEDBYID VARCHAR(50),
	SYSTEMMODSTAMP TIMESTAMP_NTZ(9),
	LASTACTIVITYDATE TIMESTAMP_NTZ(9),
	LASTVIEWEDDATE TIMESTAMP_NTZ(9),
	LASTREFERENCEDDATE TIMESTAMP_NTZ(9),
	CONNECTIONRECEIVEDID VARCHAR(50),
	CONNECTIONSENTID VARCHAR(50),
	ACTIVE__C BOOLEAN,
	ADDRESS_LINE1__C VARCHAR(100),
	ADDRESS_LINE2__C VARCHAR(100),
	CITY__C VARCHAR(50),
	COUNTRY__C VARCHAR(50),
	DATE_ACTIVE__C DATE,
	DATE_INACTIVE__C DATE,
	DATE_LOCATION_CLOSED__C DATE,
	DATE_LOCATION_OPENED__C DATE,
	DATE_PARENT_RELATIONSHIP_EFFECTIVE__C DATE,
	ID_PRIOR__C VARCHAR(50),
	LATITUDE__C VARCHAR(10),
	LOCATION_10_CODE__C VARCHAR(100),
	LOCATION_10_NAME__C VARCHAR(100),
	LOCATION_10_NODE__C VARCHAR(100),
	LOCATION_1_CODE__C VARCHAR(100),
	LOCATION_1_NAME__C VARCHAR(100),
	LOCATION_1_NODE__C VARCHAR(100),
	LOCATION_2_CODE__C VARCHAR(100),
	LOCATION_2_NAME__C VARCHAR(100),
	LOCATION_2_NODE__C VARCHAR(100),
	LOCATION_3_CODE__C VARCHAR(100),
	LOCATION_3_NAME__C VARCHAR(100),
	LOCATION_3_NODE__C VARCHAR(100),
	LOCATION_4_CODE__C VARCHAR(100),
	LOCATION_4_NAME__C VARCHAR(100),
	LOCATION_4_NODE__C VARCHAR(100),
	LOCATION_5_CODE__C VARCHAR(100),
	LOCATION_5_NAME__C VARCHAR(100),
	LOCATION_5_NODE__C VARCHAR(100),
	LOCATION_6_CODE__C VARCHAR(100),
	LOCATION_6_NAME__C VARCHAR(100),
	LOCATION_6_NODE__C VARCHAR(100),
	LOCATION_7_CODE__C VARCHAR(100),
	LOCATION_7_NAME__C VARCHAR(100),
	LOCATION_7_NODE__C VARCHAR(100),
	LOCATION_8_CODE__C VARCHAR(100),
	LOCATION_8_NAME__C VARCHAR(100),
	LOCATION_8_NODE__C VARCHAR(100),
	LOCATION_9_CODE__C VARCHAR(100),
	LOCATION_9_NAME__C VARCHAR(100),
	LOCATION_9_NODE__C VARCHAR(100),
	LONGITUDE__C VARCHAR(10),
	NODE_CODE__C VARCHAR(100),
	NODE_KEY__C VARCHAR(100),
	NODE_LEVEL__C NUMBER(18,2),
	NODE_NAME__C VARCHAR(100),
	NUMBER_OF_OFFSET_LEVELS__C NUMBER(18,2),
	PARENT_CODE_FORMULA__C VARCHAR(100),
	PARENT_LEVEL_FORMULA__C NUMBER(18,2),
	PARENT_NAME__C VARCHAR(100),
	PARENT_NODE_KEY__C VARCHAR(100),
	PARENT_NODE__C VARCHAR(100),
	PARENT_SIC_OR_NAICS_CODE__C VARCHAR(100),
	PERMIT_CLAIMS__C VARCHAR(10),
	POSTAL_CODE__C VARCHAR(10),
	PRIMARY_CONTACT__C VARCHAR(100),
	SIC_OR_NAICS_NODE_CODE__C VARCHAR(50),
	STATE__C VARCHAR(10),
	IS_LEAF__C BOOLEAN,
	LABOR_HOURS__C NUMBER(18,2),
	SALES__C NUMBER(18,2),
	PAYROLL__C NUMBER(18,2),
	HEADCOUNT__C NUMBER(18,2),
	MILES_DRIVEN__C NUMBER(18,2),
	PROPERTY_COLLECTION_STATUS__C VARCHAR(100),
	EXPOSURE_SUMMARY_1__C NUMBER(18,2),
	EXPOSURE_SUMMARY_2__C NUMBER(18,2),
	EXPOSURE_SUMMARY_3__C NUMBER(18,2),
	EXPOSURE_SUMMARY_4__C NUMBER(18,2),
	EXPOSURE_SUMMARY_5__C NUMBER(18,2),
	RK_TEST_ROLLUP__C NUMBER(18,2),
	SEARCH_LOCATION__C VARCHAR(100),
	AE_REVIEWER_1__C VARCHAR(50),
	PRIMARY_LOCATION_INDICATOR__C BOOLEAN,
	LOCATION_LEVEL_NAME__C VARCHAR(100),
	OFFICE_MANAGER__C VARCHAR(100),
	PHONE__C VARCHAR(100),
	FAX__C VARCHAR(100),
	RK_SHARE_GROUP_1__C VARCHAR(10),
	CODE_LOSSES_TO_THIS_LOCATION__C VARCHAR(10),
	TAX_ID__C VARCHAR(50),
	CLS_DD_MANAGER_PHONE__C VARCHAR(100),
	CLS_DD_MANAGER_EMAIL__C VARCHAR(100),
	TOTAL_ANNUAL_HOURS__C NUMBER(18,2),
	CLS_DD_MANAGER__C VARCHAR(100),
	SKILLED_MANAGER__C VARCHAR(100),
	TOTAL_ANNUAL_VISITS__C NUMBER(18,2),
	PROPERTY__C VARCHAR(50),
	TOTAL_ANNUAL_PAYROLL__C NUMBER(18,2),
	RK_SHARE_GROUP_2__C VARCHAR(50),
	TOTAL_EMPLOYEE_COUNT__C NUMBER(18,2),
	RK_SHARE_GROUP__C VARCHAR(50),
	RENEWAL_CONTACT__C VARCHAR(100),
	SKILLED_MANAGER_PHONE__C VARCHAR(100),
	REGION__C VARCHAR(100),
	RENEWAL_USER__C VARCHAR(10),
	SKILLED_MANAGER_EMAIL__C VARCHAR(100),
	HIERARCHY_NOTES__C VARCHAR(100),
	CLEAN_UP__C BOOLEAN,
	CHANGE_REASON__C VARCHAR(500),
	UNION_BRANCH__C VARCHAR(100),
	SUPERVISOR_HEADCOUNT__C NUMBER(10,2),
	ETL_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_TASK_KEY NUMBER(6,0),
	ETL_INSERTED_DATE TIMESTAMP_NTZ(9),
	ETL_INSERTED_BY VARCHAR(16777216),
	ETL_LAST_UPDATED_DATE TIMESTAMP_NTZ(9),
	ETL_LAST_UPDATED_BY VARCHAR(16777216),
	ETL_DELETED_FLAG NUMBER(1,0)
);