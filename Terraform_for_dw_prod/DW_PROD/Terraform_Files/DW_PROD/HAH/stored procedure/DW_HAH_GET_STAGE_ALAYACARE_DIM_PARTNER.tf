resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_DIM_PARTNER" {
	name ="GET_STAGE_ALAYACARE_DIM_PARTNER"
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
-- NAME:  ALAYACARE_DIM_PARTNER
--
-- PURPOSE: Creates one row per payor according to ALAYACARE
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- (MM/DD/YY)	
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 09/20/23    Rajat Sapkal          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ALAYACARE_DIM_PARTNER

SELECT DISTINCT MD5(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'' || ''-'' || COALESCE(F.MEDICAID_PAYER_CODE,CODE) || ''-'' || COALESCE(F.MEDICAID_PAYER_NAME,"NAME") || ''-'' || ''ALAYACARE'') AS PARTNER_KEY
 	, NULL AS PARENT_PARTNER_KEY
    , ''UNKNOWN'' AS PARENT_PARTNER_NAME
	, 9  AS SOURCE_SYSTEM_ID
	, UPPER(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'') AS SYSTEM_CODE
	, COALESCE(F.MEDICAID_PAYER_CODE,CODE) AS PARTNER_CODE
	, COALESCE(F.MEDICAID_PAYER_NAME,"NAME") AS PARTNER_NAME
	, NULL AS PARTNER_TYPE_CODE
	, NULL AS PARTNER_TYPE_NAME
	, TRUE AS ACTIVE_FLAG 
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
	, 0 AS ETL_INFERRED_MEMBER_FLAG 
FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.FUNDER F 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH AS COMPANY
	ON COMPANY.BRANCH_ID = F.BRANCH_ID;

return ''SUCCESS'';
END;

 EOT
}

