resource "snowflake_procedure" "DW_HAH_GET_STAGE_COSTALSYNCDATA_DIM_PARTNER" {
	name ="GET_STAGE_COSTALSYNCDATA_DIM_PARTNER"
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
-- NAME:  COSTALSYNCDATA_DIM_PARTNER
--
-- PURPOSE: Creates one row per payor according to COSTALSYNCDATA
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- (MM/DD/YY)	
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/01/23    RAJAT SAPKAL          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_DIM_PARTNER

SELECT 
 DISTINCT MD5( PCM.ORIGINAL_SYSTEM_CODE || ''-'' || PCM.PAYOR_ID   || ''-'' || PCM.PAYOR_NAME || ''-'' || ''COSTALSYNCDATA'') AS PARTNER_KEY
,MD5( PCM.ORIGINAL_SYSTEM_CODE || ''-'' || DPP.PARENT_PAYOR_ID || ''-'' || DPP.PARENT_PAYOR_NAME || ''-'' || ''COSTALSYNCDATA'') AS PARENT_PARTNER_KEY
,DPP.PARENT_PAYOR_NAME AS PARENT_PARTNER_NAME
,PCM.ORIGINAL_SOURCE_SYSTEM_ID AS SOURCE_SYSTEM_ID
,PCM.ORIGINAL_SYSTEM_CODE AS SYSTEM_CODE
,PCM.PAYOR_ID AS PARTNER_CODE
,PCM.PAYOR_NAME AS PARTNER_NAME
,DPP.PAYOR_TYPE_CODE AS PARTNER_TYPE_CODE
,PT.PAYOR_TYPE_NAME AS PARTNER_TYPE_NAME
,TRUE AS ACTIVE_FLAG
,TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE
,TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE
---- ETL FIELDS ----
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
		, 0 AS ETL_INFERRED_MEMBER_FLAG 
 FROM DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING PCM
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR DPP
    ON PCM.PAYOR_ID = DPP.PAYOR_ID
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_TYPE PT 
   	ON PT.PAYOR_TYPE_CODE =DPP.PAYOR_TYPE_CODE
    WHERE ORIGINAL_SOURCE_SYSTEM_ID IN (1,2);

return ''SUCCESS'';
END;

 EOT
}

