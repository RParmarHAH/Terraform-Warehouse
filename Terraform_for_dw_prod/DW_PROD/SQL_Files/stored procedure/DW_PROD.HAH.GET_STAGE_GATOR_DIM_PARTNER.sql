CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_GATOR_DIM_PARTNER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'BEGIN
    --*****************************************************************************************************************************
-- NAME:  CENTENE_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER  
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 12/27/23    Meet Hariyani        Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_PROD.STAGE.GATOR_DIM_PARTNER
SELECT DISTINCT MD5(PARTNER_CODE || ''-'' || 29 || ''-'' || PARTNER_CODE) AS PARTNER_KEY
        		, NULL AS PARENT_PARTNER_KEY
        		, ''UNKNOWN'' AS PARENT_PARTNER_NAME
        		, 29 AS SOURCE_SYSTEM_ID
        		, ''GATOR'' AS SYSTEM_CODE
        		, PARTNER_NAME AS PARTNER_NAME	 
        		, PARTNER_CODE AS PARTNER_CODE
        		, IS_ACTIVE AS ACTIVE_FLAG 
       			, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE
        		, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE
       			---- ETL FIELDS ----
        		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
        		, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
        		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
        		, CURRENT_USER AS ETL_INSERTED_BY
        		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
        		, CURRENT_USER AS ETL_LAST_UPDATED_BY
        		, 0 AS ETL_DELETED_FLAG
        		, 0 AS ETL_INFERRED_MEMBER_FLAG
FROM DW_PROD.HAH.DIM_PARTNER_PROGRAM_MAPPING; 
RETURN ''SUCCESS'';
END';