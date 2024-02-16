resource "snowflake_procedure" "DW_HAH_GET_STAGE_ASR_DIM_SERVICES" {
	name ="GET_STAGE_ASR_DIM_SERVICES"
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
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME:  ASR DIM SERVICES 
--
-- PURPOSE: Populates Stage DIM SERVICES for ASR
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/03/23    VIJAY SHARMA          Initial version
--06/27/23     SAGAR GULGHANE        Modified changes in REVENUE_CATEGORY,REVENUE_SUBCATEGORY_NAME,REVENUE_SUBCATEGORY_CODE 
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.ASR_DIM_SERVICES
WITH ALL_Services AS (
    SELECT SERVICE_TYPE_ID, SERVICE_TYPE_NAME, SERVICETYPEDESCR,
        CASE WHEN SERVICE_TYPE_ID  IN (1,2,3,4,5,6,7,8) THEN ''400-100'' ELSE TRIM(GLACCOUNTNUMBER) END AS SEGMENT
    FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_SERVICETYPES S
    UNION
    SELECT ''0'' AS SERVICE_TYPE_ID, ''UNKNOWN'' AS SERVICE_TYPE_NAME, ''UNKNOWN'' AS SERVICETYPEDESCR,
    ''400-100'' AS SEGMENT -- DUMMY SERVICE to retrieve orphan visits AND considered AS HomeCare
)
SELECT DISTINCT
MD5(''PRIME'' || ''-'' || S.SERVICE_TYPE_ID || ''-'' || ''ASR'') AS SERVICE_KEY,
''13'' AS SOURCE_SYSTEM_ID,
''PRIME'' AS SYSTEM_CODE,
S.SERVICE_TYPE_NAME AS SERVICE_CODE,
S.SERVICETYPEDESCR AS SERVICE_DESCRIPTION,
NULL AS SERVICE_TYPE, --?
''Hourly'' AS SERVICE_RATE_TYPE,
CASE WHEN SEGMENT = ''400-300'' THEN ''HH''
    WHEN SEGMENT = ''400-100'' THEN ''HC''
    ELSE SEGMENT
END AS REVENUE_CATEGORY,
CASE
    WHEN SEGMENT = ''400-300'' THEN ''HOME HEALTH AIDE''
    WHEN SEGMENT = ''400-100'' THEN ''HOME CARE''
    ELSE SEGMENT
    END AS REVENUE_SUBCATEGORY_NAME,
    CASE 
    WHEN SEGMENT = ''400-300'' THEN ''HHA''
    WHEN SEGMENT = ''400-100'' THEN ''HC''
    ELSE SEGMENT
    END AS REVENUE_SUBCATEGORY_CODE ,   
 TRUE AS ACTIVE_FLAG, --?
 :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
 :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
 convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 as ETL_DELETED_FLAG
 FROM ALL_Services AS S;
 
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;


 EOT
}

