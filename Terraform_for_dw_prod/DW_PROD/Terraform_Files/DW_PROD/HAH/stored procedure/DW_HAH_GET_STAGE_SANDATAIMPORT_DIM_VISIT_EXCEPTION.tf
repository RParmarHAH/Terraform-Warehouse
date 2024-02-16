resource "snowflake_procedure" "DW_HAH_GET_STAGE_SANDATAIMPORT_DIM_VISIT_EXCEPTION" {
	name ="GET_STAGE_SANDATAIMPORT_DIM_VISIT_EXCEPTION"
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
-- NAME:  SANDATAIMPORT_DIM_VISIT_EXCEPTION
--
-- PURPOSE: Creates one row per visit exception according to SANDATAIMPORT
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/1/2022	Abhishek Sunil			Initial Development
-- 30/6/2023	Naresha Bhat			Data Source Modification
-- 9/22/2023	Diya Mistry             Added CATEGORY_KEY field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.SANDATAIMPORT_DIM_VISIT_EXCEPTION
SELECT
	MD5(EC.AGENCYID || ''-'' || EC.EXCEPTION_CODE || ''-'' || ''SANDATAIMPORT'') AS EXCEPTION_KEY,
	4 AS SOURCE_SYSTEM_ID,
	EC.AGENCYID AS SYSTEM_CODE,
	EC.EXCEPTION_CODE  AS EXCEPTION_CODE,
	TRIM(EC.EXCEPTION_DESC) AS EXCEPTION_DESC,
	NULL AS EXCEPTION_CATEGORY,
    MD5(UPPER(EC.EXCEPTION_DESC)) AS CATEGORY_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM
	DISC_${var.SF_ENVIRONMENT}.SANDATAIMPORT.SANDATA_MANUAL_EXCEPTIONCODES EC
WHERE
	EC.AGENCYID = ''8485'';
	
RETURN ''SUCCESS'';
END;


 EOT
}

