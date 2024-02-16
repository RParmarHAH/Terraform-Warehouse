CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALAYACARE_DIM_PARTNER_CONTRACT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    --*****************************************************************************************************************************
-- NAME:  ALAYACARE_DIM_PARTNER_CONTRACT
--
-- PURPOSE: Creates one row per payor and contract according to ALAYACARE
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- (MM/DD/YY)	
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/05/23    Sanket Jain           Initial development
-- 12/25/23	   Shraddha Sejpal		 Added State
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ALAYACARE_DIM_PARTNER_CONTRACT

SELECT DISTINCT MD5(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'' || ''-'' || F.FUNDER_ID || ''-'' || ''ALAYACARE'') AS PARTNER_CONTRACT_KEY
	, 9  AS SOURCE_SYSTEM_ID
	, UPPER(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'') AS SYSTEM_CODE
	, NULL AS ORIGINAL_SOURCE_SYSTEM_ID
	, NULL AS ORIGINAL_SYSTEM_CODE
	, CASE WHEN COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION=''Georgia'' THEN ''GA''
    	   WHEN COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION=''Alabama'' THEN ''AL'' ELSE COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION END AS STATE
	, MD5(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'' || ''-'' || COALESCE(F.MEDICAID_PAYER_CODE,CODE) || ''-'' || COALESCE(F.MEDICAID_PAYER_NAME,"NAME") || ''-'' || ''ALAYACARE'') AS PARTNER_KEY
	, COALESCE(F.MEDICAID_PAYER_CODE,CODE) AS PARTNER_CODE
	, COALESCE(F.MEDICAID_PAYER_NAME,"NAME") AS PARTNER_NAME
	, F.FUNDER_ID AS CONTRACT_CODE
	, "NAME" AS CONTRACT_NAME
	, TRUE AS ACTIVE_FLAG 
	, TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE
	, TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE  
	---- ETL FIELDS ----
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	, CURRENT_USER AS ETL_INSERTED_BY
	, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	, 0 AS ETL_DELETED_FLAG
FROM DISC_PROD.ALAYACARE.FUNDER F 
LEFT JOIN DISC_PROD.ALAYACARE.BRANCH AS COMPANY
	ON COMPANY.BRANCH_ID = F.BRANCH_ID;

return ''SUCCESS'';
END;
';