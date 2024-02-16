resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_DIM_PARTNER_CONTRACT" {
	name ="GET_STAGE_COSTALSYNCDATA_DIM_PARTNER_CONTRACT"
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
-- NAME:  COSTALSYNCDATA_DIM_PARTNER_CONTRACT
--
-- PURPOSE: Creates one row per payor and contract combination according to COSTALSYNCDATA
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- (MM/DD/YY)	
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/01/23    RAJAT SAPKAL          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_DIM_PARTNER_CONTRACT

SELECT DISTINCT 
MD5( PCM.ORIGINAL_SYSTEM_CODE || ''-'' || PCM.PAYOR_ID   || ''-'' || PCM.CONTRACT_CODE || ''-'' || ''COSTALSYNCDATA'') AS PARTNER_CONTRACT_KEY 
		,PCM.ORIGINAL_SOURCE_SYSTEM_ID AS SOURCE_SYSTEM_ID
		,PCM.ORIGINAL_SYSTEM_CODE AS SYSTEM_CODE
		, NULL AS ORIGINAL_SOURCE_SYSTEM_ID
		, NULL AS ORIGINAL_SYSTEM_CODE
        , NULL AS STATE
        , MD5( PCM.ORIGINAL_SYSTEM_CODE || ''-'' || PCM.PAYOR_ID   || ''-'' || PCM.PAYOR_NAME || ''-'' || ''COSTALSYNCDATA'') AS PARTNER_KEY
		, PCM.PAYOR_ID AS PARTNER_CODE
		, PCM.PAYOR_NAME AS PARTNER_NAME
		, PCM.CONTRACT_CODE AS CONTRACT_CODE
        , PCM.CONTRACT_NAME AS CONTRACT_NAME
		, TRUE  AS ACTIVE_FLAG
		, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE
	    , TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE
	---- ETL FIELDS ----
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG 
FROM DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING PCM
WHERE ORIGINAL_SOURCE_SYSTEM_ID IN (1,2);

return ''SUCCESS'';
END;

 EOT
}

