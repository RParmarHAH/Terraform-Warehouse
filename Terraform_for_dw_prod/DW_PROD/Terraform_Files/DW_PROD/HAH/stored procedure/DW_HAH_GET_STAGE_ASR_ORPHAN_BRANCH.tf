resource "snowflake_procedure" "DW_HAH_GET_STAGE_ASR_ORPHAN_BRANCH" {
	name ="GET_STAGE_ASR_ORPHAN_BRANCH"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
--*****************************************************************************************************************************
-- NAME:  ASR_ORPHAN_BRANCH
--
-- PURPOSE: 
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/05/2023	TRUSHALI RAMOLIYA			Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.ASR_ORPHAN_BRANCH
--NO RESPECTIVE VALUE FOR COLUMN  -  NEW_LOCATION_ID(EMPTY STRING) FOR TABLE ''DISC_${var.SF_ENVIRONMENT}.ASR.BRANCH_MAPPING''

SELECT
MD5(''PRIME'' || ''-'' || ''UNKNOWN'' || ''-'' || ''ASR'') AS BRANCH_KEY,
''UNKNOWN'' AS BRANCH_NAME ,
''PRIME'' AS SYSTEM_CODE,
13 AS SOURCE_SYSTEM_ID,
''AMS'' AS SOURCE_SYSTEM_TYPE,
-1 AS OFFICE_NUMBER,
-1 AS OFFICE_CODE,
''UNKNOWN'' AS OFFICE_NAME,
NULL AS OFFICE_NAME_ALT,
NULL AS DEPARTMENT_NAME,
NULL AS BRANCH_SERVICE_LINE,
FALSE AS PARENT_FLAG,
MD5(''PRIME'' || ''-'' || ''UNKNOWN'' || ''-'' || ''ASR'') AS PARENT_BRANCH_KEY,
-1 AS PARENT_OFFICE_NUMBER,
-1 AS PARENT_OFFICE_CODE,
''OH - UNKNOWN (-1)'' AS PARENT_BRANCH_NAME,
NULL AS OFFICE_ADDRESS1,
NULL AS OFFICE_ADDRESS2,
NULL AS OFFICE_CITY,
''OH'' AS OFFICE_STATE_CODE,
NULL AS OFFICE_ZIP,
NULL AS OFFICE_PHONE,
NULL AS OFFICE_TOLL_FREE_PHONE,
NULL AS OFFICE_FAX,
''OH - UNKNOWN (-1)''  AS DETAILED_OFFICE_NAME,
NULL AS REGION_NUMBER,
NULL AS REGION_NAME,
NULL AS REGION_MANAGER,
NULL AS REGION_MANAGER_EMPLOYEE_KEY,
NULL AS SUBREGION_NAME,
NULL AS PRIMARY_BRANCH_MANAGER_NAME,
NULL AS PRIMARY_BRANCH_EMAIL,
NULL AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS SECONDARY_BRANCH_MANAGER_NAME,
NULL AS SECONDARY_BRANCH_EMAIL,
NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS RISKCONNECT_NODE_KEY,
NULL AS RISKCONNECT_NAME,
NULL AS HR_OFFICE_NUMBER,
NULL AS HR_OFFICE_NAME,
FALSE AS ACTIVE_FLAG,
TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG,
FALSE AS ETL_INFERRED_MEMBER_FLAG
;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

