CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_GENERAL_DIM_SURVEY()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
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

INSERT OVERWRITE INTO DW_PROD.STAGE.DIM_SURVEY 
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
FROM DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_LIST, table(flatten(SURVEY_LIST_JSON:result:elements )) f;

UPDATE DW_PROD.HAH.DIM_SURVEY SET ACTIVE=0 WHERE SURVEY_ID NOT IN (SELECT SURVEY_ID FROM DW_PROD.STAGE.DIM_SURVEY);

return ''Succeeded.'';

END
';