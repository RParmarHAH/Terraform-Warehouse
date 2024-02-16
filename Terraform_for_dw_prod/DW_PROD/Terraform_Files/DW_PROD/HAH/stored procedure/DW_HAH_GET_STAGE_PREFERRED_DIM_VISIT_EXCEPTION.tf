resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_DIM_VISIT_EXCEPTION" {
	name ="GET_STAGE_PREFERRED_DIM_VISIT_EXCEPTION"
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
-- NAME:  PREFERRED_DIM_VISIT_EXCEPTION
--
-- PURPOSE: Creates one row per exception according to PREFERRED
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR							NOTES:
-- --------		-------------------				-------------------------------------------------------------------------------
-- 8/19/2023	Diya Mistry/ Abhishek Sunil	    Initial Development
-- 9/22/2023	Diya Mistry                     Added CATEGORY_KEY field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.PREFERRED_DIM_VISIT_EXCEPTION
WITH EXCEPTIONS AS (
	SELECT 
		DISTINCT
		ED.EXCEPTIONCODE  AS EXCEPTIONCODE,
		''PREFERRED'' AS SYSTEM_CODE,
		ED."STATUS"
	FROM 
		DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.EXCEPTIONDETAILS ED
		)
SELECT
	MD5(SYSTEM_CODE || ''-'' || EXC.EXCEPTIONCODE || ''-'' || ''PREFERRED'') AS EXCEPTION_KEY,
	17 AS SOURCE_SYSTEM_ID,
	SYSTEM_CODE AS SYSTEM_CODE,
	UPPER(EXC.EXCEPTIONCODE) AS EXCEPTION_CODE,
	UPPER(EXC.STATUS) AS EXCEPTION_DESC,
	NULL AS EXCEPTION_CATEGORY,
	MD5(UPPER(EXC.STATUS)) AS CATEGORY_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM
	EXCEPTIONS EXC
GROUP BY
	EXC.SYSTEM_CODE, EXC.EXCEPTIONCODE , EXCEPTION_DESC,MD5(UPPER(EXC.STATUS))
ORDER BY 
	EXC.EXCEPTIONCODE,EXC.SYSTEM_CODE;
RETURN ''SUCCESS'';
END;

 EOT
}

