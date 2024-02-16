resource "snowflake_procedure" "DW_HAH_GET_STAGE_SANDATAIMPORT_DIM_PARTNER" {
	name ="GET_STAGE_SANDATAIMPORT_DIM_PARTNER"
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
-- NAME:  SANDATAIMPORT_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to SANDATA 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/03/23     VIJAY SHARMA          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.SANDATAIMPORT_DIM_PARTNER
SELECT DISTINCT MD5(IFNULL(P.PAYORID,-1) || ''-'' || ''SANDATAIMPORT'') AS PARTNER_KEY,
 	NULL AS PARENT_PARTNER_KEY,
    ''UNKNOWN'' AS PARENT_PARTNER_NAME,
	4 AS SOURCE_SYSTEM_ID,
	P.AGENCYID AS SYSTEM_CODE,
	P.PAYORID AS PARTNER_CODE, --?
	P."NAME" AS PARTNER_NAME,
	TRUE AS ACTIVE_FLAG, --? 
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE, --? 
	TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE --? 
	---- ETL FIELDS ----
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	, CURRENT_USER AS ETL_INSERTED_BY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	, 0 AS ETL_DELETED_FLAG
	, 0 AS ETL_INFERRED_MEMBER_FLAG 
	FROM DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_PAYORS P
	WHERE P.AGENCYID = ''8485'';

return ''SUCCESS'';
END;

 EOT
}

