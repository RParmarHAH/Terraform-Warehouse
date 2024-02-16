CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ASR_DIM_PARTNER_CONTRACT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    --*****************************************************************************************************************************
-- NAME:  ASR_DIM_PARTNER_CONTRACT
--
-- PURPOSE: Creates one row per PARTNER CONTRACT according to ASR
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/04/23    VIJAY SHARMA          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ASR_DIM_PARTNER_CONTRACT
WITH ALL_CONTRACTS AS (
	SELECT SERVICE_TYPE_ID, SERVICE_TYPE_NAME, 
		CASE 
			WHEN SERVICE_TYPE_ID  IN (1,2,3,4,5,6,7,8) THEN ''400-100'' -- These ARE OLD home care contracts 
			ELSE TRIM(GLACCOUNTNUMBER)
		END AS SEGMENT
	FROM DISC_PROD.ASR.ASR_SERVICETYPES S
	UNION
	SELECT ''0'' AS SERVICE_TYPE_ID, ''UNKNOWN'' AS SERVICE_TYPE_NAME, ''400-100'' -- DUMMY CONTRACT to retrieve orphan visits AND considered AS HomeCare
)
SELECT DISTINCT 
MD5(''PRIME'' || ''-'' || IFNULL(P.PAYERSOURCEID,-1)|| ''-'' || IFNULL(C.SERVICE_TYPE_ID,-1) || ''-'' || ''ASR'') AS PARTNER_CONTRACT_KEY
,''13'' AS SOURCE_SYSTEM_ID
,''PRIME'' AS SYSTEM_CODE
,''OH'' AS STATE
,MD5(''PRIME'' || ''-'' || IFNULL(P.PAYERSOURCEID,''-1'') || ''-'' || ''ASR'') AS PARTNER_KEY
,IFNULL(P.PAYERSOURCEID,''-1'') AS PARTNER_CODE
,IFNULL(P.PAYERSOURCENAME,''UNKNOWN'') AS PARTNER_NAME
,IFNULL(C.SERVICE_TYPE_ID,''-1'') AS CONTRACT_CODE
,IFNULL(C.SERVICE_TYPE_NAME,''UNKNOWN'') AS CONTRACT_NAME
,TRUE AS ACTIVE_FLAG --? 
,TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE --? 
,TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE --? 
---- ETL FIELDS ----
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	, CURRENT_USER AS ETL_INSERTED_BY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	, 0 AS ETL_DELETED_FLAG	
--FROM DISC_PROD.ASR.ASR_VISITS V
FROM  DISC_PROD.ASR.ASR_PLANOFSERVICE AS V
LEFT JOIN ALL_CONTRACTS C ON C.SERVICE_TYPE_ID = V.SERVICETYPE
LEFT JOIN DISC_PROD.ASR.ASR_PAYERSOURCES P ON P.PAYERSOURCEID = V.PAYERSOURCEID;
return ''SUCCESS'';
END;
';