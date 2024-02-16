resource "snowflake_procedure" "DW_HAH_GET_STAGE_EMPEONPREFERRED_DIM_EMPLOYEE" {
	name ="GET_STAGE_EMPEONPREFERRED_DIM_EMPLOYEE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN

--*****************************************************************************************************************************
-- NAME: EMPEONPREFERRED_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row for each EMPLOYEE according to EMPEON-PREFERRED
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 18/10/2022		Aditya Shukla / Jigar Prajapati			Initial Development
-- 11/10/2023       Trushali Ramoliya                       Added a logic for HISPANIC_OR_LATINO and update the logic for ethnicity as per ticket - IDDOX- 388.
-- 13/12/2023       Saurav Purohit							Added ACQUIRED_SYSTEM column
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.EMPEONPREFERRED_DIM_EMPLOYEE

WITH RATE AS (
	SELECT 
		ROW_NUMBER() OVER (PARTITION BY TRIM(CO||trim(ID)) ORDER BY STARTDATE DESC) AS RANK,
		CO, TRIM(ID) AS ID,
		CASE WHEN SALARY = 0 
			THEN NULL 
			ELSE SALARY*52 
		END AS SALARY, 
		CASE WHEN RATE = 0 
			THEN NULL 
			ELSE RATE 
		END AS PAY_RATE
	FROM DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.ERATE QUALIFY RANK = 1        
)
, CHECK_DATES AS (
	SELECT DISTINCT 
		TRIM(ID) AS ID,
		MIN(CHECKDATE) AS EMPLOYEE_FIRST_CHECK_DATE,
		MAX(CHECKDATE) AS EMPLOYEE_LAST_CHECK_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EPAYHIST EPAY
	GROUP BY 1
),
ACTIVE_EMPLOYEES AS (
	SELECT DISTINCT 
		ROW_NUMBER() OVER (PARTITION BY TRIM(ES.ID) ORDER BY ES.STARTDATE DESC) AS RANK,
		TRIM(ES.ID) AS ID,
		ES.STATUS,
		CES.DESCRIPTION AS EMP_STATUS,
		ES.STARTDATE,
		ES.ELIGIBLEFORREHIRE
	FROM DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.ESTATUS ES
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.CEMPSTATUS CES
		ON CES.STATUS = ES.STATUS
	QUALIFY RANK = 1
)
SELECT DISTINCT 
	MD5(''EMPEON'' || ''-'' || MASTER_ID || ''EMPEONPREFERRED'') AS EMPLOYEE_KEY,
	TRIM(EML.ID) AS EMPLOYEE_ID,
	''EMPEONPREFERRED'' || ''-'' || TRIM(EML.CO) AS SYSTEM_CODE,
	22 AS SOURCE_SYSTEM_ID,
	HEX_ENCODE(TRIM(REPLACE(SSN, ''-''))) AS EMPLOYEE_PID,
	TRY_TO_NUMBER(EML.ID) AS EMPLOYEE_NUMBER,
	BIRTHDATE::DATE AS EMPLOYEE_DOB,
	NULL AS EMPLOYEE_DATE_OF_DEATH,
	HIREDATE::DATE AS EMPLOYEE_HIRE_DATE,
	REHIREDATE::DATE AS EMPLOYEE_REHIRE_DATE,
	NULL AS EMPLOYEE_BENEFIT_START_DATE,
	COALESCE(FIRSTPAYDATE, CD.EMPLOYEE_FIRST_CHECK_DATE)::DATE AS EMPLOYEE_FIRST_CHECK_DATE,
	COALESCE(LASTPAYDATE, CD.EMPLOYEE_LAST_CHECK_DATE)::DATE AS EMPLOYEE_LAST_CHECK_DATE,
	COALESCE(TERMDATE, CD.EMPLOYEE_LAST_CHECK_DATE)::DATE AS EMPLOYEE_LAST_WORKED_DATE,
	TERMDATE::DATE AS EMPLOYEE_TERMINATE_DATE,
	TRIM(TERMREASON) AS REASON_TO_TERMINATE,
	CASE 
		WHEN TERMDATE::DATE IS NOT NULL												-- FOR SCENARIO WHEN TERMINATE DATE IS NOT NULL, AND IS > HIREDATE / OR WHEN THERE''S NO PAY FOR 1+ YEARS
			AND (TERMDATE::DATE >= NVL(REHIREDATE::DATE, HIREDATE::DATE)
				OR DATEADD(''YEAR'', 1, COALESCE(CD.EMPLOYEE_LAST_CHECK_DATE, LASTPAYDATE)::DATE) <= current_date()
		) THEN FALSE
		WHEN TERMDATE::DATE IS NOT NULL AND TERMDATE::DATE > HIREDATE::DATE			-- FOR SCENARIO WHEN RECORD ONLY HAS HIREDATE AND TERMINATE DATE, AND TERM DATE IS > HIREDATE
			AND REHIREDATE::DATE IS NULL
			AND COALESCE(CD.EMPLOYEE_FIRST_CHECK_DATE, FIRSTPAYDATE)::DATE IS NULL 
			AND COALESCE(CD.EMPLOYEE_LAST_CHECK_DATE, LASTPAYDATE)::DATE IS NULL
		THEN FALSE
		WHEN TERMDATE::DATE IS NULL 												-- FOR SCENARIO WHEN RECORD DOESN''T HAVE TERMDATE BUT EMP HASN''T BEEN PAID FOR 1+ YEAR
			AND DATEADD(''YEAR'', 1, COALESCE(CD.EMPLOYEE_LAST_CHECK_DATE, LASTPAYDATE)::DATE) <= current_date() 
		THEN FALSE
		WHEN COALESCE(LEGACYEMPSTATUS, AE.STATUS) = ''T''								-- FOR SCENARIO WHEN SOURCE STATUS IS ''TERM'' AND REST DATE FIELDS ARE NULL
			AND TERMDATE::DATE IS NULL 
			AND COALESCE(CD.EMPLOYEE_FIRST_CHECK_DATE, FIRSTPAYDATE)::DATE IS NULL 
			AND COALESCE(CD.EMPLOYEE_LAST_CHECK_DATE, LASTPAYDATE)::DATE IS NULL 
		THEN FALSE
		WHEN COALESCE(LEGACYEMPSTATUS, AE.STATUS) = ''T'' 							-- FOR SCENARIO WHEN SOURC STATUS IS ''TERM'' AND EMP HASN''T BEEN PAID FOR 1+ YEAR AND TERM DATE IS NULL
			AND (DATEADD(''YEAR'', 1, COALESCE(CD.EMPLOYEE_LAST_CHECK_DATE, LASTPAYDATE)::DATE) <= current_date() 
			AND TERMDATE::DATE IS NULL)
		THEN FALSE 
		ELSE TRUE
	END AS ACTIVE_EMPLOYEE_FLAG,
	LEGACYELIGIBLEFORREHIRE AS ABLE_TO_REHIRE_FLAG,
	NULL AS EMPLOYEE_PREFIX,
	TRIM(UPPER(FIRSTNAME)) AS EMPLOYEE_FIRST_NAME,
	TRIM(UPPER(MIDDLENAME)) AS EMPLOYEE_MIDDLE_NAME,
	TRIM(UPPER(LASTNAME)) AS EMPLOYEE_LAST_NAME,
	NULL AS EMPLOYEE_SUFFIX,
	TRIM(UPPER(EML.ADDRESS1)) AS EMPLOYEE_ADDRESS1,
	TRIM(UPPER(EML.ADDRESS2)) AS EMPLOYEE_ADDRESS2,
	EML.CITY AS EMPLOYEE_CITY,
	EML.STATE AS EMPLOYEE_STATE_CODE,
	TRIM(EML.ZIP) AS EMPLOYEE_ZIP,
	TRIM(REPLACE(HOMEPHONE, ''-'')) AS EMPLOYEE_HOME_PHONE,
	TRIM(REPLACE(CELLPHONE, ''-'')) AS EMPLOYEE_CELL_PHONE,
	TRIM(REPLACE(WORKPHONE, ''-'')) AS EMPLOYEE_WORK_PHONE,
	EMAILADDRESS AS EMPLOYEE_PERSONAL_EMAIL,
	WORKEMAIL AS EMPLOYEE_WORK_EMAIL,
	NULL AS LINKED_IN_PROFILE_URL,
	CASE WHEN SEX = ''M'' THEN ''MALE''
		WHEN SEX = ''F'' THEN ''FEMALE''
		ELSE NULL 
	END AS EMPLOYEE_GENDER,
		TRIM(UPPER(
	CASE WHEN cE.DESCRIPTION ILIKE ANY (''%BLACK%'',''%African American%'') THEN ''Black or African American''
	 WHEN cE.DESCRIPTION ILIKE ANY (''%AMERICAN INDIAN%'',''%Alaska Native%'') THEN ''American Indian or Alaska Native''
	  WHEN cE.DESCRIPTION ILIKE ANY (''%PACIFIC ISLANDER%'',''%Native Hawaiian%'') THEN ''Native Hawaiian or Other Pacific Islander''
	  WHEN cE.DESCRIPTION ILIKE ANY (''%TWO OR MORE RACES%'',''%MULTIPLE%'') THEN ''TWO OR MORE''
	  WHEN cE.DESCRIPTION ILIKE ANY (''%HISPANIC%'',''%LATINO%'') THEN NULL
	  WHEN cE.DESCRIPTION ILIKE ANY (''%NOT APPLICABLE%'',''%NO ANSWER%'') OR LENGTH (TRIM(cE.DESCRIPTION)) = 1 THEN ''UNKNOWN'' 
	  ELSE 
	TRIM(UPPER(cE.DESCRIPTION)) END )) AS EMPLOYEE_ETHNICITY,
	IFF(UPPER(TRIM(ce.DESCRIPTION)) ILIKE ANY(''HISPANIC%'',''LATINO%'',''HISPANIC OR LATINO%''), TRUE, FALSE) AS HISPANIC_OR_LATINO,
	LANGUAGESSPOKEN AS EMPLOYEE_LANGUAGE,
	CASE WHEN MARITALSTATUS = ''M'' THEN ''MARRIED''
		WHEN MARITALSTATUS = ''S'' THEN ''SINGLE''
		ELSE NULL 
	END AS EMPLOYEE_MARITAL_STATUS,
	CASE 
		WHEN EML.CO IN (''3806A'',''7051E'') THEN ''FULL TIME''
		ELSE ''PART TIME'' 
	END AS EMPLOYEE_TYPE,
	CASE 
		WHEN EML.CO = ''3806A'' THEN ''ADMIN''
		WHEN EML.CO = ''7051E'' THEN ''CORP''
		ELSE ''FIELD''
	END AS EMPLOYEE_CATEGORY,
	NULL AS EXEMPT_FLAG,
	TRIM(COALESCE(CD2."NAME", CD1."NAME")) AS JOB_TITLE,
	NULL AS JOB_DESCRIPTION,
	NULL AS CLASS_ID,
	NULL AS WORKERS_COMP,
	TRIM(EML.ID) AS PAYROLL_ID,
	NULL AS PERCENT_401K_DEDUCTION,
	NULL AS AMOUNT_401K_DEDUCTION,
	NULL AS JAZZHR_APPLICANT_ID,
	NULL AS JAZZHR_USER_ID,
	NULL AS JAZZHR_CONTACT_ID,
	WORKSTATE AS WORK_STATE,
	''NY'' AS SUTA_STATE,
	NULL AS EMPLOYEE_DEPARTMENT,
	NULL AS EMPLOYEE_OFFICE_CODE,
	MD5(22 || ''-'' || TRIM(eml.CO) || ''-'' || ''EMPEONPREFERRED'') AS PRIMARY_BRANCH_KEY,
	NULL AS PRIMARY_BRANCH_STATE,
	NULL AS PRIMARY_BRANCH_NAME,
	NULL AS PRIMARY_BRANCH_SYSTEM_CODE,
	ISMANAGER::BOOLEAN AS CASE_MANAGER_FLAG,
	NULL AS SUPERVISOR_FLAG,
	NULL AS COORDINATOR_FLAG,
	NULL AS LINKED_ID,
	HEX_ENCODE(COALESCE(R.SALARY, R.PAY_RATE*40*52)) AS SALARY ,
	HEX_ENCODE(R.PAY_RATE) AS PAY_RATE,
	IFF(REHIREDATE IS NULL, IFF(HIREDATE IS NULL, CAST(''1900-01-01'' AS DATE), HIREDATE), REHIREDATE)::TIMESTAMP_NTZ(9) AS EFFECTIVE_FROM_DATE,
	IFF(TERMDATE IS NULL, CAST(''2099-12-31'' AS DATE), TERMDATE)::TIMESTAMP_NTZ(9) AS EFFECTIVE_TO_DATE,
	NULL AS MDM_DIM_EMPLOYEE_KEY,
		-1 AS ETL_TASK_KEY,
		-1 AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG,
		FALSE AS ETL_INFERRED_MEMBER_FLAG,
		''PREFERRED'' as ACQUIRED_SYSTEM
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EMPLOYEE_MASTER_LIST EML
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.CDEPT2 CD2
	ON TRIM(CD2.CO) = TRIM(EML.CO) AND UPPER(TRIM(CD2.CC2)) = UPPER(TRIM(EML.CC2))
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.CDEPT1 CD1
	ON TRIM(CD1.CO) = TRIM(EML.CO) AND UPPER(TRIM(CD1.CC1)) = UPPER(TRIM(EML.CC1))
LEFT JOIN RATE R ON R.CO = EML.CO AND TRIM(R.ID) = TRIM (EML.ID)
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.CETHNICITY CE
	ON TRIM(EML.ETHNICITY) = TRIM(CE.ETHNICITY)
LEFT JOIN CHECK_DATES CD
	ON TRIM(CD.ID) = TRIM(EML.ID)
LEFT JOIN ACTIVE_EMPLOYEES AE
	ON AE.ID = TRIM(EML.ID);
	
END;

 EOT
}

