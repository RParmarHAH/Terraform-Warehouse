CREATE OR REPLACE TABLE DW_PROD.HAH.AMS_PARADOX_BRANCH_MAPPING_TEST (
	BRANCH_KEY VARCHAR(50),
	ORIGINAL_SOURCE_SYSTEM_ID NUMBER(38,0),
	AMS_PARENT_SYSTEM_CODE VARCHAR(52),
	AMS_SYSTEM_CODE VARCHAR(50),
	CANDIDATE_LOCATION__LEVEL_1 VARCHAR(100),
	CANDIDATE_LOCATION__LEVEL_2 VARCHAR(100),
	CANDIDATE_LOCATION__LEVEL_3 VARCHAR(100),
	ORIGINAL_BRANCH_NAME VARCHAR(50),
	OFFICE_STATE_CODE VARCHAR(50)
);