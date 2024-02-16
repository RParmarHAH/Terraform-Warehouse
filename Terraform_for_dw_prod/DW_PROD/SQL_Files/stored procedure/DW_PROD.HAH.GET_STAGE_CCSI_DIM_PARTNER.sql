CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CCSI_DIM_PARTNER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    --*****************************************************************************************************************************
-- NAME:  CCSI_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to CCSI 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 10/27/23     SANKET JAIN          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.CCSI_DIM_PARTNER

SELECT DISTINCT MD5(''CCSI'' || ''-'' || UPPER(TRIM(PAYOR_ID)) || ''-'' || ''CCSI'') AS PARTNER_KEY
        , NULL  AS PARENT_PARTNER_KEY 
        , ''UNKNOWN'' AS PARENT_PARTNER_NAME
		, 8 AS SOURCE_SYSTEM_ID
		, ''CCSI'' AS SYSTEM_CODE
		, PAYOR_ID AS PARTNER_CODE
        , PAYOR_NAME AS PARTNER_NAME
        , NULL AS PARTNER_TYPE_CODE
        , NULL AS PARTNER_TYPE_NAME
		, TRUE  AS ACTIVE_FLAG
		, ''1990-01-01'' AS START_DATE
		, ''9999-12-31''END_DATE 
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
		, 0 AS ETL_INFERRED_MEMBER_FLAG 
FROM DISC_PROD.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING 
WHERE ORIGINAL_SOURCE_SYSTEM_ID = 8;

return ''SUCCESS'';
END;
';