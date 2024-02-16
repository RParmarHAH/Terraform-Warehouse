CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALAYACARE_FACT_ADMISSION("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  ALAYACARE_FACT_ADMISSION
--
-- PURPOSE: Creates one row per CLIENT, CONTRACT(FUNDER) AND SERVICE combination according to ALAYACARE
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                	NOTES:
-- --------    -------------------   	-----------------------------------------------------------------------------------------------
-- 12/14/22     Shraddha Sejpal         Initial development		
-- 06/22/23     Sandesh Gosavi 	 	    Modification in Initial development Logic 
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.ALAYACARE_FACT_ADMISSION
WITH CLIENT AS 
(
SELECT * FROM 
(
    SELECT CLIENT_ID,MASTER_ID,CLIENT_ID AS ORIGINAL_RECORD_ID,GUID,BRANCH_ID,ADMISSION_DATE,PROFILE_ID
    FROM DISC_DEDUPE_PROD.ALAYACARE.CLIENT_MASTER_LIST 
) 
UNION
SELECT * FROM 
(
    SELECT DISTINCT ID,MASTER_ID,ID AS ORIGINAL_RECORD_ID,GUID,BRANCH_ID, NULL AS ADMISSION_DATE,NULL AS PROFILE_ID
    FROM DISC_DEDUPE_PROD.ALAYACARE.CLIENT_MATCH_LIST 
    WHERE ID NOT IN (SELECT CLIENT_ID FROM DISC_DEDUPE_PROD.ALAYACARE.CLIENT_MASTER_LIST ) 
) 
)
SELECT DISTINCT
MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || ''-'' || 
NVL(C.BRANCH_ID,-1) || ''-'' || 
NVL(C.MASTER_ID::INT,-1)--S.SERVICE_CLIENT_ID 
 || ''-'' || 
S.SERVICE_FUNDER_ID || ''-'' || 
S.SERVICE_ID || ''-'' || NVL(VISITS.VISIT_COMPUTED_RATE_UNITS, ''Unknown'') || ''-'' || ''ALAYACARE'') AS CLIENT_ADMISSION_KEY,     
 9 AS SOURCE_SYSTEM_ID,     
 UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(C.BRANCH_ID,-1) || '')'') AS SYSTEM_CODE,              
 MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(C.BRANCH_ID,-1) || '')'' || ''-'' || NVL(C.MASTER_ID::INT,-1) || ''-'' || ''ALAYACARE'') AS CLIENT_KEY,
 MD5 (''ALAYACARE'' || ''-'' || NVL(P.PROFILE_ID, ''-1'') || ''-'' || ''ALAYACARE'') REFERRER_KEY,
 --MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(C.BRANCH_ID,-1) || '')'' || ''-'' || S.SERVICE_CODE_ID::STRING || ''-'' || ''ALAYACARE'') AS SERVICE_KEY,
MD5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || BC.BRANCH_ID || '')'' || ''-'' || 
NVL(TRIM(S.SERVICE_CODE_ID::STRING), ''Unknown'') || ''-'' || NVL(VISITS.VISIT_COMPUTED_RATE_UNITS, ''Unknown'') || ''-'' || 
NVL(CASE WHEN CHARINDEX(''HOMECARE'', REPLACE(UPPER(BC.GL_REVENUE_ACC_ACCOUNT_NAME), '' '', '''')) > 0
         THEN ''HC''
    WHEN CHARINDEX(''HOMEHEALTH'', REPLACE(UPPER(BC.GL_REVENUE_ACC_ACCOUNT_NAME), '' '', '''')) > 0
        THEN ''HH''
    ELSE ''NA'' END, ''NA'') || ''-'' || ''ALAYACARE'') AS SERVICE_KEY,
  
 MD5(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION) || '' ('' || S.BRANCH_ID || '')'' || ''-'' || S.SERVICE_FUNDER_ID || ''-'' || ''ALAYACARE'') AS PARTNER_CONTRACT_KEY,
 MD5 (NVL(S.SERVICE_ID,-1)|| '' ('' ||NVL(TRIM(S.CLIENT_DIAGNOSIS),''Unkonwn'') || '')'' || ''-'' || ''ALAYACARE'') AS PRIMARY_DIAGNOSIS_KEY,
 P.PROFILE_REFERRAL_DATE AS REFERRAL_DATE,            
 NULL AS REFERRAL_INTAKE_BY_EMP_KEY,
 NULL AS REFERRAL_ACCEPTED_SERVICES,
 P.PROFILE_REFERRAL_SOURCE AS REFERRAL_CAMPAIGN,
 NULL AS PREVIOUS_PROVIDER,       
 COALESCE(S.SERVICE_START_DATE,C.ADMISSION_DATE) AS ADMISSION_DATE,
-- CASE WHEN S.SERVICE_STATUS = ''discharged'' THEN 0 
--      WHEN S.SERVICE_STATUS = ''active'' THEN 1
--      WHEN S.SERVICE_STATUS = ''waiting_list'' THEN 0
--      WHEN S.SERVICE_STATUS = ''on_hold'' THEN 0 ELSE S.SERVICE_STATUS END AS STATUS,
S.SERVICE_STATUS AS STATUS,
 LEFT(S.CLIENT_DIAGNOSIS,200) AS PRIMARY_DIAGNOSIS,
 NULL AS DIAGNOSIS_NOTES,
 CASE WHEN S.SERVICE_STATUS = ''discharged'' THEN S.SERVICE_STATUS_DATE ELSE NULL END AS DISCHARGE_DATE,
 CASE WHEN S.SERVICE_STATUS = ''discharged'' THEN S.SERVICE_STATUS_REASON ELSE NULL END AS DISCHARGE_REASON,
 -- ETL Fields
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY              
        , CONVERT_TIMEZONE(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
        , CURRENT_USER AS ETL_INSERTED_BY
        , CONVERT_TIMEZONE(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
        , CURRENT_USER AS ETL_LAST_UPDATED_BY
        , 0 AS ETL_DELETED_FLAG         
 FROM DISC_PROD.ALAYACARE.SERVICE S
 LEFT JOIN CLIENT C ON C.CLIENT_ID= S.SERVICE_CLIENT_ID
 LEFT JOIN DISC_PROD.ALAYACARE.PROFILE P ON P.PROFILE_ID = C.PROFILE_ID
 LEFT JOIN DISC_PROD.ALAYACARE.BRANCH B ON B.BRANCH_ID= S.BRANCH_ID
 LEFT JOIN DISC_PROD.ALAYACARE.BILL_CODE BC ON BC.BILL_CODE_ID = S.SERVICE_BILL_CODE_ID
 LEFT JOIN (SELECT DISTINCT SERVICE_CODE_ID,VISIT_COMPUTED_RATE_UNITS,BRANCH_ID FROM DISC_PROD.ALAYACARE.VISIT 
QUALIFY ROW_NUMBER()OVER(PARTITION BY SERVICE_CODE_ID,BRANCH_ID ORDER BY VISIT_COMPUTED_RATE_UNITS)=1) VISITS 
ON VISITS.SERVICE_CODE_ID = S.SERVICE_CODE_ID AND VISITS.BRANCH_ID = NVL(BC.BRANCH_ID,-1);
-- LEFT JOIN (SELECT DISTINCT SERVICE_ID,SERVICE_CODE_ID,VISIT_COMPUTED_RATE_UNITS,BRANCH_ID FROM DISC_PROD.ALAYACARE.VISIT WHERE VISIT_COMPUTED_RATE_UNITS IS NOT NULL) VISITS 
-- ON VISITS.SERVICE_CODE_ID = S.SERVICE_CODE_ID AND VISITS.BRANCH_ID = NVL(BC.BRANCH_ID,-1);
  RETURN ''SUCCESS'';
    END;
    ';