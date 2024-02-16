resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_DIM_SERVICES" {
	name ="GET_STAGE_MATRIXCARE_DIM_SERVICES"
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
-- NAME:  MATRIXCARE DIM SERVICES 
--
-- PURPOSE: Populates Stage DIM SERVICES for MATRIXCARE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/04/23	   Sam Huff			 Initial Development
-- 06/26/23    Nutan Jagnade     Modified changes in REVENUE_CATEGORY,REVENUE_SUBCATEGORY_NAME,REVENUE_SUBCATEGORY_CODE  
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_SERVICES

SELECT DISTINCT
MD5(''MATRIXCARE'' || ''-'' || s1.SVCC_id || ''-'' || ''MATRIXCARE'') AS SERVICE_KEY,
7 AS SOURCE_SYSTEM_ID,
''MATRIXCARE'' AS SYSTEM_CODE,
s1.SVCC_ID::varchar AS SERVICE_CODE,
COALESCE(s1.SVCC_DESCRIPTION, ''UNKNOWN'') AS SERVICE_DESCRIPTION,
COALESCE(s1.SVCC_NAME, ''UNKNOWN'') AS SERVICE_TYPE,
CASE 
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG = -1 then ''Medicare''
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG IN (0,150) then ''Visit''
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG = 1 then ''Minute''
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG = 15 then ''15 Min''
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG = 30 then ''30 Min''
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG = 60 then ''Hourly''
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG = 1440 then ''Daily''
        WHEN s1.SVCC_DEFAULTBILLUNITFLAG IS NOT NULL THEN ''UNKNOWN''
        ELSE NULL
    END  AS SERVICE_RATE_TYPE,
    SERVICE_MAPPING.SERVICE_LINE AS REVENUE_CATEGORY,	  
SERVICE_MAPPING.SERVICE_LINE_SUBCATEGORY AS REVENUE_SUBCATEGORY_CODE,
	SERVICE_MAPPING.SERVICE_LINE_SUBCATEGORY_NAME AS REVENUE_SUBCATEGORY_NAME,
s1.SVCC_ACTIVE AS ACTIVE_FLAG,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SERVICECODE s1
LEFT JOIN DISC_${var.SF_ENVIRONMENT}."STAGE".MATRIXCARE_SERVICE_REVENUE_CATEGORY_MAPPING AS SERVICE_MAPPING
        ON SERVICE_MAPPING.SVCC_ID = S1.SVCC_ID;
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;


 EOT
}

