resource "snowflake_procedure" "DW_HAH_GET_STAGE_GATOR_DIM_PARTNER" {
	name ="GET_STAGE_GATOR_DIM_PARTNER"
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
BEGIN
    --*****************************************************************************************************************************
-- NAME:  CENTENE_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER  
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 12/27/23    Meet Hariyani        Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.GATOR_DIM_PARTNER
SELECT DISTINCT MD5(PARTNER_CODE || ''-'' || 29 || ''-'' || PARTNER_CODE) AS PARTNER_KEY
        		, NULL AS PARENT_PARTNER_KEY
        		, ''UNKNOWN'' AS PARENT_PARTNER_NAME
        		, 29 AS SOURCE_SYSTEM_ID
        		, ''GATOR'' AS SYSTEM_CODE
        		, PARTNER_NAME AS PARTNER_NAME	 
        		, PARTNER_CODE AS PARTNER_CODE
        		, IS_ACTIVE AS ACTIVE_FLAG 
       			, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE
        		, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE
       			---- ETL FIELDS ----
        		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
        		, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
        		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
        		, CURRENT_USER AS ETL_INSERTED_BY
        		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
        		, CURRENT_USER AS ETL_LAST_UPDATED_BY
        		, 0 AS ETL_DELETED_FLAG
        		, 0 AS ETL_INFERRED_MEMBER_FLAG
FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER_PROGRAM_MAPPING; 
RETURN ''SUCCESS'';
END
 EOT
}

