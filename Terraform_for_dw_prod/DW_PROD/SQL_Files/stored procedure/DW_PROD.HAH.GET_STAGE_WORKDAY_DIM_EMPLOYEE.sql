CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_WORKDAY_DIM_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE 
	RETURN_RESULT VARCHAR(1000);
BEGIN
-------------------------------------------------------------------------------------------------------------------------------
/*
Object Type : 	Procedure
Object Name	: 	GET_STAGE_WORKDAY_DIM_EMPLOYEE
Author		:	Abhishek Sunil
Description :
	- This procedure populates the employees available in Workday
	- Contains the preboarded employees with the converted employees + new hires
*/

--*****************************************************************************************************************************
-- CHANGE LOG :
-- Version	Date(MM/DD/YYYY)	Author				Change Description
-- --------	----------------   	------------------	---------------------------------------------------------------------------
-- 1.0		09/13/2023    		Naresha Bhat		Initial Development
-- 1.1		09/20/2023			Abhishek Sunil		Optimized and Revised code
-- 1.2		10/23/2023			Abhishek Sunil		Added a condition to exclude duplicate employees
-- 1.3      10/30/2023          Jainam Shah         Added logic to exclude Employees which are in Rescinded Hire file. 
-- 1.4      11/10/2023          Deepen Gajjar       Updated employee ethnicity logic and added hispanic_or_latino field
-- 1.5      11/22/2023          Abhishek Sunil      Updating logic of EMPLOYEE_FIRST_CHECK_DATE,EMPLOYEE_LAST_CHECK_DATE as per ITXEE - 1468
-- 1.6		01/19/2023			Naresha Bhat		Including Historic PRE_BOARDING_COMPLETION records
-------------------------------------------------------------------------------------------------------------------------------	

INSERT OVERWRITE INTO STAGE.WORKDAY_DIM_EMPLOYEE

WITH SSN AS (
	SELECT
		EMPLOYEE_ID,
		ID,
		MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE 
	FROM
		DISC_PROD.WORKDAY.WORKER_IDENTIFICATION_DATA
	WHERE ID_TYPE = ''USA-SSN''
	GROUP BY EMPLOYEE_ID, ID
)
, NAME_DATA AS (
	SELECT
		EMPLOYEE_ID,
		NULLIF(TRIM(UPPER(FIRST_NAME)),'''') AS FIRST_NAME,
		NULLIF(TRIM(UPPER(MIDDLE_NAME)),'''') AS MIDDLE_NAME,
		NULLIF(TRIM(UPPER(LAST_NAME)),'''') AS LAST_NAME,
		NULLIF(TRIM(UPPER(TITLE)),'''') AS TITLE,
		NULLIF(TRIM(UPPER(SOCIAL_SUFFIX)),'''') AS SOCIAL_SUFFIX,
		MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE 
	FROM
		DISC_PROD.WORKDAY.WORKER_NAME_DATA
	WHERE NAME_TYPE = ''Legal''
	GROUP BY
		EMPLOYEE_ID, FIRST_NAME, MIDDLE_NAME, LAST_NAME, TITLE, SOCIAL_SUFFIX
)
, HOME_ADDRESS_DATA AS (
	SELECT
		WAD.EMPLOYEE_ID,
		NULLIF(UPPER(TRIM(WAD.ADDRESS_LINE_DATA)),'''') AS ADDRESS_LINE_1,
		NULLIF(UPPER(TRIM(WAD.ADDRESS_LINE_DATA_2)),'''') AS ADDRESS_LINE_2,
		NULLIF(UPPER(TRIM(WAD.MUNICIPALITY)),'''') AS CITY,
		NULLIF(UPPER(TRIM(WAD.REGION)),'''') AS STATE,
		SC.STATE_ISO_CODE,
		NULLIF(UPPER(TRIM(WAD.POSTAL_CODE)),'''') AS ZIP,
		MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM
		DISC_PROD.WORKDAY.WORKER_ADDRESS_DATA WAD
	LEFT JOIN DW_PROD.HAH.DIM_STATE SC 
		ON NULLIF(TRIM(UPPER(WAD.REGION)),'''') = UPPER(SC.STATE_NAME)
	WHERE WAD.ADDRESS_TYPE = ''HOME'' AND WAD.IS_PRIMARY = TRUE
	GROUP BY
		WAD.EMPLOYEE_ID, WAD.ADDRESS_LINE_DATA, WAD.ADDRESS_LINE_DATA_2, WAD.MUNICIPALITY, WAD.REGION, SC.STATE_ISO_CODE, WAD.POSTAL_CODE
)
, PHONE_DATA AS (
	SELECT
		EMPLOYEE_ID,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_TYPE END) AS HOME_PHONE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_DEVICE_TYPE END) AS HOME_PHONE_DEVICE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_AREA_CODE END) AS HOME_PHONE_AREA_CODE,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_NUMBER END) AS HOME_PHONE_NUMBER,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_TYPE END) AS WORK_PHONE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_DEVICE_TYPE END) AS WORK_PHONE_DEVICE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_AREA_CODE END) AS WORK_PHONE_AREA_CODE,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_NUMBER END) AS WORK_PHONE_NUMBER,
		MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM
		(
			SELECT 
				EMPLOYEE_ID,
				NULLIF(UPPER(TRIM(PHONE_TYPE)),'''') AS PHONE_TYPE,
				NULLIF(UPPER(TRIM(PHONE_DEVICE_TYPE)),'''') AS PHONE_DEVICE_TYPE,
				NULLIF(TRIM(PHONE_AREA_CODE),'''') AS PHONE_AREA_CODE,
				NULLIF(TRIM(PHONE_NUMBER),'''') AS PHONE_NUMBER,
				ETL_LAST_UPDATED_DATE
			FROM DISC_PROD.WORKDAY.WORKER_PHONE_DATA
			WHERE IS_PRIMARY = TRUE
		)
	GROUP BY EMPLOYEE_ID
)
, EMAIL_DATA AS (
	SELECT
		EMPLOYEE_ID,
		MAX(CASE WHEN EMAIL_TYPE = ''HOME'' THEN EMAIL_ADDRESS END) AS HOME_EMAIL_ADDRESS,
		MAX(CASE WHEN EMAIL_TYPE = ''WORK'' THEN EMAIL_ADDRESS END) AS WORK_EMAIL_ADDRESS,
		MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM
		(
			SELECT 
				EMPLOYEE_ID,
				NULLIF(UPPER(TRIM(EMAIL_TYPE)),'''') AS EMAIL_TYPE,
				NULLIF(UPPER(TRIM(EMAIL_ADDRESS)),'''') AS EMAIL_ADDRESS,
				ETL_LAST_UPDATED_DATE
			FROM DISC_PROD.WORKDAY.WORKER_EMAIL_DATA
			WHERE IS_PRIMARY = TRUE
		)
	GROUP BY 
		EMPLOYEE_ID
)
, EMPLOYEE_ORG_DATA AS (
    SELECT
        S.EMPLOYEE_ID,
        MAX(CASE WHEN OD.ORG_TYPE = ''Company_Hierarchy'' AND OD.ORG_SUBTYPE = ''Company Hierarchy'' THEN UPPER(TRIM(OD.ORG_NAME)) END) AS PAYROLL_SYSTEM,
        MAX(CASE WHEN OD.ORG_TYPE = ''Location_Hierarchy'' AND OD.ORG_SUBTYPE = ''Geographic_Division'' THEN UPPER(TRIM(OD.ORG_NAME)) END) AS "LOCATION",
        MAX(CASE WHEN OD.ORG_TYPE = ''Cost_Center'' AND OD.ORG_SUBTYPE = ''Cost Center'' THEN UPPER(TRIM(OD.ORG)) END) AS EMP_DEP,
        MAX(OD.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
    FROM DISC_PROD.WORKDAY.WORKER_SUMMARY S
    LEFT JOIN 
    	(
	    	SELECT
	    		EMPLOYEE_ID,
	    		NULLIF(UPPER(TRIM(ORGANIZATION)),'''') AS ORG,
				NULLIF(UPPER(TRIM(ORGANIZATION_NAME)),'''') AS ORG_NAME,
				ORGANIZATION_TYPE AS ORG_TYPE,
				ORGANIZATION_SUBTYPE AS ORG_SUBTYPE,
				ETL_LAST_UPDATED_DATE
	    	FROM DISC_PROD.WORKDAY.WORKER_ORGANIZATION_DATA
    	) OD
        ON OD.EMPLOYEE_ID = S.EMPLOYEE_ID
    WHERE
        (OD.ORG_TYPE = ''Company_Hierarchy'' AND OD.ORG_SUBTYPE = ''Company Hierarchy'')
        OR (OD.ORG_TYPE = ''Location_Hierarchy'' AND OD.ORG_SUBTYPE = ''Geographic_Division'')
        OR (OD.ORG_TYPE = ''Cost_Center'' AND OD.ORG_SUBTYPE = ''Cost Center'')
    GROUP BY S.EMPLOYEE_ID
),
HIST_APPLICANTS AS (
	SELECT
		DISTINCT EMPLOYEE_ID 
	FROM
		DISC_PROD.WORKDAY.HIST_WORKER_ADDITIONAL_INFORMATION AD
	WHERE (TRIM(AD.PRE_BOARDING_COMPLETION)::BOOLEAN = 1 )
)
SELECT
	MD5(''WORKDAY'' 
		|| '' - '' || EM.EMPLOYEE_ID 
		|| '' - '' || ''WORKDAY'') AS EMPLOYEE_KEY,
	EM.EMPLOYEE_ID AS EMPLOYEE_ID,
	''WORKDAY'' AS SYSTEM_CODE,
	36 AS SOURCE_SYSTEM_ID,
	HEX_ENCODE(TRIM(ID.ID)) AS EMPLOYEE_PID,
	EM.EMPLOYEE_ID AS EMPLOYEE_NUMBER,
	PER.BIRTH_DATE AS EMPLOYEE_DOB,
	ADINFO.DATE_OF_DEATH::DATE AS EMPLOYEE_DATE_OF_DEATH,
	ST.ORIGINAL_HIRE_DATE AS EMPLOYEE_HIRE_DATE,
	CASE
		WHEN ST.REHIRE = TRUE THEN ST.HIRE_DATE
		ELSE NULL 
	END AS EMPLOYEE_REHIRE_DATE,
	NULL AS EMPLOYEE_BENEFIT_START_DATE,
	NULL AS EMPLOYEE_FIRST_CHECK_DATE,
	NULL AS EMPLOYEE_LAST_CHECK_DATE,
	NULL AS EMPLOYEE_LAST_WORKED_DATE,
	TO_DATE(ST.TERMINATION_DATE) AS EMPLOYEE_TERMINATE_DATE,
	NULLIF(TRIM(ST.PRIMARY_TERMINATION_REASON),'''') AS REASON_TO_TERMINATE,
	IFNULL(ST.ACTIVE,FALSE) AS ACTIVE_EMPLOYEE_FLAG, -- TEMP CHANGE NEED TO REMOVE THIS
	CASE
		WHEN ST.NOT_ELIGIBLE_FOR_HIRE = TRUE THEN FALSE
		ELSE TRUE
	END AS ABLE_TO_REHIRE_FLAG,
	NA.TITLE AS EMPLOYEE_PREFIX,
	NA.FIRST_NAME AS EMPLOYEE_FIRST_NAME,
	NA.MIDDLE_NAME AS EMPLOYEE_MIDDLE_NAME,
	NA.LAST_NAME AS EMPLOYEE_LAST_NAME,
	NA.SOCIAL_SUFFIX AS EMPLOYEE_SUFFIX,
	HOME_AD.ADDRESS_LINE_1 AS EMPLOYEE_ADDRESS1,
	HOME_AD.ADDRESS_LINE_2 AS EMPLOYEE_ADDRESS2,
	HOME_AD.CITY AS EMPLOYEE_CITY,
	HOME_AD.STATE_ISO_CODE AS EMPLOYEE_STATE_CODE,
	HOME_AD.ZIP AS EMPLOYEE_ZIP,
	CASE
		WHEN PD.HOME_PHONE_DEVICE_TYPE = ''LANDLINE'' 
			THEN NVL(CONCAT(PD.HOME_PHONE_AREA_CODE, PD.HOME_PHONE_NUMBER),PD.HOME_PHONE_NUMBER)
	END AS EMPLOYEE_HOME_PHONE,
	CASE
		WHEN PD.HOME_PHONE_DEVICE_TYPE = ''MOBILE'' OR PD.WORK_PHONE_DEVICE_TYPE = ''Mobile'' 
			THEN NVL(
					NVL(CONCAT(PD.HOME_PHONE_AREA_CODE ,PD.HOME_PHONE_NUMBER),PD.HOME_PHONE_NUMBER),
					NVL(CONCAT(PD.WORK_PHONE_AREA_CODE ,PD.WORK_PHONE_NUMBER),PD.WORK_PHONE_NUMBER)
					)
	END AS EMPLOYEE_CELL_PHONE,
	CASE
		WHEN PD.WORK_PHONE_TYPE IS NOT NULL
			THEN NVL(CONCAT(PD.WORK_PHONE_AREA_CODE, PD.WORK_PHONE_NUMBER),PD.WORK_PHONE_NUMBER)
	END AS EMPLOYEE_WORK_PHONE,
	ED.HOME_EMAIL_ADDRESS AS EMPLOYEE_PERSONAL_EMAIL,
	ED.WORK_EMAIL_ADDRESS AS EMPLOYEE_WORK_EMAIL,
	NULL AS LINKED_IN_PROFILE_URL,
	NULLIF(UPPER(TRIM(PER.GENDER)),'''') AS EMPLOYEE_GENDER,
	CASE 
		WHEN PER.ETHNICITY ILIKE ANY (''%HISPANIC%'') THEN NULL
		WHEN PER.ETHNICITY ILIKE ANY (''%DECLINE%'',''%OTHER%'') THEN ''UNKNOWN''
		WHEN PER.ETHNICITY ILIKE ''%RACES%'' THEN ''TWO OR MORE''
		WHEN  PER.ETHNICITY ILIKE ''%_%'' THEN REPLACE(REPLACE(NULLIF(UPPER(TRIM(PER.ETHNICITY)),''''),''USA_''),''_'','' '')
		ELSE NULL END  AS EMPLOYEE_ETHNICITY,
	CASE WHEN PER.ETHNICITY ILIKE ANY  (''%not%HISPANIC%OR%LATINO%'')THEN FALSE 
		  WHEN PER.ETHNICITY ILIKE ANY  (''%HISPANIC%OR%LATINO%'') THEN TRUE 
  	ELSE FALSE END AS HISPANIC_OR_LATINO,
	NULL AS EMPLOYEE_LANGUAGE,
	REPLACE(REPLACE(NULLIF(UPPER(TRIM(PER.MARITAL_STATUS)),''''),''USA_''),''_'','' '') AS EMPLOYEE_MARITAL_STATUS,
	REPLACE(NULLIF(UPPER(TRIM(POS.POSITION_TIME_TYPE)),''''),''_'','' '') AS EMPLOYEE_TYPE,
	CASE 
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''CAREGIVER'') THEN ''FIELD''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''FIELD ADMIN'') THEN ''ADMIN''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''AGENCY'',''FSC'') THEN ''CORP''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''CONTINGENT'',''CONTRACTOR'') THEN ''CONTRACTOR''
		WHEN UPPER(TRIM(POS.WORKER_TYPE)) IN (''INTERN'') THEN ''INTERN''
		ELSE UPPER(TRIM(POS.WORKER_TYPE))
	END AS EMPLOYEE_CATEGORY, -- Need TO be reviewed
	POS.JOB_EXEMPT AS EXEMPT_FLAG,
	NULLIF(UPPER(TRIM(POS.POSITION_TITLE)),'''') AS JOB_TITLE,
	NULLIF(UPPER(TRIM(POS.BUSINESS_TITLE)),'''') AS JOB_DESCRIPTION,
	CASE 
		WHEN POS.JOB_EXEMPT = TRUE THEN ''EXEMPT'' 
		ELSE NULL 
	END AS CLASS_ID,
	NULL AS WORKERS_COMP,
	ADINFO.GP_ID AS PAYROLL_ID,
	NULL AS PERCENT_401K_DEDUCTION,
	NULL AS AMOUNT_401K_DEDUCTION,
	NULL AS JAZZHR_APPLICANT_ID,
	NULL AS JAZZHR_USER_ID,
	NULL AS JAZZHR_CONTACT_ID,
	WORK_ST.STATE_ISO_CODE AS WORK_STATE,
	NULL AS SUTA_STATE,
	ORG_D.EMP_DEP AS EMPLOYEE_DEPARTMENT,
	CASE 
		WHEN RE.BUSINESS_SITE_NAME IS NOT NULL THEN RE.BUSINESS_SITE::VARCHAR
		ELSE POS.BUSINESS_SITE::VARCHAR 
	END::VARCHAR AS EMPLOYEE_OFFICE_CODE,
	MD5(''WORKDAY'' 
	|| '' - '' || 
		CASE 
			WHEN RE.BUSINESS_SITE_NAME IS NOT NULL THEN UPPER(TRIM(RE.BUSINESS_SITE))
			ELSE UPPER(TRIM(POS.BUSINESS_SITE)) 
		END 
	|| '' - '' || ''WORKDAY'') AS PRIMARY_BRANCH_KEY,
	WORK_ST.STATE_ISO_CODE AS PRIMARY_BRANCH_STATE,
	WORK_ST.STATE_ISO_CODE 
	|| '' - '' || UPPER(TRIM(POS.BUSINESS_SITE_NAME)) 
	|| '' ('' ||
		CASE
			WHEN RE.BUSINESS_SITE_NAME IS NOT NULL THEN TRIM(RE.BUSINESS_SITE)
			ELSE TRIM(POS.BUSINESS_SITE)
		END
	|| '')'' AS PRIMARY_BRANCH_NAME,
	''WORKDAY'' AS PRIMARY_BRANCH_SYSTEM_CODE,
	NULL AS CASE_MANAGER_FLAG,
	NULL AS SUPERVISOR_FLAG,
	NULL AS COORDINATOR_FLAG,
	NULL AS LINKED_ID,
	HEX_ENCODE(NULLIF(TRIM(COMP.TOTAL_ANNUAL_BASE_PAY),'''')) AS SALARY,
	HEX_ENCODE(NULLIF(TRIM(COMP.TOTAL_BASE_PAY),'''')) AS PAY_RATE,
	NVL(ST.ORIGINAL_HIRE_DATE,''1900-01-01''::DATE)::TIMESTAMP_NTZ AS EFFECTIVE_FROM_DATE,
	NVL(ST.TERMINATION_DATE,''9999-12-31''::DATE)::TIMESTAMP_NTZ AS EFFECTIVE_TO_DATE,
	NULL AS MDM_DIM_EMPLOYEE_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	FALSE AS ETL_DELETED_FLAG,
	FALSE AS ETL_INFERRED_MEMBER_FLAG,
	NULL AS DERIVED_FIRST_SERVICE_DATE,
	NULL AS DERIVED_LAST_SERVICE_DATE,
	EMPLOYEE_FIRST_CHECK_DATE AS DERIVED_PAYROLL_FIRST_CHECK_DATE,
	EMPLOYEE_LAST_CHECK_DATE AS DERIVED_PAYROLL_LAST_CHECK_DATE,
	NULLIF(UPPER(TRIM(ADINFO.AMS_COST_CENTER_HIERARCHY)),'''') AS AMS_SOURCE_SYSTEM,
	ORG_D.PAYROLL_SYSTEM AS PAYROLL_SOURCE_SYSTEM,
	ORG_D."LOCATION" AS LOCATION_HIERARCHY,
	NULLIF(TRIM(ADINFO.PARADOX_PREHIRE_ID),'''') AS APPLICANT_ID,
	CASE 
		WHEN TRIM(ADINFO.SEND_TO_AMS) = ''0'' THEN ''NOT IN AMS''
		WHEN TRIM(ADINFO.SEND_TO_AMS) = ''1'' THEN ''IN AMS''
	END AS STATUS
FROM
	DISC_PROD.WORKDAY.WORKER_SUMMARY EM
LEFT JOIN
	SSN ID
	ON ID.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN 
	DISC_PROD.WORKDAY.WORKER_PERSONAL PER 
	ON PER.EMPLOYEE_ID = EM.EMPLOYEE_ID 
LEFT JOIN 
	DISC_PROD.WORKDAY.WORKER_ADDITIONAL_INFORMATION ADINFO
	ON ADINFO.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	DISC_PROD.WORKDAY.WORKER_STATUS ST
	ON ST.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	NAME_DATA NA
	ON NA.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	HOME_ADDRESS_DATA HOME_AD
	ON HOME_AD.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	DISC_PROD.WORKDAY.WORKER_POSITION_DATA POS
	ON POS.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	DW_PROD.HAH.DIM_STATE WORK_ST
	ON NULLIF(TRIM(UPPER(POS.BUSINESS_SITE_REGION)),'''') = UPPER(WORK_ST.STATE_NAME)
LEFT JOIN 
	DISC_PROD.WORKDAY.REMOTE_LOCATIONS RE
	ON POS.BUSINESS_SITE_NAME = RE.BUSINESS_SITE_NAME
LEFT JOIN 
	DISC_PROD.WORKDAY.WORKER_COMPENSATION COMP
	ON COMP.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	PHONE_DATA PD
	ON PD.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	EMAIL_DATA ED
	ON ED.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN
	EMPLOYEE_ORG_DATA ORG_D
	ON ORG_D.EMPLOYEE_ID = EM.EMPLOYEE_ID
LEFT JOIN 
	HIST_APPLICANTS HIST_APP
	ON HIST_APP.EMPLOYEE_ID = EM.EMPLOYEE_ID
WHERE
	HIST_APP.EMPLOYEE_ID IS NOT NULL
	AND TRIM(ST.PRIMARY_TERMINATION_REASON) IS DISTINCT FROM (''Terminate Employee > Reject > Duplicate Employee Record'')--- Cleanup duplicate records FROM SOURCE
	AND EM.EMPLOYEE_ID NOT IN (SELECT "CFI INT005 Worker ID LRV" FROM DISC_PROD.WORKDAY.WORKER_EXCLUDE_LIST)
	AND (EM.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
    OR PER.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
    OR ID.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz
    OR ADINFO.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
    OR ST.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ    
	OR NA.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::timestamp_ntz	
	OR HOME_AD.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
	OR POS.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
	OR COMP.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
	OR RE.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
	OR PD.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
	OR ED.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ
	OR ORG_D.ETL_LAST_UPDATED_DATE >=:STR_CDC_START::TIMESTAMP_NTZ);

SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :RETURN_RESULT FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
END;
';