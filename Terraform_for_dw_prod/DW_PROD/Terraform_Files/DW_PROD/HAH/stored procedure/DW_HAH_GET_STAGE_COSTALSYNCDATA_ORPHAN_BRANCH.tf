resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_ORPHAN_BRANCH" {
	name ="GET_STAGE_COSTALSYNCDATA_ORPHAN_BRANCH"
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
-- NAME:  COSTALSYNCDATA_ORPHAN_BRANCH
--
-- PURPOSE: 
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/05/2023	TRUSHALI RAMOLIYA			Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.COSTALSYNCDATA_ORPHAN_BRANCH

--NO RESPECTIVE VALUE FOR COLUMN  - LOCATION_CODE(EMPTY STRING) FOR TABLE DISC_${var.SF_ENVIRONMENT}.CostalSyncData.CV_Locations 

SELECT 
md5( ''SHC_SAVANNAH'' || ''-'' || '''' || ''-'' || ''COSTALSYNCDATA'') AS BRANCH_KEY,
''UNKNOWN'' AS BRANCH_NAME ,
''SHC_SAVANNAH'' AS SYSTEM_CODE,
2 AS SOURCE_SYSTEM_ID,
''AMS'' AS SOURCE_SYSTEM_TYPE,
-1 AS OFFICE_NUMBER,
-1 AS OFFICE_CODE,
''UNKNOWN'' AS OFFICE_NAME,
''UNKNOWN'' AS OFFICE_NAME_ALT,
NULL AS DEPARTMENT_NAME,
NULL AS BRANCH_SERVICE_LINE,
FALSE AS PARENT_FLAG,
md5( ''SHC_SAVANNAH'' || ''-'' || '''' || ''-'' || ''COSTALSYNCDATA'') AS PARENT_BRANCH_KEY,
-1 AS PARENT_OFFICE_NUMBER,
-1 AS PARENT_OFFICE_CODE,
''GA - UNKNOWN (-1-1)''  AS PARENT_BRANCH_NAME,
NULL AS OFFICE_ADDRESS1,
NULL AS OFFICE_ADDRESS2,
NULL AS OFFICE_CITY,
''GA'' AS OFFICE_STATE_CODE,
NULL AS OFFICE_ZIP,
NULL AS OFFICE_PHONE,
NULL AS OFFICE_TOLL_FREE_PHONE,
NULL AS OFFICE_FAX,
''GA - UNKNOWN (-1-1)''  AS DETAILED_OFFICE_NAME,
-1 AS REGION_NUMBER,
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
UNION ALL
----TEST BRANCH -- location name is TEST
SELECT 
md5( ''SHC_SAVANNAH'' || ''-'' || ''*TE'' || ''-'' || ''COSTALSYNCDATA'') AS BRANCH_KEY,
''TEST'' AS BRANCH_NAME ,
''SHC_SAVANNAH'' AS SYSTEM_CODE,
2 AS SOURCE_SYSTEM_ID,
''AMS'' AS SOURCE_SYSTEM_TYPE,
908 AS OFFICE_NUMBER,
--''*TE'' AS OFFICE_CODE,
-1 AS OFFICE_CODE,
''TEST'' AS OFFICE_NAME,
''TEST'' AS OFFICE_NAME_ALT,
''TEST'' AS DEPARTMENT_NAME,
''HC'' AS BRANCH_SERVICE_LINE,
FALSE AS PARENT_FLAG,
md5( ''SHC_SAVANNAH'' || ''-'' || ''*TE'' || ''-'' || ''COSTALSYNCDATA'') AS PARENT_BRANCH_KEY,
-1 AS PARENT_OFFICE_NUMBER,
-1 AS PARENT_OFFICE_CODE,
''GA - TEST (908-*TE)''  AS PARENT_BRANCH_NAME,
NULL AS OFFICE_ADDRESS1,
NULL AS OFFICE_ADDRESS2,
NULL AS OFFICE_CITY,
''GA'' AS OFFICE_STATE_CODE,
NULL AS OFFICE_ZIP,
NULL AS OFFICE_PHONE,
NULL AS OFFICE_TOLL_FREE_PHONE,
NULL AS OFFICE_FAX,
''GA - TEST (908-*TE)''  AS DETAILED_OFFICE_NAME,
2 AS REGION_NUMBER,
''GEORGIA/SOUTH CAROLINA'' AS REGION_NAME,
''JANA'' AS REGION_MANAGER,
NULL AS REGION_MANAGER_EMPLOYEE_KEY,
NULL AS SUBREGION_NAME,
''CHARLIE RYAN''  AS PRIMARY_BRANCH_MANAGER_NAME,
''cryan@helpathome.com'' AS PRIMARY_BRANCH_EMAIL,
NULL AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS SECONDARY_BRANCH_MANAGER_NAME,
NULL AS SECONDARY_BRANCH_EMAIL,
NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS RISKCONNECT_NODE_KEY,
NULL AS RISKCONNECT_NAME,
NULL AS HR_OFFICE_NUMBER,
NULL AS HR_OFFICE_NAME,
FALSE AS ACTIVE_FLAG,
TO_DATE(''2020-05-21'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG,
FALSE AS ETL_INFERRED_MEMBER_FLAG 
UNION ALL  
--THIS BRANCH_KEY HAS STATE = ''IL'' WHICH IS OMMITED BECAUSE OF WHERE CONDITION DOES NOT INCLUDE THE STATE ''IL''(LOCATION CODE 1 AND 2) IT ONLY INCLUDE ''GA'' AND ''SC''.
SELECT
md5( ''SHC_SAVANNAH'' || ''-'' || ''1'' || ''-'' || ''COSTALSYNCDATA'') AS BRANCH_KEY,
''Chicago'' AS BRANCH_NAME ,
''SHC_SAVANNAH'' AS SYSTEM_CODE,
2 AS SOURCE_SYSTEM_ID,
''AMS'' AS SOURCE_SYSTEM_TYPE,
1 AS OFFICE_NUMBER,
1 AS OFFICE_CODE,
''CHICAGO'' AS OFFICE_NAME,
''CHICAGO'' AS OFFICE_NAME_ALT,
''CHICAGO'' AS DEPARTMENT_NAME,
''HC'' AS BRANCH_SERVICE_LINE,
FALSE AS PARENT_FLAG,
md5( ''SHC_SAVANNAH'' || ''-'' || ''1'' || ''-'' || ''COSTALSYNCDATA'') AS PARENT_BRANCH_KEY,
1 AS PARENT_OFFICE_NUMBER,
1 AS PARENT_OFFICE_CODE,
''IL'' || '' - '' || ''CHICAGO'' || '' ('' || ''2'' || ''-'' || ''2'' || '')''  AS PARENT_BRANCH_NAME,
''36 S Wabash Ave'' AS OFFICE_ADDRESS1,
''Fifth Floor'' AS OFFICE_ADDRESS2,
''Chicago'' AS OFFICE_CITY,
''IL'' AS OFFICE_STATE_CODE,
60603 AS OFFICE_ZIP,
NULL AS OFFICE_PHONE,
NULL AS OFFICE_TOLL_FREE_PHONE,
NULL AS OFFICE_FAX,
''IL'' || '' - '' || ''CHICAGO'' || '' ('' || ''2'' || ''-'' || ''2'' || '')''   AS DETAILED_OFFICE_NAME,
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
6001 AS RISKCONNECT_NODE_KEY,
''Chicago'' AS RISKCONNECT_NAME,
NULL AS HR_OFFICE_NUMBER,
NULL AS HR_OFFICE_NAME,
FALSE AS ACTIVE_FLAG,
TO_DATE(''2006-05-04'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG,
FALSE AS ETL_INFERRED_MEMBER_FLAG
UNION ALL
SELECT 
md5( ''SHC_SAVANNAH'' || ''-'' || ''2'' || ''-'' || ''COSTALSYNCDATA'') AS BRANCH_KEY,
''St. Charles'' AS BRANCH_NAME ,
''SHC_SAVANNAH'' AS SYSTEM_CODE,
2 AS SOURCE_SYSTEM_ID,
''AMS'' AS SOURCE_SYSTEM_TYPE,
2 AS OFFICE_NUMBER,
2 AS OFFICE_CODE,
''ST. CHARLES'' AS OFFICE_NAME,
''ST. CHARLES'' AS OFFICE_NAME_ALT,
''ST. CHARLES'' AS DEPARTMENT_NAME,
''HC'' AS BRANCH_SERVICE_LINE,
FALSE AS PARENT_FLAG,
md5( ''SHC_SAVANNAH'' || ''-'' || ''2'' || ''-'' || ''COSTALSYNCDATA'') AS PARENT_BRANCH_KEY,
2 AS PARENT_OFFICE_NUMBER,
2 AS PARENT_OFFICE_CODE,
''IL'' || '' - '' || ''ST. CHARLES'' || '' ('' || ''2'' || ''-'' || ''2'' || '')''   AS PARENT_BRANCH_NAME,
''255 38th Ave.'' AS OFFICE_ADDRESS1,
''Ste. E'' AS OFFICE_ADDRESS2,
''St Charles'' AS OFFICE_CITY,
''IL'' AS OFFICE_STATE_CODE,
60174 AS OFFICE_ZIP,
NULL AS OFFICE_PHONE,
NULL AS OFFICE_TOLL_FREE_PHONE,
NULL AS OFFICE_FAX,
''IL'' || '' - '' || ''ST. CHARLES'' || '' ('' || ''2'' || ''-'' || ''2'' || '')''  AS DETAILED_OFFICE_NAME,
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
6002 AS RISKCONNECT_NODE_KEY,
''St. Charles'' AS RISKCONNECT_NAME,
NULL AS HR_OFFICE_NUMBER,
NULL AS HR_OFFICE_NAME,
FALSE AS ACTIVE_FLAG,
TO_DATE(''2006-05-04'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG,
FALSE AS ETL_INFERRED_MEMBER_FLAG ;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

