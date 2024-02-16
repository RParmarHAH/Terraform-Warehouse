CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALAYACARE_FACT_PARTNER_CONTRACT_SERVICE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    --*****************************************************************************************************************************
-- NAME:  ALAYACARE_FACT_PARTNER_CONTRACT_SERVICE
--
-- PURPOSE: Creates one row per payor,contract,service,bill type  according to ALAYACARE
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- (MM/DD/YY)	
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 05/05/23    Sanket Jain           Initial development
-- 08/06/23	   Rajat Sapkal		     Modified initial logic
-- 12/25/23	   Shraddha Sejpal		 Added State 
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ALAYACARE_FACT_PARTNER_CONTRACT_SERVICE

SELECT DISTINCT MD5(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'' || ''-'' || F.FUNDER_ID || ''-'' || S.SERVICE_CODE_ID || ''-'' || 
NVL(BC.BILL_CODE_ID, ''-1'') || ''-'' || NVL(VISITS.VISIT_COMPUTED_RATE_UNITS, ''Unknown'') || ''-'' || ''ALAYACARE'') AS PARTNER_CONTRACT_SERVICE_KEY  --ADDED BILL_CODE_ID AND VISIT_COMPUTED_RATE_UNITS IN KEY AS WE HAVE PER SERVICE MULTIPLE BILL_CODES AND SCHEDULE TYPE
, 9 AS SOURCE_SYSTEM_ID
    , UPPER(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'') AS SYSTEM_CODE
	, CASE WHEN COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION=''Georgia'' THEN ''GA'' 
    	   WHEN COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION=''Alabama'' THEN ''AL'' ELSE COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION END AS STATE
    , MD5(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'' || ''-'' || F.FUNDER_ID || ''-'' || ''ALAYACARE'') AS PARTNER_CONTRACT_KEY
    , UPPER(COALESCE(F.MEDICAID_PAYER_CODE,F.CODE)) AS PARTNER_CODE
    , UPPER(COALESCE(F.MEDICAID_PAYER_NAME,F."NAME")) AS PARTNER_NAME
    , F.FUNDER_ID AS CONTRACT_CODE
    , UPPER(F."NAME") AS CONTRACT_NAME
,MD5(NVL(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(BC.BRANCH_ID,-1) || '')'' || ''-'' || 
NVL(TRIM(S.SERVICE_CODE_ID::STRING), ''Unknown'') || ''-'' || NVL(VISITS.VISIT_COMPUTED_RATE_UNITS, ''Unknown'') || ''-'' || 
NVL(CASE WHEN CHARINDEX(''HOMECARE'', REPLACE(UPPER(BC.GL_REVENUE_ACC_ACCOUNT_NAME), '' '', '''')) > 0
		THEN ''HC''
	WHEN CHARINDEX(''HOMEHEALTH'', REPLACE(UPPER(BC.GL_REVENUE_ACC_ACCOUNT_NAME), '' '', '''')) > 0
		THEN ''HH''
	ELSE ''NA'' END, ''NA'') || ''-'' || ''ALAYACARE'') AS SERVICE_KEY  
    , UPPER(S.SERVICE_CODE_ID) AS SERVICE_CODE 
    , UPPER(S.PROPERTIES_NAME) AS SERVICE_NAME 
    , NULL AS BILLING_KEY
    --, MD5(UPPER(TRIM(COMPANY.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || BC.BRANCH_ID || '')'') || ''-'' || BC.BILL_CODE_ID || ''-'' || BR.BILL_RATE_ID  || ''-'' || ''ALAYACARE'') AS BILLING_KEY --RAJAT 
    , UPPER(BC.BILL_CODE_ID) AS BILL_CODE 
    , UPPER(BC.CODE) AS BILL_NAME
    , IFF(BC.EXCLUDE_BILLING = ''yes'', FALSE, TRUE) AS BILLABLE_FLAG 
    , CASE WHEN BC.UNITS =''hours'' THEN ''Hourly'' 
               WHEN BC.UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END AS BILL_TYPE 
    , CASE WHEN BC.UNITS =''hours'' THEN ''Hourly'' 
               WHEN BC.UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END AS BILL_UOM 
    , CASE WHEN VISITS.VISIT_COMPUTED_RATE_UNITS =''hours'' THEN ''Hourly'' 
               WHEN VISITS.VISIT_COMPUTED_RATE_UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END
          AS SCHEDULE_TYPE 
    , CASE WHEN VISITS.VISIT_COMPUTED_RATE_UNITS =''hours'' THEN ''Hourly'' 
               WHEN VISITS.VISIT_COMPUTED_RATE_UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END
           AS SCHEDULE_UOM  
    , TRUE AS AUTHORIZATION_REQUIRED_FLAG 
    , TRUE AS PAYABLE_FLAG 
    , FALSE AS EXPENSE_FLAG 
    , FALSE AS MILEAGE_FLAG   
    ---- ETL FIELDS ----
    , :STR_ETL_TASK_KEY AS ETL_TASK_KEY
    , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
    , CURRENT_USER AS ETL_INSERTED_BY
    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
    , CURRENT_USER AS ETL_LAST_UPDATED_BY
    , 0 AS ETL_DELETED_FLAG
FROM DISC_PROD.ALAYACARE.FUNDER F 
LEFT JOIN DISC_PROD.ALAYACARE.SERVICE_CODE_BILL_CODE SBC ON F.FUNDER_ID = SBC.FUNDER_ID 
JOIN DISC_PROD.ALAYACARE.SERVICE_CODE S ON SBC.SERVICE_CODE_ID = S.SERVICE_CODE_ID
JOIN DISC_PROD.ALAYACARE.BILL_CODE AS BC ON BC.BILL_CODE_ID = SBC.BILL_CODE_ID 
LEFT JOIN DISC_PROD.ALAYACARE.BILL_RATE BR ON BC.BILL_CODE_ID = BR.BILL_CODE_ID 
LEFT JOIN DISC_PROD.ALAYACARE.BRANCH AS COMPANY
    ON COMPANY.BRANCH_ID = F.BRANCH_ID
--LEFT JOIN (SELECT DISTINCT s.SERVICE_FUNDER_ID,v.SERVICE_CODE_ID,VISIT_COMPUTED_RATE_UNITS,v.BRANCH_ID 
--FROM DISC_PROD.ALAYACARE.VISIT v JOIN DISC_PROD.ALAYACARE.SERVICE s ON v.SERVICE_ID =s.SERVICE_ID ) VISITS 
--ON VISITS.SERVICE_CODE_ID = S.SERVICE_CODE_ID AND VISITS.BRANCH_ID = NVL(BC.BRANCH_ID,-1) AND VISITS.SERVICE_FUNDER_ID=s1.SERVICE_FUNDER_ID
LEFT JOIN (SELECT DISTINCT SERVICE_CODE_ID,VISIT_COMPUTED_RATE_UNITS,BRANCH_ID FROM DISC_PROD.ALAYACARE.VISIT) 
--QUALIFY ROW_NUMBER()OVER(PARTITION BY SERVICE_CODE_ID,BRANCH_ID ORDER BY VISIT_COMPUTED_RATE_UNITS)=1) 
VISITS 
ON VISITS.SERVICE_CODE_ID = S.SERVICE_CODE_ID AND VISITS.BRANCH_ID = NVL(BC.BRANCH_ID,-1)
--LEFT JOIN (SELECT DISTINCT SERVICE_CODE_ID,VISIT_COMPUTED_RATE_UNITS,BRANCH_ID FROM DISC_PROD.ALAYACARE.VISIT ) VISITS 
--ON VISITS.SERVICE_CODE_ID = S.SERVICE_CODE_ID AND VISITS.BRANCH_ID = NVL(BC.BRANCH_ID,-1) --AND VISITS.VISIT_COMPUTED_RATE_UNITS = BC.PROPERTIES_UNITS
INNER JOIN DISC_PROD.ALAYACARE.CONFIGURATION CONFIG 
    ON CONFIG.SYSTEM_CODE= SYSTEM_CODE
    AND CONFIG.CONFIGURATION_ACTIVE= TRUE
    AND CONFIG.SYSTEM_CODE IS NOT NULL
UNION --as partner contract service is master table containing all combinations of partner,contract,service doing union to take all extra combinations coming from visit
SELECT DISTINCT MD5(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || VISITS.BRANCH_ID || '')'' || ''-'' || SERVICES.SERVICE_FUNDER_ID || ''-'' || NVL(TO_VARCHAR(NVL(VISITS.SERVICE_CODE_ID::INT,SERVICES.SERVICE_CODE_ID::INT)), ''Unknown'') || ''-'' || 
NVL(VISITS.VISIT_COMPUTED_RATE_BILLITEM_ID, ''-1'') || ''-'' || NVL(VISITS.VISIT_COMPUTED_RATE_UNITS, ''Unknown'') || ''-'' || ''ALAYACARE'') AS PARTNER_CONTRACT_SERVICE_KEY
, 9 AS SOURCE_SYSTEM_ID
    , UPPER(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'') AS SYSTEM_CODE
	, CASE WHEN B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION=''Georgia'' THEN ''GA'' 
    	   WHEN B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION=''Alabama'' THEN ''AL'' ELSE B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION END AS STATE
    , MD5(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || F.BRANCH_ID || '')'' || ''-'' || F.FUNDER_ID || ''-'' || ''ALAYACARE'') AS PARTNER_CONTRACT_KEY
    , UPPER(COALESCE(F.MEDICAID_PAYER_CODE,F.CODE)) AS PARTNER_CODE
    , UPPER(COALESCE(F.MEDICAID_PAYER_NAME,F."NAME")) AS PARTNER_NAME
    , F.FUNDER_ID AS CONTRACT_CODE
    , UPPER(F."NAME") AS CONTRACT_NAME
    ,MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(VISITS.BRANCH_ID,-1) || '')'' || ''-'' || 
      NVL(TO_VARCHAR(NVL(VISITS.SERVICE_CODE_ID::INT,SERVICES.SERVICE_CODE_ID::INT)), ''Unknown'') || ''-'' || NVL(VISITS.VISIT_COMPUTED_RATE_UNITS, ''Unknown'') || ''-'' || 
      NVL(CASE WHEN CHARINDEX(''HOMECARE'', REPLACE(UPPER(BC.GL_REVENUE_ACC_ACCOUNT_NAME), '' '', '''')) > 0
            THEN ''HC''
            WHEN CHARINDEX(''HOMEHEALTH'', REPLACE(UPPER(BC.GL_REVENUE_ACC_ACCOUNT_NAME), '' '', '''')) > 0
            THEN ''HH''
      ELSE ''NA'' END, ''NA'') || ''-'' || ''ALAYACARE'')SERVICE_KEY 
     ,NVL(TO_VARCHAR(NVL(VISITS.SERVICE_CODE_ID::INT,SERVICES.SERVICE_CODE_ID::INT)), ''Unknown'') AS SERVICE_CODE 
    , UPPER(S.PROPERTIES_NAME) AS SERVICE_NAME 
    , NULL AS BILLING_KEY
    , UPPER(VISITS.VISIT_COMPUTED_RATE_BILLITEM_ID) AS BILL_CODE 
    , UPPER(BC.CODE) AS BILL_NAME
    , IFF(BC.EXCLUDE_BILLING = ''yes'', FALSE, TRUE) AS BILLABLE_FLAG 
    , CASE WHEN BC.UNITS =''hours'' THEN ''Hourly'' 
               WHEN BC.UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END AS BILL_TYPE 
    , CASE WHEN BC.UNITS =''hours'' THEN ''Hourly'' 
               WHEN BC.UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END AS BILL_UOM  
    , CASE WHEN VISITS.VISIT_COMPUTED_RATE_UNITS =''hours'' THEN ''Hourly'' 
               WHEN VISITS.VISIT_COMPUTED_RATE_UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END
          AS SCHEDULE_TYPE 
    , CASE WHEN VISITS.VISIT_COMPUTED_RATE_UNITS =''hours'' THEN ''Hourly'' 
               WHEN VISITS.VISIT_COMPUTED_RATE_UNITS = ''visits'' THEN ''Visit''
          ELSE ''Unknown'' END
           AS SCHEDULE_UOM 
    , TRUE AS AUTHORIZATION_REQUIRED_FLAG 
    , TRUE AS PAYABLE_FLAG 
    , FALSE AS EXPENSE_FLAG 
    , FALSE AS MILEAGE_FLAG   
    ---- ETL FIELDS ----
    , :STR_ETL_TASK_KEY AS ETL_TASK_KEY
    , :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
    , CURRENT_USER AS ETL_INSERTED_BY
    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
    , CURRENT_USER AS ETL_LAST_UPDATED_BY
    , 0 AS ETL_DELETED_FLAG
FROM DISC_PROD.ALAYACARE.visit as VISITS 
LEFT JOIN DISC_PROD.ALAYACARE.SERVICE SERVICES ON SERVICES.SERVICE_ID =VISITS.SERVICE_ID
LEFT JOIN DISC_PROD.ALAYACARE.BRANCH B ON
VISITS.BRANCH_ID = B.BRANCH_ID
LEFT JOIN DISC_PROD.ALAYACARE.FUNDER F ON f.FUNDER_ID =SERVICES.SERVICE_FUNDER_ID 
LEFT JOIN DISC_PROD.ALAYACARE.BILL_CODE AS BC ON BC.BILL_CODE_ID = VISITS.VISIT_COMPUTED_RATE_BILLITEM_ID
LEFT JOIN DISC_PROD.ALAYACARE.SERVICE_CODE S ON S.SERVICE_CODE_ID =VISITS.SERVICE_CODE_ID
INNER JOIN DISC_PROD.ALAYACARE.CONFIGURATION CONFIG 
    ON CONFIG.SYSTEM_CODE= SYSTEM_CODE
    AND CONFIG.CONFIGURATION_ACTIVE= TRUE
    AND CONFIG.SYSTEM_CODE IS NOT NULL;

return ''SUCCESS'';
END;
';