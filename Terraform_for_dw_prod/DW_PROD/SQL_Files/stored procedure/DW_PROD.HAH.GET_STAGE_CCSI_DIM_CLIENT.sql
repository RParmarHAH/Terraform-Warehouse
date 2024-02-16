CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CCSI_DIM_CLIENT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
    --*****************************************************************************************************************************
-- NAME:  CCSI_DIM_CLIENT
--
-- PURPOSE: Creates one row per client according to CCSI
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/25/2021  JASHVANT PATEL        Initial development
-- 12/20/2021  ABHISHEK SUNIL        Changed FINAL_DATE join condition on CLIENT_IDOA_NO and AREA_2
-- 11/08/2023  Trushali Ramoliya    Added the column for HISPANIC_OR_LATINO and also updated the logic for ethnicity as per IDDOX - 388
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CCSI_DIM_CLIENT
WITH BASE_DATE AS 
(
	SELECT CLIENT_ID,DAY_OF_SERVICE , AREA_2 , TRY_TO_DATE(PERIOD_dATE, ''MMDDYY'') AS PERIOD_DATE , DAY_OF_SERVICE - DATE_PART(DAY, TRY_TO_DATE(PERIOD_dATE, ''MMDDYY'')) AS MNDIFF
	, CASE WHEN DAY_OF_SERVICE IS NULL THEN TRY_TO_DATE(PERIOD_dATE, ''MMDDYY'')
	ELSE DATEADD(DAY,DAY_OF_SERVICE - DATE_PART(DAY, TRY_TO_DATE(PERIOD_dATE, ''MMDDYY'')),TRY_TO_DATE(PERIOD_dATE, ''MMDDYY'')) END AS NEW_DATE, CLIENT_NAME 
	FROM DISC_PROD.CCSI.RAWVRFP 
	WHERE PERIOD_DATE NOT IN (''023121'',''093120'',''043121'',''063119'' )
)
,FINAL_DATE AS 
(
	SELECT CLIENT_ID, AREA_2 ,MIN(NEW_DATE) AS SERVICE_START_DATE, MAX(NEW_DATE) AS SERVICE_END_DATE, MIN (PERIOD_DATE) AS BEGIN_DATE, MAX(PERIOD_DATE) AS END_DATE
	FROM BASE_DATE
	GROUP BY 1,2
)
SELECT	MD5 ( M.RECORD_NUMBER  || ''-'' ||  NVL(M.USED_FOR_AREA, ''CCSI'') || ''-'' || ''CCSI'' ) AS CLIENT_KEY ,
	M.CLIENT_IDOA_NO AS CLIENT_NUMBER,
	''CCSI'' AS SYSTEM_CODE,
	8 AS SOURCE_SYSTEM_ID,
	MD5(NEW_FIELD_OLD_SSN) AS CLIENT_PID,	 
    NULL AS CLIENT_MEDICARE_ID,
	NULL AS MEDICAID_ID,
	TRY_TO_DATE(TO_varchar(M.DOB),''YYYYMMDD'') AS CLIENT_DOB,
	CASE WHEN M.ACTION_TYPE =''E'' THEN TRY_TO_DATE(M.ACTION_DATE,''YYYYMMDD'') 
	ELSE NULL END AS CLIENT_DATE_OF_DEATH,
	CASE WHEN UPPER(TRIM(M.SEX)) = ''M'' THEN ''MALE''
		 WHEN UPPER(TRIM(M.SEX)) = ''F'' THEN ''FEMALE''
	ELSE UPPER(TRIM(M.SEX)) END AS CLIENT_GENDER,         
	NULL AS CLIENT_ETHNICITY,  
	FALSE AS HISPANIC_OR_LATINO,						 
    NULL AS CLIENT_GENDER_IDENTITY, -- NA
	NULL AS CLIENT_SEXUAL_ORIENTATION, -- NA
	NULL AS CLIENT_RACE, -- NA
	NULL AS CLIENT_MARITAL_STATUS,
		CASE WHEN M.SEX =''M'' THEN ''MR.''
		WHEN M.SEX =''F'' THEN ''MS.''
		ELSE NULL END AS CLIENT_SALUTATION,
	M.FINAL_FIRST_NAME AS CLIENT_FIRST_NAME,
	NULL AS CLIENT_MIDDLE_NAME,
	M.FINAL_LAST_NAME  AS CLIENT_LAST_NAME,
	M.FINAL_CLIENT_NAME AS CLIENT_NAME,
	UPPER(TRIM(M.ADDRESS1))  AS CLIENT_ADDRESS1,
	UPPER(TRIM(M.ADDRESS2))  AS CLIENT_ADDRESS2,
	UPPER(TRIM(M.CITY))  AS CLIENT_CITY,
	UPPER(TRIM(COALESCE(ST1.STATE_ISO_CODE, ST2.STATE_ISO_CODE, Z.STATE_ISO_CODE, ''IL''))) AS CLIENT_STATE_CODE,
	TRIM(M.ZIP) AS CLIENT_ZIP,
	NULL AS CLIENT_CLN_ADDRESS1,
	NULL AS CLIENT_CLN_ADDRESS2,
	NULL AS CLIENT_CLN_CITY,
	NULL AS CLIENT_CLN_STATE_CODE,
	NULL AS CLIENT_CLN_ZIP,
	NULL AS CLIENT_STD_ADDRESS1,
	NULL AS CLIENT_STD_ADDRESS2,
	NULL AS CLIENT_STD_CITY,
	NULL AS CLIENT_STD_STATE_CODE,
	NULL AS CLIENT_STD_ZIP,
		CASE WHEN regexp_like(M.EMERGENCY_PHONE_CONTACT, ''.*[0-9].*'')  = TRUE 
		THEN M.EMERGENCY_PHONE_CONTACT ELSE NULL END AS CLIENT_HOME_PHONE,
	M.PHONE_NO AS CLIENT_CELL_PHONE,
	NULL AS CLIENT_WORK_PHONE,
	NULL AS CLIENT_FAX_NUMBER,
	NULL AS CLIENT_PERSONAL_EMAIL,
	CASE WHEN M.CREATED_ON IN (''19  /O'',''90529 36'') THEN M.CREATED_DATE  ELSE
		 CASE WHEN M.CREATED_DATE  IN (''/OV'') THEN  NULL
		 	  WHEN 	TRY_TO_DATE(M.CREATED_DATE,''MM/DD/YY'') < TRY_TO_DATE(CREATED_ON,''YYYYMMDD'')
		 	  THEN TRY_TO_DATE(M.CREATED_DATE,''MM/DD/YY'')
		ELSE TRY_TO_DATE(M.CREATED_ON,''YYYYMMDD'') END
	END AS REFERRAL_DATE,
	CASE WHEN DATEDIFF(day,F.BEGIN_DATE, F.SERVICE_START_DATE) < 0 THEN 0
	ELSE DATEDIFF(day,F.BEGIN_DATE, F.SERVICE_START_DATE) END 	AS DAYS_TO_SERVICE,        
	NULL AS CONTRACT_BEGIN_DATE,
	NULL AS CONTRACT_END_DATE,
	F.SERVICE_START_DATE AS FIRST_SERVICE_DATE,
	F.SERVICE_END_DATE AS LAST_SERVICE_DATE,
	F.BEGIN_DATE AS BEGIN_DATE,
	F.END_DATE AS END_DATE,
	CASE WHEN M.STATUS IN (''ACTIVE'') THEN TRUE
	ELSE FALSE END  AS ACTIVE_CLIENT_FLAG,
	NULL AS ON_HOLD_FLAG,
	NULL AS ON_HOLD_START_DATE,
	NULL AS ON_HOLD_END_DATE,
	NULL AS ACQUIRED_FROM_COMPANY_KEY,
	NULL AS ACQUIRED_FROM_COMPANY_ID,
	NULL AS ACQUIRED_FROM_COMPANY_FULL_NAME,
	NULL AS ACQUISITION_DATE,
	NULL AS ACQUISITION_FLAG,
	NULL AS ADMISSION_DATE,
	NULL AS ADMISSION_FLAG,
	NULL AS CLIENT_CONVERTED_FLAG,
	MD5(D.AREA ||''-''|| NVL(D.SUPERVISOR_INITIAL,''Unknown'') ||''-''|| ''CCSI'') AS PRIMARY_SUPERVISOR_KEY,
	CASE WHEN M.DESK_NO_ASSIGNED_SERV_COORD NOT IN (''19101007'') THEN M.DESK_NO_ASSIGNED_SERV_COORD ELSE NULL END AS PRIMARY_SUPERVISOR_CODE,
	UPPER(TRIM(D.SUPERVISOR_NAME))  AS PRIMARY_SUPERVISOR_NAME,
	NULL AS SECONDARY_SUPERVISOR_KEY,
	NULL AS SECONDARY_SUPERVISOR_CODE,
	NULL AS SECONDARY_SUPERVISOR_NAME,
	MD5(''CCSI'' || ''-'' || B.BRANCH_CODE || ''-'' || ''CCSI'')  AS PRIMARY_BRANCH_KEY,           
	UPPER(TRIM(B.BRANCH_NAME)) AS PRIMARY_BRANCH_NAME,
	''IL'' AS PRIMARY_BRANCH_STATE,
	NULL AS GUARANTOR_NAME,
	M.FAMILY_REASON AS NOTES,
	 TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
      TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
	  
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
	  
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
        
	  convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	  CURRENT_USER as ETL_INSERTED_BY ,
	  convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	  CURRENT_USER as ETL_LAST_UPDATED_BY,
	  0 as ETL_DELETED_FLAG,
	  0 as ETL_INFERRED_MEMBER_FLAG
	FROM DISC_DEDUPE_PROD.CCSI.CLIENT_MASTER_LIST_CCSI M   
	LEFT JOIN FINAL_DATE F ON UPPER(F.CLIENT_ID) = M.CLIENT_IDOA_NO AND M.USED_FOR_AREA = F.AREA_2 
	LEFT JOIN DISC_PROD.CCSI.DESKINFO D ON D.AREA = M.USED_FOR_AREA 
			AND D.DESK_DESIGNATOR = M.DESK_NO_ASSIGNED_SERV_COORD 
	LEFT JOIN DISC_PROD.CCSI.BRANCH_MAPPING B ON B.BRANCH_CODE = M.USED_FOR_AREA 
	LEFT JOIN HAH.DIM_STATE ST1 ON ST1.STATE_ISO_CODE = ''IL'' 
	LEFT JOIN HAH.DIM_STATE ST2 ON ST1.STATE_ISO_CODE IS NULL AND UPPER(ST2.STATE_NAME) = ''IL''
	LEFT JOIN HAH.DIM_ZIP_CODE Z ON ST1.STATE_ISO_CODE IS NULL AND ST2.STATE_ISO_CODE IS NULL AND Z.ZIP_CODE = LEFT(TRIM(M.ZIP), 5)
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          ';