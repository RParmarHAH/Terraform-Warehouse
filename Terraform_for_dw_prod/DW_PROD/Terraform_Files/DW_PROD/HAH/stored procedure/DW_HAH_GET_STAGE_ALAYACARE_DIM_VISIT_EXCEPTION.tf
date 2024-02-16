resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_DIM_VISIT_EXCEPTION" {
	name ="GET_STAGE_ALAYACARE_DIM_VISIT_EXCEPTION"
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
-- NAME:  ALAYACARE_DIM_VISIT_EXCEPTION
--
-- PURPOSE: Creates one row per visit exception according to ALAYACARE
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/1/2022	Abhishek Sunil			Initial Development
-- 9/22/2023	Diya Mistry             Added CATEGORY_KEY field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ALAYACARE_DIM_VISIT_EXCEPTION
SELECT
	MD5(NVL(TRIM(BR.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(VISITS.BRANCH_ID,''-1'') || '')'' || ''-'' || exc.value:"code"::STRING || ''-'' || ''ALAYACARE'') AS EXCEPTION_KEY,
	9 AS SOURCE_SYSTEM_ID,
	UPPER(NVL(TRIM(BR.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(VISITS.BRANCH_ID,''-1'') || '')'') AS SYSTEM_CODE,
	exc.value:"code"::STRING AS EXCEPTION_CODE,
	exc.value:"name"::STRING AS EXCEPTION_DESC,
	exc.value:"category"::STRING AS EXCEPTION_CATEGORY,
	MD5(UPPER(exc.value:"name"::STRING)) AS CATEGORY_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM
	DISC_${var.SF_ENVIRONMENT}.ALAYACARE.EVV_VISIT VISITS
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH AS BR
	ON BR.BRANCH_ID = VISITS.BRANCH_ID
,LATERAL FLATTEN(INPUT => VISITS.EXCEPTIONS) exc
GROUP BY
	BR.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION, VISITS.BRANCH_ID, EXCEPTION_CODE, EXCEPTION_DESC, EXCEPTION_CATEGORY,MD5(UPPER(exc.value:"name"::STRING));
 
RETURN ''SUCCESS'';
END;


 EOT
}

