CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_MOLINA_DIM_CLIENT_BAKUP_02082023("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME:  MOLINA_DIM_CLIENT
--
-- PURPOSE: Creates one row per CLIENT  
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/20/23     AKASH THAKKER          Initial development
--*****************************************************************************************************************************
TRUNCATE TABLE DW_PROD."STAGE".MOLINA_DIM_CLIENT;
INSERT ALL WHEN CLIENT_KEY IS NOT NULL AND CLIENT_NUMBER IS NOT NULL 
           THEN INTO DW_PROD."STAGE".MOLINA_DIM_CLIENT 
           WHEN CLIENT_KEY IS NULL OR CLIENT_NUMBER IS NULL 
           THEN INTO DW_PROD.HAH.MOLINA_EXCLUDE_CLIENT 

SELECT * FROM(SELECT MD5(''MOL'' || TRIM(MEDICAID_ID) || ''-'' || TRIM(FIRST_NAME) || ''-'' || TRIM(LAST_NAME) || ''-'' || ''MOLINA'') AS CLIENT_KEY ,
TRIM(EXTERNAL_ID) AS CLIENT_NUMBER ,
''MOLINA'' AS SYSTEM_CODE ,
32 AS SOURCE_SYSTEM_ID ,
SSN AS Client_PID ,
MEDICARE_ID AS CLIENT_MEDICARE_ID ,MEDICAID_ID ,TO_DATE(DATE_OF_BIRTH) AS CLIENT_DOB ,
NULL CLIENT_DATE_OF_DEATH ,NULL Client_GENDER ,NULL CLIENT_ETHNICITY ,NULL CLIENT_GENDER_IDENTITY ,
NULL CLIENT_SEXUAL_ORIENTATION ,NULL CLIENT_RACE ,NULL CLIENT_MARITAL_STATUS ,NULL CLIENT_SALUTATION ,
TRIM(FIRST_NAME) AS CLIENT_FIRST_NAME ,TRIM(MIDDLE_NAME) AS Client_MIDDLE_NAME ,
TRIM(LAST_NAME) AS CLIENT_LAST_NAME ,
TRIM(TO_CHAR(LAST_NAME)) || '','' || TRIM(TO_CHAR(FIRST_NAME)) || '','' || TRIM(TO_CHAR(MIDDLE_NAME)) AS CLIENT_NAME ,
STREET_ADDRESS AS Client_Address1 ,NULL Client_Address2 ,CITY AS Client_City ,NULL CLIENT_STATE_CODE ,
ZIP_CODE AS Client_Zip ,NULL CLIENT_CLN_ADDRESS1 ,NULL CLIENT_CLN_ADDRESS2 ,NULL CLIENT_CLN_CITY ,
NULL CLIENT_CLN_STATE_CODE ,NULL CLIENT_CLN_ZIP ,NULL CLIENT_STD_ADDRESS1 ,NULL CLIENT_STD_ADDRESS2 ,
NULL CLIENT_STD_CITY ,NULL CLIENT_STD_STATE_CODE ,NULL CLIENT_STD_ZIP ,NULL Client_Home_Phone ,
NULL Client_Cell_Phone ,NULL Client_Work_Phone ,NULL CLIENT_FAX_NUMBER ,EMAIL_ADDRESS AS CLIENT_PERSONAL_EMAIL ,
NULL REFERRAL_DATE ,NULL DAYS_TO_SERVICE ,NULL CONTRACT_BEGIN_DATE ,NULL CONTRACT_END_DATE ,
NULL FIRST_SERVICE_DATE ,NULL LAST_SERVICE_DATE ,NULL BEGIN_DATE ,NULL END_DATE ,
NULL ACTIVE_CLIENT_FLAG ,NULL On_Hold_Flag ,CAST( NULL AS DATE) AS On_Hold_Start_Date ,
CAST( NULL AS DATE) AS On_Hold_End_Date ,NULL LINKED_ID ,NULL ACQUIRED_FROM_COMPANY_KEY ,
NULL ACQUIRED_FROM_COMPANY_ID ,NULL ACQUIRED_FROM_COMPANY_FULL_NAME ,NULL ACQUISITION_DATE ,
NULL ACQUISITION_FLAG ,NULL ADMISSION_DATE ,NULL ADMISSION_FLAG ,NULL CLIENT_CONVERTED_FLAG ,
NULL PRIMARY_SUPERVISOR_KEY ,NULL PRIMARY_SUPERVISOR_CODE ,NULL PRIMARY_SUPERVISOR_NAME ,
NULL SECONDARY_SUPERVISOR_KEY ,NULL SECONDARY_SUPERVISOR_CODE ,NULL SECONDARY_SUPERVISOR_NAME ,
NULL PRIMARY_BRANCH_KEY ,NULL PRIMARY_BRANCH_NAME ,NULL PRIMARY_BRANCH_STATE ,NULL GUARANTOR_NAME ,
NULL NOTES ,NULL AGENCY ,TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE ,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE ,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY ,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE ,
CURRENT_USER as ETL_INSERTED_BY ,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE ,
CURRENT_USER as ETL_LAST_UPDATED_BY ,0 as ETL_DELETED_FLAG ,0 AS ETL_INFERRED_MEMBER_FLAG 
from DISC_PROD.MOLINA.MOLINA_SOURCE_DATA) DATA;

RETURN ''Done'';

END;
   
 
';