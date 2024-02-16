resource "snowflake_procedure" "DW_HAH_GET_STAGE_PARADOX_DIM_JOB" {
	name ="GET_STAGE_PARADOX_DIM_JOB"
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
-- NAME:  PARADOX_DIM_JOB
--
-- PURPOSE: Creates one row per JOB from PARADOX
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                               NOTES:
-- --------    -------------------                  ---------------------------------------------------------------------------
-- 17/02/2022  Saurav Purohit / Manmohan Soni       Initial development
-- 10/11/2022  Manmohan Soni                        Added IL branch mapping logic
-- 07/12/2022  Manmohan Soni                        Updated OH branch mapping logic
-- 09/02/2023  Manmohan Soni                        Updated MS and DL branch mapping logic
-- 21/04/2023  Manmohan Soni                        Updated Prime branch mapping logic
-- 23/05/2023  Manmohan Soni                        Updated IL branch mapping logic
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.PARADOX_DIM_JOB 
WITH UNIQUE_JOBS as (
    SELECT 
        EXTERNAL_JOB_REFERENCE_NUMBER,
        REQ_ID, 
        LOCATION_NAME,  
        JOB_CREATED_DATE,
        JOB_POSTING_DATE,
        ROW_NUMBER() OVER (PARTITION BY REQ_ID, LOCATION_NAME ORDER BY JOB_CREATED_DATE, JOB_POSTING_DATE) RANK
    FROM DISC_${var.SF_ENVIRONMENT}.PARADOX.OPEN_JOBS
) 
SELECT
    distinct
    MD5( TRIM(J.REQ_ID) || ''-'' || J.LOCATION_NAME || ''-'' || ''PARADOX'') as JOB_KEY ,
    12 as SOURCE_SYSTEM_ID ,
    ''PARADOX'' as SYSTEM_CODE ,
    J.REQ_ID as JOB_ID ,
    J.STATE as STATE ,
    J.CITY as CITY ,
    J.JOB_POSTING_DATE as JOB_POSTING_DATE ,
    J.JOB_CLOSING_DATE as JOB_CLOSING_DATE ,
    J.JOB_CREATED_DATE as JOB_CREATED_DATE ,
    J.JOB_TITLE as JOB_TITLE ,
   -- J.JOB_TITLE_CODE as JOB_TITLE_CODE ,
CASE WHEN LEN(J.JOB_TITLE_CODE)> 4 THEN NULL ELSE J.JOB_TITLE_CODE END  as JOB_TITLE_CODE ,    
J.JOB_FAMILY as JOB_FAMILY ,
   -- J.JOB_TITLE_CODE as JOB_FAMILY_CODE ,
CASE WHEN LEN(J.JOB_TITLE_CODE)> 4 THEN NULL ELSE J.JOB_TITLE_CODE END  as JOB_FAMILY_CODE ,   
 J.JOB_OWNER as JOB_OWNER ,
    J.JOB_OWNER_ID as JOB_OWNER_ID ,
    J.JOB_STATUS as JOB_STATUS ,
    J.LOCATION_NAME as LOCATION_NAME ,
    J.EXTERNAL_JOB_REFERENCE_NUMBER as EXTERNAL_JOB_REFERENCE_NUMBER ,
    J.ARCHIVED as ARCHIVED ,
    J.REQ_AGE as REQ_AGE ,
    J.REQ_AGE_GROUP as REQ_AGE_GROUP ,
    J.JOB_POSTING_LINK as JOB_POSTING_LINK,
        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                 
    CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
    CURRENT_USER AS ETL_INSERTED_BY,
    CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE,
    CURRENT_USER AS ETL_LAST_UPDATED_BY,
    0 AS ETL_DELETED_FLAG,
    BK.BRANCH_KEY as BRANCH_KEY
    from DISC_${var.SF_ENVIRONMENT}.PARADOX.OPEN_JOBS J
    INNER JOIN UNIQUE_JOBS UJ 
        ON UJ.EXTERNAL_JOB_REFERENCE_NUMBER = J.EXTERNAL_JOB_REFERENCE_NUMBER 
        AND IFNULL(UJ.JOB_CREATED_DATE, ''X'') = IFNULL(J.JOB_CREATED_DATE, ''X'')
        AND IFNULL(UJ.JOB_POSTING_DATE, ''X'') = IFNULL(J.JOB_POSTING_DATE, ''X'') AND UJ.RANK = 1
    LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.AMS_PARADOX_BRANCH_MAPPING BK 
	ON J.AREA__LEVEL_1 = BK.CANDIDATE_LOCATION__LEVEL_1 
	AND J.AREA__LEVEL_2 = BK.CANDIDATE_LOCATION__LEVEL_2 
	AND IFNULL(J.AREA__LEVEL_3, ''X'') = IFNULL(BK.CANDIDATE_LOCATION__LEVEL_3, ''X'')
    AND BK.ORIGINAL_SOURCE_SYSTEM_ID<>''12'';
	

    RETURN ''SUCCESS'';
    END;
    
 EOT
}

