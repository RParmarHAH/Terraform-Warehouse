resource "snowflake_procedure" "DW_HAH_GET_STAGE_JAZZHR_DIM_JOB" {
	name ="GET_STAGE_JAZZHR_DIM_JOB"
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

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
--*****************************************************************************************************************************
-- NAME:  JAZZHR_DIM_JOB
--
-- PURPOSE: Creates one row per JOB from JAZZHR
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                               NOTES:
-- --------    -------------------                  ---------------------------------------------------------------------------
-- 05/08/2022  Aditya Shukla / Rutvi Vyas     Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.JAZZHR_DIM_JOB
WITH BR AS(
SELECT
    DISTINCT J.INTERNAL_CODE,
    J.ID AS APID
FROM
    DISC_${var.SF_ENVIRONMENT}.JAZZHR.JOBS J
),
BR_BRANCH
AS
(
SELECT
    DISTINCT BO.INTERNAL_CODE,
    BO.APID,
    B.SOURCE_SYSTEM_ID ,
    B.BRANCH_KEY
FROM
    BR BO
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH B
ON
UPPER(TRIM(BO.INTERNAL_CODE)) = UPPER(TRIM(B.DETAILED_OFFICE_NAME))
WHERE
    COALESCE(INTERNAL_CODE,
    '''') <> ''''
    AND B.SOURCE_SYSTEM_ID NOT IN (10,6)
),
DF
AS
(
SELECT
    APID,
    BRANCH_KEY,
    ROW_NUMBER() OVER(PARTITION BY APID,
    BRANCH_KEY
    ORDER BY
    CASE
        WHEN SOURCE_SYSTEM_ID IN (3, 4, 9) THEN 1 -- data is coming for 1,2,3,4,9 SOURCE_SYSTEM_ID
        ELSE 2
    END ASC)R
FROM
    BR_BRANCH
QUALIFY R = 1  --IN FUTURE IF ANY DATA COME DUPLICATE THAT TIME THIS CONDITION WILL HELP TO FILTER OUT
)
SELECT DISTINCT
    MD5(TRIM(NVL(J.ID,''UNKNOWN'')) || ''-'' || ''JAZZHR'') AS JOB_KEY,
	20 AS SOURCE_SYSTEM_ID,
	''JAZZHR'' AS SYSTEM_CODE,
	J.ID AS JOB_ID,
	IFF(LENGTH(STATE) <= 2, NULLIF(TRIM(STATE), ''''), NULL) AS STATE,
	CITY AS CITY,
	ORIGINAL_OPEN_DATE AS JOB_POSTING_DATE, 
	NULL AS JOB_CLOSING_DATE,
	NULL AS JOB_CREATED_DATE,
	TITLE AS JOB_TITLE,
	NULL AS JOB_TITLE_CODE,
	DEPARTMENT AS JOB_FAMILY, 
	NULL AS JOB_FAMILY_CODE,
	NULL AS JOB_OWNER,
	NULL AS JOB_OWNER_ID,
	STATUS AS JOB_STATUS,
	CITY AS LOCATION_NAME, 
	NULL AS EXTERNAL_JOB_REFERENCE_NUMBER,
	NULL AS ARCHIVED,
	NULL AS REQ_AGE,
	NULL AS REQ_AGE_GROUP,
	NULL AS JOB_POSTING_LINK,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
    CURRENT_USER AS ETL_INSERTED_BY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
    CURRENT_USER AS ETL_LAST_UPDATED_BY,
    FALSE AS ETL_DELETED_FLAG,
    BK.BRANCH_KEY AS BRANCH_KEY
FROM DISC_${var.SF_ENVIRONMENT}.JAZZHR.JOBS J
LEFT JOIN DF BK
ON BK.APID = J.ID;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

