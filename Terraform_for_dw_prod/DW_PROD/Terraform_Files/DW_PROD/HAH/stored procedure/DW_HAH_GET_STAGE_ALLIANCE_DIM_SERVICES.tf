resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALLIANCE_DIM_SERVICES" {
	name ="GET_STAGE_ALLIANCE_DIM_SERVICES"
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
-- NAME:  ALLIANCE DIM SERVICES
--
-- PURPOSE: Populates Stage DIM SERVICES  for ALLIANCE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/07/23    Shraddha Sejpal       Initial version
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.ALLIANCE_DIM_SERVICES

SELECT MD5(''ALLIANCE'' || ''-'' || SR.SERVICECODE ||  ''-'' || ''ALLIANCE'') AS SERVICE_KEY,
       ''19'' AS SOURCE_SYSTEM_ID,
       ''ALLIANCE'' AS SYSTEM_CODE,
       SR.SERVICECODE AS SERVICE_CODE,
       SR.DESCRIPTION AS SERVICE_DESCRIPTION,
       SR.SHORTDESCRIPTION AS SERVICE_TYPE,
       CASE WHEN SR.FLATRATE =TRUE THEN ''Visit'' 
       		WHEN SR.FLATRATE =FALSE THEN ''Hourly'' ELSE NULL 
       END AS SERVICE_RATE_TYPE,
       ''HC'' AS REVENUE_CATEGORY,
       ''HC'' AS REVENUE_SUBCATEGORY_CODE,
       ''HOME CARE'' AS REVENUE_SUBCATEGORY_NAME,
    	TRUE AS ACTIVE_FLAG,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.SERVICES SR;
return ''SUCCESS'';
END;

 EOT
}

