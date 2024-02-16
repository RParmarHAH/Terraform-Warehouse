resource "snowflake_procedure" "DW_HAH_GET_STAGE_GENERAL_DIM_SURVEY" {
	name ="GET_STAGE_GENERAL_DIM_SURVEY"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
-- NAME:  DIM_SURVEY
--
-- PURPOSE: Insert survey list
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR             	NOTES:
-- --------    -------------------  ---------------------------------------------------------------------------
-- 19/09/2022  Paras Bhavnani	    Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.DIM_SURVEY 
SELECT 
	MD5(f.value:id::STRING) AS SURVEY_KEY,
	f.value:id::STRING AS SURVEY_ID,
	f.value:name::STRING AS Survey_name,
	--IFF(f.value:isActive::STRING=''true'',1,0) AS Active,
	0 AS Active,
	NULL AS CLIENT_EMPLOYEE_INDICATOR,
	NULL AS ETL_TASK_KEY,
	NULL AS ETL_INSERTED_TASK_KEY,
	current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,
	CURRENT_USER() AS ETL_INSERTED_BY,
	current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER() AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_LIST, table(flatten(SURVEY_LIST_JSON:result:elements )) f;

UPDATE DW_${var.SF_ENVIRONMENT}.HAH.DIM_SURVEY SET ACTIVE=0 WHERE SURVEY_ID NOT IN (SELECT SURVEY_ID FROM DW_${var.SF_ENVIRONMENT}.STAGE.DIM_SURVEY);

return ''Succeeded.'';

END

 EOT
}

