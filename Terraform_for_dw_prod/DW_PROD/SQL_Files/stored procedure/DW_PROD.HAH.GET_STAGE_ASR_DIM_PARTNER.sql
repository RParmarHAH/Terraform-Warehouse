CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ASR_DIM_PARTNER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    --*****************************************************************************************************************************
-- NAME:  ASR_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to ASR 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/04/23     VIJAY SHARMA          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_PROD.STAGE.ASR_DIM_PARTNER
SELECT DISTINCT MD5(''PRIME'' || ''-'' || IFNULL(P.PAYERSOURCEID,''-1'') || ''-'' || ''ASR'') AS PARTNER_KEY,
 	NULL AS PARENT_PARTNER_KEY,
     ''UNKNOWN'' AS PARENT_PARTNER_NAME,
	''13'' AS SOURCE_SYSTEM_ID,
	''PRIME'' AS SYSTEM_CODE,
	P.PAYERSOURCENAME AS PARTNER_NAME,
	P.PAYERSOURCEID AS PARTNER_CODE,	
	TRUE AS ACTIVE_FLAG, --? 
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE, 
	TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE  
	---- ETL FIELDS ----
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	, CURRENT_USER AS ETL_INSERTED_BY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	, 0 AS ETL_DELETED_FLAG
	, 0 AS ETL_INFERRED_MEMBER_FLAG 
	FROM DISC_PROD.ASR.ASR_PAYERSOURCES P;

return ''SUCCESS'';
END;
';