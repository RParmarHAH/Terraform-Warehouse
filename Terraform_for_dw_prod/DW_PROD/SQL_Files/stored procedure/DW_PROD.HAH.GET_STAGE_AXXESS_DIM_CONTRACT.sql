CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_AXXESS_DIM_CONTRACT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/06/22    Abhishek Sunil        Initial Development
-- 04/04/22    Parag Gajjar          Logic Change
-- 05/04/22    Parag Gajjar          Dedup Leverage
-- 09/23/22	   POOJA SHAH 			 ENHANCEMENTS FOR HOMECARE
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.AXXESS_DIM_CONTRACT
SELECT    
	DISTINCT 
    MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(COALESCE(cd.EPISODE_PRIMARY_INSURANCE,A.PRIMARY_INSURANCE_NAME))),''UNKNOWN'') || ''-'' || ''AXXESS'') AS CONTRACT_KEY, --Pankti M.
    MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(COALESCE(cd.EPISODE_PRIMARY_INSURANCE,A.PRIMARY_INSURANCE_NAME))),''UNKNOWN'') || ''-'' || ''AXXESS'') AS CONTRACT_CODE,
    ''PRIME'' AS SYSTEM_CODE,
    14 AS SOURCE_SYSTEM_ID,  
    COALESCE(cd.EPISODE_PRIMARY_INSURANCE,A.PRIMARY_INSURANCE_NAME) AS CONTRACT_NAME, 
    NULL AS SERVICE_CODE_ID,
    NULL AS SERVICE_KEY,
    NULL AS DEFAULT_BILL_CODE,
    ''HHA'' AS PAYROLL_CODE,
    ''HH'' AS REVENUE_CATEGORY,
    ''HHA'' AS REVENUE_SUBCATEGORY_CODE,
    ''HOME HEALTH AIDE'' AS REVENUE_SUBCATEGORY_NAME,
    COALESCE(CD.PAYOR_TYPE,A.PAYOR_TYPE) AS PAYOR_CODE,
    COALESCE(CD.PAYOR_TYPE,A.PAYOR_TYPE) AS PAYOR_DESCRIPTION,
    NULL AS SERVICE_LINE_CODE,
    NULL AS SERVICE_LINE_DESCRIPTION,
    ''OH'' AS CONTRACT_STATE_CODE,
    NULL AS TIME_TRANSLATION_CODE,
    NULL AS TIME_TRANSLATION_DIVIDER,
    NULL AS PAY_TRAVELS_CODE,
    NULL AS MILEAGE_FLAG,
    TRUE AS PAYABLE_FLAG,
    TRUE AS BILLABLE_FLAG,  --Need To Make it True
    TRUE AS BILLED_BY_QUARTER_HOURS,
    TRUE AS BILLED_BY_HALF_HOURS,
	TO_DATE(''1900-01-01'',''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	TO_DATE(''9999-12-31'',''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
   	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,
    CURRENT_USER() AS ETL_INSERTED_BY,
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,
    CURRENT_USER() AS ETL_LAST_UPDATED_BY,
    FALSE AS ETL_DELETED_FLAG,
    TRUE AS ETL_INFERRED_MEMBER_FLAG 
FROM  DISC_PROD.AXXESS.VW_AXXESS_HH_VISITS_UPPER CD 
FULL OUTER  JOIN DISC_PROD.AXXESS.AXXESS_ARS A 
ON cd.EPISODE_PRIMARY_INSURANCE= a.PRIMARY_INSURANCE_NAME--DISC_PROD.AXXESS.AXXESS_AUTHORIZATIONS CD

 UNION ALL
--Below is the home care data

SELECT DISTINCT
	MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(FIN.PRIMARY_INSURANCE_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS CONTRACT_KEY,
    MD5(''PRIME'' || ''-'' || IFNULL(UPPER(TRIM(FIN.PRIMARY_INSURANCE_ID)),''UNKNOWN'') || ''-'' || ''AXXESS'') AS CONTRACT_CODE,
    ''PRIME'' AS SYSTEM_CODE,
    14 AS SOURCE_SYSTEM_ID,
    FIN.INSURANCE_NAME AS CONTRACT_NAME,
    NULL AS SERVICE_CODE_ID,
    NULL AS SERVICE_KEY,
    NULL AS DEFAULT_BILL_CODE,
    ''HC'' AS PAYROLL_CODE,
    ''HC'' AS REVENUE_CATEGORY,
    ''HC'' AS REVENUE_SUBCATEGORY_CODE,
    ''Home Care'' AS REVENUE_SUBCATEGORY_NAME,
    --''HC'' AS PAYOR_CODE,
    FIN.PAYOR_ID AS PAYOR_CODE,
   -- NULL AS PAYOR_DESCRIPTION,
    FIN.PAYOR_NAME AS PAYOR_DESCRIPTION,
    NULL AS SERVICE_LINE_CODE,
    NULL AS SERVICE_LINE_DESCRIPTION,
    ''OH'' AS CONTRACT_STATE_CODE,
    NULL AS TIME_TRANSLATION_CODE,
    NULL AS TIME_TRANSLATION_DIVIDER,
    NULL AS PAY_TRAVELS_CODE,
    NULL AS MILEAGE_FLAG,
    TRUE AS PAYABLE_FLAG,
    TRUE AS BILLABLE_FLAG,
    TRUE AS BILLED_BY_QUARTER_HOURS,
    TRUE AS BILLED_BY_HALF_HOURS,
	TO_DATE(''1900-01-01'',''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	TO_DATE(''9999-12-31'',''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
   	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,
    CURRENT_USER() AS ETL_INSERTED_BY,
    CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,
    CURRENT_USER() AS ETL_LAST_UPDATED_BY,
    FALSE AS ETL_DELETED_FLAG,
    TRUE AS ETL_INFERRED_MEMBER_FLAG 
FROM
(
SELECT DISTINCT PRIMARY_INSURANCE_ID,INSURANCE_NAME,PAYOR_ID,PAYOR_NAME 
FROM DISC_PROD.AXXESS.VW_AXXESS_HC_TASKDETAILS
WHERE PRIMARY_INSURANCE_ID IS NOT NULL AND INSURANCE_NAME IS NOT NULL
 ) FIN ;
RETURN ''SUCCESS'';
end;                        
';