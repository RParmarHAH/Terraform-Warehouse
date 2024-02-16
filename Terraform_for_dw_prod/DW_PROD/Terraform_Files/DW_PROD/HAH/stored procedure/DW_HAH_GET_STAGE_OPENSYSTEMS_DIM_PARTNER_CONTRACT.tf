resource "snowflake_procedure" "DW_HAH_GET_STAGE_OPENSYSTEMS_DIM_PARTNER_CONTRACT" {
	name ="GET_STAGE_OPENSYSTEMS_DIM_PARTNER_CONTRACT"
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
-- NAME:  OPENSYSTEMS_DIM_PARTNER_CONTRACT
--
-- PURPOSE: Creates one row per PARTNER_CONTRACT according to OPENSYSTEMS 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/22/23     SANKET JAIN          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.OPENSYSTEMS_DIM_PARTNER_CONTRACT

SELECT DISTINCT MD5(''OPENSYSTEMS'' || ''-'' || COALESCE(off.STATE,''PA'') || ''-'' || PR.PAYERID || ''-'' || COALESCE(PR.CONTRACTID,PR.PAYERID) || ''-'' || ''HHAEXCHANGE'') AS PARTNER_CONTRACT_KEY
		, 17 AS SOURCE_SYSTEM_ID
		, CONCAT(''OPENSYSTEMS - '',COALESCE(off.STATE,''PA'')) AS SYSTEM_CODE
        , COALESCE(off.STATE,''PA'') AS STATE 
		, MD5(''OPENSYSTEMS'' || ''-'' || PR.PAYERID || ''-'' || ''HHAEXCHANGE'') AS PARTNER_KEY
		, PR.PAYERID::VARCHAR AS PARTNER_CODE
		, PR.PAYERNAME
		, COALESCE(PR.CONTRACTID,PR.PAYERID) AS CONTRACT_CODE
		, PAYERNAME AS CONTRACT_NAME
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
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.PAYER_REPL PR
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.PAYEROFFICES PO ON PR.PAYERID= PO.PAYERID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEOPENSYSTEMS.OFFICE_OFFICES_REPL OFF ON OFF.OFFICEID = PO.OFFICEID;

return ''SUCCESS'';
END;

 EOT
}

