resource "snowflake_view" "DW_REPORT_VW_GATOR_CLIENT_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_GATOR_CLIENT_MAPPING"
	statement = <<-SQL
	 ------------------------------------------------------------------------------------------------------------------------------
/*
Object Type : 	View
Object Name	: 	VW_GATOR_CLIENT_MAPPING_2
Author		:	Mohit Vaghadiya
Description :
	- Interim Solution to Map CC Client Key From Gator with DW Client Key
*/
--*****************************************************************************************************************************
-- CHANGE LOG :
-- Version	Date(MM/DD/YYYY)	Author				Change Description
-- --------	----------------   	------------------	---------------------------------------------------------------------------
-- 1.0		09/08/2023   		Mohit Vaghadiya		Initial development
-- 1.1		09/19/2023   		Mohit Vaghadiya		Added Gator Account ID Field
-------------------------------------------------------------------------------------------------------------------------------
WITH CLIENT_LIST AS
(
	SELECT DISTINCT GATOR_CLIENT.ID AS ACCOUNT_ID
					, LEFT(GATOR_CLIENT.HEALTHCLOUDGA__SOURCESYSTEMID__C, 32) AS GATOR_CLIENT_KEY
					, NVL(DW_CLIENT.CLIENT_KEY, LEFT(GATOR_CLIENT.HEALTHCLOUDGA__SOURCESYSTEMID__C, 32)) AS DW_CLIENT_KEY
					, NVL(DW_CLIENT.CLIENT_FIRST_NAME,  GATOR_CLIENT.FIRSTNAME) AS CLIENT_FIRST_NAME 
					, NVL(DW_CLIENT.CLIENT_LAST_NAME, GATOR_CLIENT.LASTNAME ) AS CLIENT_LAST_NAME
	FROM DISC_${var.SF_ENVIRONMENT}.HEALTH_NAVIGATOR.ACCOUNT GATOR_CLIENT
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.HEALTH_NAVIGATOR.RECORDTYPE RECORD_TYPE
		ON RECORD_TYPE.ID = GATOR_CLIENT.RECORDTYPEID
			AND RECORD_TYPE.NAME = 'Client'
	LEFT JOIN APP_DB_${var.SF_ENVIRONMENT}.CARE_COORDINATION.CLIENT_MATCH_LIST CLIENT_MATCH 
		ON LEFT(GATOR_CLIENT.HEALTHCLOUDGA__SOURCESYSTEMID__C, 32) = CLIENT_MATCH.GATOR_CLIENT_KEY
			AND CLIENT_MATCH.ORIGINAL_SOURCE = 'DW'
	LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED DW_CLIENT
		ON DW_CLIENT.ORIGINAL_CLIENT_KEY = NVL(CLIENT_MATCH.DW_CLIENT_KEY
										 , LEFT(GATOR_CLIENT.HEALTHCLOUDGA__SOURCESYSTEMID__C, 32))
)
SELECT DISTINCT ACCOUNT_ID AS ACCOUNT_ID
			, GATOR_CLIENT_KEY AS CLIENT_KEY
			, GATOR_CLIENT_KEY AS ORIGINAL_CLIENT_KEY
			, 'GATOR' AS SOURCE_SYSTEM
			, 'GATOR' AS ORIGINAL_SOURCE_SYSTEM
			, CLIENT_FIRST_NAME
			, CLIENT_LAST_NAME
FROM CLIENT_LIST
UNION
SELECT DISTINCT ACCOUNT_ID AS ACCOUNT_ID
				, GATOR_CLIENT_KEY AS CLIENT_KEY
				, DW_CLIENT_KEY AS ORIGINAL_CLIENT_KEY
				, 'GATOR' AS SOURCE_SYSTEM
				, 'DW' AS ORIGINAL_SOURCE_SYSTEM
				, CLIENT_FIRST_NAME
				, CLIENT_LAST_NAME
FROM CLIENT_LIST;
SQL
	or_replace = true 
	is_secure = false 
}

