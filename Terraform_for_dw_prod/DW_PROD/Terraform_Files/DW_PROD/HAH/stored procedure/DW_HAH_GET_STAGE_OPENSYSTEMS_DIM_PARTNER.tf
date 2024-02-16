resource "snowflake_procedure" "DW_HAH_GET_STAGE_OPENSYSTEMS_DIM_PARTNER" {
	name ="GET_STAGE_OPENSYSTEMS_DIM_PARTNER"
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
-- NAME:  OPENSYSTEMS_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to OPENSYSTEMS 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/22/23     SANKET JAIN          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.OPENSYSTEMS_DIM_PARTNER

SELECT DISTINCT MD5(''OPENSYSTEMS'' || ''-'' || PAYERID || ''-'' || ''HHAEXCHANGE'') AS PARTNER_KEY
        , NULL  AS PARENT_PARTNER_KEY 
        , ''UNKNOWN'' AS PARENT_PARTNER_NAME
		, 17 AS SOURCE_SYSTEM_ID
		, CONCAT(''OPENSYSTEMS - '',CASE WHEN STATE=''DE'' OR PAYERNAME ILIKE ANY (''%DE'',''%DC Medicaid%'',''%Highmark Health Options%'',''%AmeriHealth Caritas DE%'') THEN ''DE''  ELSE ''PA'' END) AS SYSTEM_CODE
        , PAYERNAME                                                                                      
		, PAYERID::VARCHAR AS PARTNER_CODE
		, STATUS  AS ACTIVE_FLAG
		, ''1990-01-01'' AS START_DATE
		, ''9999-12-31''END_DATE 
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
		, 0 AS ETL_INFERRED_MEMBER_FLAG 
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.PAYER_REPL;

return ''SUCCESS'';
END;

 EOT
}

