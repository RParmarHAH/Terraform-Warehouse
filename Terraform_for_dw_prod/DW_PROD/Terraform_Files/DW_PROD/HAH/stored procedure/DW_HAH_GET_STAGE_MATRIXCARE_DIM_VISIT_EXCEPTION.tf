resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_DIM_VISIT_EXCEPTION" {
	name ="GET_STAGE_MATRIXCARE_DIM_VISIT_EXCEPTION"
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
-- NAME:  MATRIXCARE_DIM_VISIT_EXCEPTION
--
-- PURPOSE: Creates one row per visit exception according to MATRIXCARE
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/1/2022	Abhishek Sunil			Initial Development
-- 9/22/2023	Diya Mistry             Added CATEGORY_KEY field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_VISIT_EXCEPTION
SELECT
	MD5(''MATRIXCARE'' || ''-'' || EXC.BIT_CODE::VARCHAR || ''-'' || ''MATRIXCARE'') AS EXCEPTION_KEY,
	7 AS SOURCE_SYSTEM_ID,
	''MATRIXCARE'' AS SYSTEM_CODE,
	EXC.BIT_CODE::VARCHAR AS EXCEPTION_CODE,
	EXC.DESC AS EXCEPTION_DESC,
	NULL AS EXCEPTION_CATEGORY,
	MD5(UPPER(EXC.DESC)) AS CATEGORY_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM
	DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.BITWISE_EXCEPTIONS EXC
ORDER BY 
	EXC.BIT_CODE;
	
RETURN ''SUCCESS'';
END;


 EOT
}

