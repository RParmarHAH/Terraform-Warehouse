resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALLIANCE_DIM_VISIT_EXCEPTION" {
	name ="GET_STAGE_ALLIANCE_DIM_VISIT_EXCEPTION"
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
-- NAME:  ALLIANCE_DIM_VISIT_EXCEPTION
--
-- PURPOSE: Creates one row per visit exception according to ALLIANCE
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/1/2022	Abhishek Sunil			Initial Development
-- 9/22/2023	Diya Mistry             Added CATEGORY_KEY field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ALLIANCE_DIM_VISIT_EXCEPTION
WITH EXCEPTIONS AS (
	SELECT 
		DISTINCT
		NVL(TRIM(EC.STATECODE),''ALL'') || ''-'' || TRIM(EC.EXCEPTIONCODE) AS EXCEPTIONCODE,
		TRIM(EC.DESCRIPTION) AS EXCEPTIONDESC
	FROM 
		DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.EXCEPTIONCODES EC
	ORDER BY
		EXCEPTIONCODE ASC
)
SELECT
	MD5(''ALLIANCE'' || ''-'' || UPPER(EXC.EXCEPTIONCODE) || ''-'' || ''GENERATIONS'') AS EXCEPTION_KEY,
	19 AS SOURCE_SYSTEM_ID,
	''ALLIANCE'' AS SYSTEM_CODE,
	UPPER(EXC.EXCEPTIONCODE) AS EXCEPTION_CODE,
	EXC.EXCEPTIONDESC AS EXCEPTION_DESC,
	NULL AS EXCEPTION_CATEGORY,
	MD5(UPPER(EXC.EXCEPTIONDESC )) AS CATEGORY_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM
	EXCEPTIONS EXC
GROUP BY
	UPPER(EXC.EXCEPTIONCODE), EXCEPTION_DESC,MD5(UPPER(EXC.EXCEPTIONDESC ))
ORDER BY
	UPPER(EXC.EXCEPTIONCODE) ASC;
 
RETURN ''SUCCESS'';
END;


 EOT
}

