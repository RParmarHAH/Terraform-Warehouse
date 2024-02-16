resource "snowflake_procedure" "DW_HAH_GET_STAGE_CCSI_DIM_PARTNER_CONTRACT" {
	name ="GET_STAGE_CCSI_DIM_PARTNER_CONTRACT"
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
-- NAME:  CCSI_DIM_PARTNER_CONTRACT
--
-- PURPOSE: Creates one row per PARTNER AND CONTRACT according to CCSI 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/08/23     SANKET JAIN          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.CCSI_DIM_PARTNER_CONTRACT

SELECT DISTINCT MD5(''CCSI'' || ''-'' || R.CONTRACT_NO || ''-'' || ''CCSI'') AS PARTNER_CONTRACT_KEY
		, 8 AS SOURCE_SYSTEM_ID
		, ''CCSI'' AS SYSTEM_CODE
		, 8 AS ORIGINAL_SOURCE_SYSTEM_ID
		, ''CCSI'' AS ORIGINAL_SYSTEM_CODE
        ,''IL'' AS STATE
		, MD5(''CCSI'' || ''-'' || PCM.PAYOR_ID || ''-'' || ''CCSI'') AS PARTNER_KEY
		, PCM.PAYOR_ID  AS PARTNER_CODE
        , PCM.PAYOR_NAME  AS PARTNER_NAME
		, R.CONTRACT_NO AS CONTRACT_CODE
        , R.CONTRACT_NO AS CONTRACT_NAME
		, TRUE  AS ACTIVE_FLAG
		, ''1990-01-01'' AS START_DATE
		, ''9999-12-31''END_DATE 
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.CCSI.RAWVRFP  R
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING PCM
		ON  PCM.ORIGINAL_SOURCE_SYSTEM_ID = 8
		AND UPPER(R.CONTRACT_NO) = PCM.CONTRACT_CODE
WHERE R.CONTRACT_NO IS NOT NULL;

return ''SUCCESS'';
END;

 EOT
}

