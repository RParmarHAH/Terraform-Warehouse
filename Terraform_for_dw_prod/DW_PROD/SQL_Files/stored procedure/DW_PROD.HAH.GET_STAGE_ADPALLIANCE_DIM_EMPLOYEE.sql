CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ADPALLIANCE_DIM_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME: ADPALLIANCE_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row for each EMPLOYEE according to ADP-ALLIANCE
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 18/10/2022		Aditya Shukla / Jigar Prajapati			Initial Development
-- 25/08/2022		Abhishek Sunil							Revised Employee Category
-- 09/7/2023        Jainam Shah                             Added CASE Condition for Join between keys[SSN & PAYROLLID] ADPAlliance and GeneralAlliance and added nullif for address1 and address2
-- 10/11/2023		Shikhar Saxena							Updated Employee_ethnicity logic and added HISPANIC_OR_LATINO column
-- 13/12/2023		Saurav Purohit							Added Acquired_system field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ADPALLIANCE_DIM_EMPLOYEE
WITH SALARY AS (
	SELECT DISTINCT
		ROW_NUMBER() OVER (PARTITION BY TRIM(FILE_NUMBER) ORDER BY "PAY_DATE"::DATE DESC) AS RANK,
		FILE_NUMBER AS ID,
		RATE AS RATE,
		CASE WHEN "RATE_TYPE" = ''Hourly''
			THEN RATE * 40 * 52
			ELSE RATE * 12
		END AS SALARY
	FROM DISC_PROD.ADP.ALLIANCE_PAYROLL AP QUALIFY RANK = 1
),
PAYROLL AS (
	SELECT DISTINCT
		COMPANY_CODE, FILE_NUMBER,
		TERMINATION_DATE,
		MIN(PAY_DATE) AS FIRST_CHECK_DATE, 
		MAX(PAY_DATE) AS LAST_CHECK_DATE
	FROM DISC_PROD.ADP.ALLIANCE_PAYROLL AP
	GROUP BY 1, 2, 3
)
SELECT DISTINCT
	MD5(18 || ''ADP'' || AE.FILE_NUMBER || ''ALLIANCE'') AS EMPLOYEE_KEY,
	AE.FILE_NUMBER AS EMPLOYEE_ID,
	''ADP-ALLIANCE'' AS SYSTEM_CODE,
	18 AS SOURCE_SYSTEM_ID,
	HEX_ENCODE(SSN) AS EMPLOYEE_PID,
	TRY_TO_NUMBER(AE.FILE_NUMBER) AS EMPLOYEE_NUMBER,
	EMP.DATEOFBIRTH::DATE AS EMPLOYEE_DOB,
	NULL AS EMPLOYEE_DATE_OF_DEATH,
	AE.HIRE_DATE AS EMPLOYEE_HIRE_DATE,
	AE.REHIRE_DATE AS EMPLOYEE_REHIRE_DATE,
	NULL AS EMPLOYEE_BENEFIT_START_DATE,
	PAY.FIRST_CHECK_DATE AS EMPLOYEE_FIRST_CHECK_DATE,
	PAY.LAST_CHECK_DATE AS EMPLOYEE_LAST_CHECK_DATE,
	PAY.TERMINATION_DATE AS EMPLOYEE_LAST_WORKED_DATE,
	PAY.TERMINATION_DATE AS EMPLOYEE_TERMINATE_DATE,
	EMP.STR_REASON AS REASON_TO_TERMINATE,
	CASE WHEN AE.STATUS = ''A-Active''
		THEN TRUE
	WHEN AE.STATUS = ''T-Terminated'' OR AE.STATUS = ''D-Deceased''
		THEN FALSE
	ELSE FALSE
	END AS ACTIVE_EMPLOYEE_FLAG,
	CASE
		WHEN EMP.DONOTREHIRE= ''TRUE'' THEN FALSE
        WHEN EMP.DONOTREHIRE= ''FALSE'' THEN TRUE
		ELSE NULL
	 END AS ABLE_TO_REHIRE_FLAG,
	NULL AS EMPLOYEE_PREFIX,
	UPPER(TRIM(SPLIT_PART(AE."NAME", '','', 2))) AS EMPLOYEE_FIRST_NAME,
--	SPLIT_PART(TRIM(SPLIT_PART(AE."NAME", '','', 2)), '' '', 2) AS 
	NULL AS EMPLOYEE_MIDDLE_NAME,
	UPPER(TRIM(SPLIT_PART(AE."NAME", '','', 1))) AS EMPLOYEE_LAST_NAME,
	NULL AS EMPLOYEE_SUFFIX,
	NULLIF(TRIM(EMP.ADDRESS1),'''') AS EMPLOYEE_ADDRESS1,
	NULLIF(TRIM(EMP.ADDRESS2),'''') AS EMPLOYEE_ADDRESS2,
	TRIM(EMP.CITY) AS EMPLOYEE_CITY,
	TRIM(EMP.STATE) AS EMPLOYEE_STATE_CODE,
	EMP.ZIP AS EMPLOYEE_ZIP,
	NULLIF(LEFT(REGEXP_REPLACE(EMP.PHONE1, ''[^[:digit:]]'', ''''), 10), '''') AS EMPLOYEE_HOME_PHONE,
	NULLIF(LEFT(REGEXP_REPLACE(EMP.PHONE2, ''[^[:digit:]]'', ''''), 10), '''') AS EMPLOYEE_CELL_PHONE,
	NULL AS EMPLOYEE_WORK_PHONE,
	TRIM(EMP.EMAIL) AS EMPLOYEE_PERSONAL_EMAIL,
	NULL AS EMPLOYEE_WORK_EMAIL,
	NULL AS LINKED_IN_PROFILE_URL,
	AE.EMPLOYEE_GENDER AS EMPLOYEE_GENDER,
	NULL AS EMPLOYEE_ETHNICITY,
	FALSE AS HISPANIC_OR_LATINO,
	NULL AS EMPLOYEE_LANGUAGE,
	NULL AS EMPLOYEE_MARITAL_STATUS,
	AE.WORKER_CATEGORY AS EMPLOYEE_TYPE,
	CASE WHEN AE.EMPLOYEE_ID = ''7397'' 
			THEN ''ADMIN''
		WHEN (AE.WORKER_CATEGORY = ''F - Full Time'' OR AE.WORKER_CATEGORY = ''FT - Full-time'') AND RATE_TYPE = ''Salary''
			THEN ''ADMIN''
		WHEN (AE.WORKER_CATEGORY = ''F - Full Time'' OR AE.WORKER_CATEGORY = ''FT - Full-time'') AND RATE_TYPE = ''Hourly''
			THEN ''FIELD''
		WHEN (AE.WORKER_CATEGORY = ''P - Part Time'' OR AE.WORKER_CATEGORY = ''PT - Part-time'') AND RATE_TYPE = ''Salary''
			THEN ''ADMIN''
		WHEN (AE.WORKER_CATEGORY = ''P - Part Time'' OR AE.WORKER_CATEGORY = ''PT - Part-time'') AND RATE_TYPE = ''Hourly''
			THEN ''FIELD''
		WHEN (AE.WORKER_CATEGORY = ''VAR - Variable'' OR AE.WORKER_CATEGORY = ''VARI - Variable'') AND RATE_TYPE = ''Salary''
			THEN ''ADMIN''
		WHEN (AE.WORKER_CATEGORY = ''VAR - Variable'' OR AE.WORKER_CATEGORY = ''VARI - Variable'') AND RATE_TYPE = ''Hourly''
			THEN ''FIELD''
		WHEN AE.WORKER_CATEGORY IS NULL AND RATE_TYPE = ''Hourly''
			THEN ''FIELD''
		WHEN AE.WORKER_CATEGORY IS NULL AND RATE_TYPE = ''Salary''
			THEN ''ADMIN''
	END AS EMPLOYEE_CATEGORY,
	NULL AS EXEMPT_FLAG,
	AE.JOB_TITLE AS JOB_TITLE,
	NULL AS JOB_DESCRIPTION,
	NULL AS CLASS_ID,
	AE.NAICS_WORKERS_COMP AS WORKERS_COMP,			-- ask
	AE.FILE_NUMBER AS PAYROLL_ID,
	NULL AS PERCENT_401K_DEDUCTION,
	NULL AS AMOUNT_401K_DEDUCTION,
	NULL AS JAZZHR_APPLICANT_ID,
	NULL AS JAZZHR_USER_ID,
	NULL AS JAZZHR_CONTACT_ID,
	AE.WORKED_IN_STATE AS WORK_STATE,
	NULL AS SUTA_STATE,
	NULL AS EMPLOYEE_DEPARTMENT,
	NULL AS EMPLOYEE_OFFICE_CODE,
	COALESCE(BRANCH.BRANCH_KEY, MD5(''ADP'' || ''-'' || ''UNKNOWN'' || ''-'' || ''ALLIANCE'')) AS PRIMARY_BRANCH_KEY,
	BRANCH.OFFICE_STATE_CODE AS PRIMARY_BRANCH_STATE,
	COALESCE(BRANCH.BRANCH_NAME, ''UNKNOWN'') AS PRIMARY_BRANCH_NAME,
	BRANCH.SYSTEM_CODE AS PRIMARY_BRANCH_SYSTEM_CODE,
	NULL AS CASE_MANAGER_FLAG,
	NULL AS SUPERVISOR_FLAG,
	NULL AS COORDINATOR_FLAG,
	NULL AS LINKED_ID,
	HEX_ENCODE(SALARY.SALARY) AS SALARY,
	HEX_ENCODE(SALARY.RATE) AS PAY_RATE,
	IFF(AE.REHIRE_DATE IS NULL, IFF(AE.HIRE_DATE IS NULL, CAST(''1900-01-01'' AS DATE), AE.HIRE_DATE), AE.REHIRE_DATE) AS EFFECTIVE_FROM_DATE,				-- ASK
	IFF(AE.TERMINATION_DATE IS NULL, CAST(''2070-01-01'' AS DATE), AE.TERMINATION_DATE) AS EFFECTIVE_TO_DATE,
	NULL AS MDM_DIM_EMPLOYEE_KEY,
	-1 AS ETL_TASK_KEY,
	-1 AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG,
	FALSE AS ETL_INFERRED_MEMBER_FLAG,
	''ALLIANCE'' AS ACQUIRED_SYSTEM
FROM DISC_DEDUPE_PROD.ADP.ALLIANCE_EMPLOYEE_MASTER_LIST AE
LEFT JOIN PAYROLL AS PAY
	ON PAY.FILE_NUMBER = AE.FILE_NUMBER
LEFT JOIN DISC_DEDUPE_PROD.GENERATIONSALLIANCE.EMPLOYEE_MASTER_LIST EMP
	ON CASE WHEN AE."SSN" <> EMP."SOCIALSECURITYNUM" THEN AE."FILE_NUMBER" = EMP."PAYCHEXID" ELSE AE."SSN" = EMP."SOCIALSECURITYNUM" END
LEFT JOIN SALARY
	ON SALARY.ID = AE.FILE_NUMBER
LEFT JOIN DW_PROD."STAGE".ADPALLIANCE_DIM_BRANCH BRANCH
	ON UPPER(BRANCH.BRANCH_NAME) LIKE ''%'' || CASE WHEN "LOCATION" = ''STJOS - St. Joseph'' THEN ''ST.JOSEPH''
									ELSE UPPER(TRIM(SUBSTRING(LOCATION, CHARINDEX(''-'', "LOCATION") + 1))) END || ''%'';

SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
END;
';