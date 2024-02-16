resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_DIM_EMPLOYEE" {
	name ="GET_STAGE_MATRIXCARE_DIM_EMPLOYEE"
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
--******************************************************************************************************************************************
-- NAME:  MATRIXCARE_DIM_EMPLOYEE
--
-- PURPOSE: Creates one row per employee_id/database according to MatrixCare
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -------------------------------------------------------------------------------------------------------        
-- 04/29/21    Alex Marianyi		 Initial development
-- 06/08/21	   Shraddha Sejpal		 Removed duplicate Employees, added CAREGIVER CTE
-- 07/07/21	   Mir Ali				 Added Primary_Branch info
-- 07/19/21	   Shraddha Sejpal		 Added SUPERVISOR_FLAG CTE AND CASE_MANAGER_FLAG,SUPERVISOR_FLAG,COORDINATOR_FLAG
-- 03/31/23    Jashvant Patel	 	 Date Format modified as per American time
-- 04/18/23    Abhishek Sunil		 Cleaned up Employee Prefixes
-- 09/01/23	   Naresha Bhat			 Add PayRate Logic
-- 09/25/23	   Sandesh Gosavi	     Add PAYROLL_ID Logic	 
-- 11/10/2023  Trushali Ramoliya     Added a logic for HISPANIC_OR_LATINO and update the logic for ethnicity as per ticket - IDDOX- 388.
-- 12/06/2023  Trushali Ramoliya     Update logic for payroll_id
--******************************************************************************************************************************************
--


INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_EMPLOYEE
WITH 
SUPERVISOR_FLAG AS (
SELECT DISTINCT ADM.ADM_INTERNALCASEMGRID ,ADM.ADM_SUPERVISORID ,ADM.ADM_COORDINATORID FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONS ADM
),
ORIG_HIRE_DATE AS
(
	SELECT DISTINCT mcch.CARHR_CARID, MIN( mcch.CARHR_HIREDATE) AS ORIGINAL_HIRE_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
	WHERE mcch.CARHR_HIREDATE IS NOT NULL
	GROUP BY 1
),
REHIRE_DATE AS
(
	SELECT DISTINCT mcch.CARHR_CARID, MAX( mcch.CARHR_HIREDATE) AS MOST_RECENT_REHIRE_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
	LEFT OUTER JOIN ORIG_HIRE_DATE ohd ON TRIM( mcch.CARHR_CARID) = ohd.CARHR_CARID
	WHERE mcch.CARHR_HIREDATE IS NOT NULL AND mcch.CARHR_HIREDATE::DATE > ohd.ORIGINAL_HIRE_DATE::DATE
	GROUP BY 1
),
LAST_SERVICE_DATE AS
(
	SELECT DISTINCT mcch.CARHR_CARID, MAX( mcch.CARHR_LASTSERVICEDATE) AS LAST_SERVICE_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
	WHERE mcch.CARHR_LASTSERVICEDATE IS NOT NULL
	GROUP BY 1
),
LAST_TERM_DATE AS
(
	SELECT DISTINCT mcch.CARHR_CARID,
		FIRST_VALUE( mcch.CARHR_SEPARATIONDATE::DATE) IGNORE NULLS OVER( PARTITION BY mcch.CARHR_CARID
			ORDER BY mcch.CARHR_SEPARATIONDATE::DATE DESC)
			AS LAST_TERM_DATE,
		FIRST_VALUE( mcch.CARHR_SEPARATIONREASON) IGNORE NULLS OVER( PARTITION BY mcch.CARHR_CARID
			ORDER BY mcch.CARHR_SEPARATIONDATE::DATE DESC)
			AS LAST_TERM_REASON
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
	WHERE mcch.CARHR_SEPARATIONDATE::DATE IS NOT NULL
),
EMP_CAT AS
(
	SELECT DISTINCT CAR_ROLE,
		CASE WHEN CAR_ROLE IN (1,3) THEN ''FIELD'' ELSE ''ADMIN'' END AS CAR_ROLE_DESC
	FROM (SELECT DISTINCT CAR_ROLE FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST)
),
HOME_PHONE AS
(
	SELECT DISTINCT CPH_CAREGIVERID,
		FIRST_VALUE( TRIM( cgp.CPH_PHONE)) IGNORE NULLS OVER( PARTITION BY cgp.CPH_CAREGIVERID
			ORDER BY cgp.CPH_SEQUENCE, cgp.UPDATEDATE::DATE DESC, cgp.INSERTDATE::DATE DESC)
		AS EMPLOYEE_HOME_PHONE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERPHONES cgp
	LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PHONETYPE pt
		ON cgp.CPH_PHONETYPE = pt.PHT_ID
	WHERE cgp.DELETEDFLAG = FALSE AND UPPER( TRIM( pt.PHT_NAME)) LIKE ''%HOME%''
),
CELL_PHONE AS
(
	SELECT DISTINCT CPH_CAREGIVERID,
		FIRST_VALUE( TRIM( cgp.CPH_PHONE)) IGNORE NULLS OVER( PARTITION BY cgp.CPH_CAREGIVERID
			ORDER BY cgp.CPH_SEQUENCE, cgp.UPDATEDATE::DATE DESC, cgp.INSERTDATE::DATE DESC)
		AS EMPLOYEE_CELL_PHONE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERPHONES cgp
	LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PHONETYPE pt
		ON cgp.CPH_PHONETYPE = pt.PHT_ID
	WHERE cgp.DELETEDFLAG = FALSE AND UPPER( TRIM( pt.PHT_NAME)) LIKE ''%MOBILE%''
),
WORK_PHONE AS
(
	SELECT DISTINCT CPH_CAREGIVERID,
		FIRST_VALUE( TRIM( cgp.CPH_PHONE)) IGNORE NULLS OVER( PARTITION BY cgp.CPH_CAREGIVERID
			ORDER BY cgp.CPH_SEQUENCE, cgp.UPDATEDATE::DATE DESC, cgp.INSERTDATE::DATE DESC)
		AS EMPLOYEE_WORK_PHONE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERPHONES cgp
	LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PHONETYPE pt
		ON cgp.CPH_PHONETYPE = pt.PHT_ID
	WHERE cgp.DELETEDFLAG = FALSE AND UPPER( TRIM( pt.PHT_NAME)) LIKE ''%WORK%''
),
PAY_RATES AS (
	SELECT 
		E.CAR_ID AS CAREGIVERID,
		R.RATE_RATE1 AS PAY_RATE,
		ROW_NUMBER() OVER (PARTITION BY R.RATE_CAREGIVERID ORDER BY R.RATE_EFFECTIVESTARTDATE DESC,R.RATE_RATE1 DESC) AS rn
	FROM 
		DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST E
	INNER JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_RATES R
		ON E.CAR_ID = R.RATE_CAREGIVERID 
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SERVICECODE SC ON
	    R.RATE_SERVICECODEID = SC.SVCC_ID
	LEFT JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SKILLCATEGORIES SK
		ON SK.SKILLC_ID = E.CAR_SKILLCD
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES B ON
	    B.BR_ID = E.CAR_BRANCHID
	WHERE
	    TRIM(SC.SVCC_NAME) = ''Training'' AND B.BR_STATEORPROVINCE = ''MI'' AND (TRIM(SK.SKILLC_NAME) NOT IN (''RN - Field'', ''RN - Contract'', ''LPN'') OR TRIM(SK.SKILLC_NAME) IS NULL)
	QUALIFY RN = 1
	UNION ALL
	SELECT
		E.CAR_ID AS CAREGIVERID,
		R.RATE_RATE1 AS PAY_RATE,
		ROW_NUMBER() OVER (PARTITION BY R.RATE_CAREGIVERID ORDER BY R.RATE_EFFECTIVESTARTDATE DESC,R.RATE_RATE1 DESC) AS rn
	FROM 
		DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST E
	INNER JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_RATES R
		ON E.CAR_ID = R.RATE_CAREGIVERID
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SERVICECODE SC ON
	    R.RATE_SERVICECODEID = SC.SVCC_ID
	LEFT JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SKILLCATEGORIES SK
		ON SK.SKILLC_ID = E.CAR_SKILLCD
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES B ON
	    B.BR_ID = E.CAR_BRANCHID
	WHERE
	    SC.SVCC_NAME = ''ATTC'' AND B.BR_STATEORPROVINCE NOT IN (''MI'') AND (TRIM(SK.SKILLC_NAME) NOT IN (''RN - Field'', ''RN - Contract'', ''LPN'') OR TRIM(SK.SKILLC_NAME) IS NULL)-- Just FOR Indiana but saw same SVCC IN other states
	QUALIFY RN = 1 ---21,013 --19,664
	UNION ALL
	SELECT 
		E.CAR_ID AS CAREGIVERID,
		R.RATE_RATE1 AS PAY_RATE,
		ROW_NUMBER() OVER (PARTITION BY R.RATE_CAREGIVERID ORDER BY R.RATE_EFFECTIVESTARTDATE DESC,R.RATE_RATE1 DESC) AS rn
	FROM 
		DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST E
	INNER JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_RATES R
		ON E.CAR_ID = R.RATE_CAREGIVERID 
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SERVICECODE SC ON
	    R.RATE_SERVICECODEID = SC.SVCC_ID
	LEFT JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SKILLCATEGORIES SK
		ON SK.SKILLC_ID = E.CAR_SKILLCD
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES B ON
	    B.BR_ID = E.CAR_BRANCHID
	WHERE
	    TRIM(SC.SVCC_NAME) = ''RN Skilled Visit'' AND B.BR_STATEORPROVINCE = ''MI'' AND TRIM(SK.SKILLC_NAME) IN (''RN - Field'', ''RN - Contract'')
	QUALIFY RN = 1
	UNION ALL
	SELECT 
		E.CAR_ID AS CAREGIVERID,
		R.RATE_RATE1 AS PAY_RATE,
		ROW_NUMBER() OVER (PARTITION BY R.RATE_CAREGIVERID ORDER BY R.RATE_EFFECTIVESTARTDATE DESC,R.RATE_RATE1 DESC) AS rn
	FROM 
		DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST E
	INNER JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_RATES R
		ON E.CAR_ID = R.RATE_CAREGIVERID
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SERVICECODE SC ON
	    R.RATE_SERVICECODEID = SC.SVCC_ID
	LEFT JOIN
		DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SKILLCATEGORIES SK
		ON SK.SKILLC_ID = E.CAR_SKILLCD
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES B 
		ON B.BR_ID = E.CAR_BRANCHID
	WHERE
	    SC.SVCC_NAME = ''LPN'' AND B.BR_STATEORPROVINCE NOT IN (''MI'') AND TRIM(SK.SKILLC_NAME) IN (''LPN'') -- Just FOR Indiana but saw same SVCC IN other states
	QUALIFY RN = 1 ---21,013
),
PAYROLL AS 
(SELECT  DISTINCT 
CARBR_CAREGIVERID, 
FIRST_VALUE(carbr_ADPFileNum) OVER (PARTITION BY CARBR_CAREGIVERID,CARBR_BRANCH_ID ORDER BY CARBR_MODIFIEDDATE desc) carbr_ADPFileNum,
FIRST_VALUE(CARBR_BRANCH_ID) OVER (PARTITION BY CARBR_CAREGIVERID,CARBR_BRANCH_ID ORDER BY CARBR_MODIFIEDDATE desc) CARBR_BRANCH_ID
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVERBRANCHES 
)
SELECT DISTINCT MD5( ''MATRIXCARE'' || ''-'' || cg.MASTER_ID || ''-'' || ''MATRIXCARE'') AS EMPLOYEE_KEY,
	TRIM(cg.CAR_ID) AS EMPLOYEE_ID,
	''MATRIXCARE'' AS SYSTEM_CODE,
	7 AS SOURCE_SYSTEM_ID,
	CASE WHEN TRIM( cg.CAR_EMPSSN) NOT IN (SELECT SSN FROM Data_Management.Data_Quality.Invalid_SSN)
			AND TRIM( cg.CAR_EMPSSN) NOT LIKE ''00000%'' AND LENGTH( TRIM( cg.CAR_EMPSSN)) = 9
			THEN HEX_ENCODE( TRIM( cg.CAR_EMPSSN))
		 ELSE NULL
		END AS EMPLOYEE_PID,
	cg.CAR_ID AS EMPLOYEE_NUMBER,
	CASE WHEN cg.CAR_BIRTHDATE::DATE < ''1901-01-01''::DATE OR cg.CAR_BIRTHDATE::DATE > DATEADD( YEAR, -12, CURRENT_DATE) THEN NULL
		 ELSE cg.CAR_BIRTHDATE::DATE
				--TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', cg.CAR_BIRTHDATE)))
		END AS EMPLOYEE_DOB,
	NULL::DATE AS EMPLOYEE_DATE_OF_DEATH,
	ohd.ORIGINAL_HIRE_DATE::DATE AS EMPLOYEE_HIRE_DATE,
	--TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ohd.ORIGINAL_HIRE_DATE))) AS EMPLOYEE_HIRE_DATE,
	rhd.MOST_RECENT_REHIRE_DATE::DATE AS EMPLOYEE_REHIRE_DATE,
	--TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', rhd.MOST_RECENT_REHIRE_DATE))) AS EMPLOYEE_REHIRE_DATE,
	COALESCE( EMPLOYEE_REHIRE_DATE, EMPLOYEE_HIRE_DATE) AS EMPLOYEE_BENEFIT_START_DATE,
	NULL::DATE AS EMPLOYEE_FIRST_CHECK_DATE,
	NULL::DATE AS EMPLOYEE_LAST_CHECK_DATE,
	lsd.LAST_SERVICE_DATE AS EMPLOYEE_LAST_WORKED_DATE,
	--TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', lsd.LAST_SERVICE_DATE))) AS EMPLOYEE_LAST_WORKED_DATE,
	ltd.LAST_TERM_DATE AS EMPLOYEE_TERMINATE_DATE,
    --TO_DATE(DATEADD (MINUTE , 0, CONVERT_TIMEZONE(''America/New_York'', ltd.LAST_TERM_DATE))) AS EMPLOYEE_TERMINATE_DATE,
	LEFT( TRIM( ltd.LAST_TERM_REASON), 50) AS REASON_TO_TERMINATE,
	CASE WHEN TRIM( cg.CAR_STATUSID) IN (1 /*Active*/, 10005 /*Oriented/Awaiting Placement*/, 10007/*LOA*/) THEN TRUE ELSE FALSE END AS ACTIVE_EMPLOYEE_FLAG,
	NULL AS ABLE_TO_REHIRE_FLAG,
	CASE LEFT( UPPER( TRIM( cg.CAR_EMPSALUTID)), 20)
		WHEN ''10001'' THEN ''MR.''
		WHEN ''10002'' THEN ''MRS.''
		WHEN ''10004'' THEN ''MADAM''
		WHEN ''10005'' THEN ''MS.'' 
		ELSE LEFT( UPPER( TRIM( cg.CAR_EMPSALUTID)), 20) 
	END AS EMPLOYEE_PREFIX,			-- needs updated descriptions mapping (Dr. and Sir.)
	LEFT( UPPER( TRIM( cg.CAR_FIRSTNAME)), 50) AS EMPLOYEE_FIRST_NAME,
	LEFT( UPPER( TRIM( cg.CAR_MIDDLENAME)), 50) AS EMPLOYEE_MIDDLE_NAME,
	LEFT( UPPER( TRIM( cg.CAR_LASTNAME)), 50) AS EMPLOYEE_LAST_NAME,
	NULL AS EMPLOYEE_SUFFIX,
	LEFT( UPPER( TRIM( cg.CAR_ADDRESS1)), 150) AS EMPLOYEE_ADDRESS1,
	LEFT( UPPER( TRIM( cg.CAR_ADDRESS2)), 150) AS EMPLOYEE_ADDRESS2,
	LEFT( UPPER( TRIM( cg.CAR_CITY)), 50) AS EMPLOYEE_CITY,
	LEFT( UPPER( TRIM( cg.CAR_STATEORPROVINCE)), 2) AS EMPLOYEE_STATE_CODE,
	LEFT( TRIM( cg.CAR_POSTALCODE), 11) AS EMPLOYEE_ZIP,
	LEFT( TRIM( hph.EMPLOYEE_HOME_PHONE), 20) AS EMPLOYEE_HOME_PHONE,
	LEFT( TRIM( cph.EMPLOYEE_CELL_PHONE), 20) AS EMPLOYEE_CELL_PHONE,
	LEFT( TRIM( wph.EMPLOYEE_WORK_PHONE), 20) AS EMPLOYEE_WORK_PHONE,
	LEFT( UPPER( NVL( NULLIF( TRIM( cg.CAR_EMAIL1),''''), NULLIF( TRIM( cg.CAR_EMAIL2),''''))), 150) AS EMPLOYEE_PERSONAL_EMAIL,
	IFF( EMPLOYEE_PERSONAL_EMAIL = LEFT( UPPER( NULLIF( TRIM( cg.CAR_EMAIL2),'''')), 150), NULL, LEFT( UPPER( NULLIF( TRIM( cg.CAR_EMAIL2),'''')), 150)) AS EMPLOYEE_WORK_EMAIL,
	NULL AS LINKED_IN_PROFILE_URL,
	UPPER( TRIM( gen.GENDER_TEXT)) AS EMPLOYEE_GENDER,
    CASE WHEN UPPER( TRIM( race.RCE_NAME)) LIKE ''%INDIAN%ALASKA%'' THEN  UPPER(''American Indian or Alaska Native'')
		 WHEN UPPER( TRIM( race.RCE_NAME)) LIKE ''%MULTI%'' THEN UPPER(''Two or more'')
		 WHEN TRIM(race.RCE_NAME) ILIKE ''%Native Hawaiian or Pacific Islander%'' THEN UPPER(''Native Hawaiian or Other Pacific Islander'')
		 WHEN TRIM(race.RCE_NAME) ILIKE ANY (''%HISPANIC%'',''%LATINO%'',''%unknown%'') THEN NULL
		 ELSE UPPER(REPLACE( race.RCE_NAME,''-'','' ''))
		END AS EMPLOYEE_ETHNICITY,
	IFF(UPPER(TRIM(race.RCE_NAME)) ILIKE ANY(''HISPANIC%'',''LATINO%'',''HISPANIC OR LATINO%''), TRUE, FALSE) AS HISPANIC_OR_LATINO,
	NULL AS EMPLOYEE_LANGUAGE,
	UPPER( TRIM( mar.MARITALSTATUS_TEXT)) AS EMPLOYEE_MARITAL_STATUS,
	NULL AS EMPLOYEE_TYPE,
	UPPER(cat.CAR_ROLE_DESC) AS EMPLOYEE_CATEGORY,
	cg.CAR_EMPOTFLAG AS EXEMPT_FLAG,
	LEFT( UPPER( TRIM( cg.CAR_TITLE)), 20) AS JOB_TITLE,
	LEFT( UPPER( TRIM( cg.CAR_TITLE)), 20) AS JOB_DESCRIPTION,
	NULL AS CLASS_ID,
	NULL AS WORKERS_COMP,
	LEFT(TRIM(CAR.CARBR_ADPFILENUM),20)  AS PAYROLL_ID,
	NULL AS PERCENT_401K_DEDUCTION,
	NULL AS AMOUNT_401K_DEDUCTION,
	NULL AS JAZZHR_APPLICANT_ID,
	NULL AS JAZZHR_USER_ID,
	NULL AS JAZZHR_CONTACT_ID,
	LEFT( UPPER( TRIM( cg.CAR_WORKSTATE)), 20) AS WORK_STATE,
	LEFT( UPPER( TRIM( cg.CAR_WORKSTATE)), 20) AS SUTA_STATE,
	NULL AS EMPLOYEE_DEPARTMENT,
	NULL AS EMPLOYEE_OFFICE_CODE,
	COALESCE(BRANCH_MAPPING.CONVERGED_BRANCH_KEY, MD5(''MATRIXCARE'' || ''-'' || cg.CAR_BRANCHID::STRING || ''-'' || ''MATRIXCARE'')) AS PRIMARY_BRANCH_KEY,
	COALESCE(EMPLOYEE_BRANCH.OFFICE_STATE_CODE, ''IN'') AS PRIMARY_BRANCH_STATE,
	COALESCE(EMPLOYEE_BRANCH.DETAILED_OFFICE_NAME, BRANCH_MAPPING.CONVERGED_OFFICE_NAME) AS PRIMARY_BRANCH_NAME,
	COALESCE(EMPLOYEE_BRANCH.SYSTEM_CODE, BRANCH_MAPPING.CONVERGED_SYSTEM_CODE, ''MATRIXCARE'') AS PRIMARY_BRANCH_SYSTEM_CODE,
	CASE WHEN CMGR.ADM_INTERNALCASEMGRID IS NOT NULL OR CG.CAR_SKILLCD =''10004'' THEN TRUE ELSE FALSE END AS CASE_MANAGER_FLAG,
	CASE WHEN S.ADM_SUPERVISORID IS NOT NULL THEN TRUE ELSE FALSE END AS SUPERVISOR_FLAG,
	CASE WHEN CO.ADM_COORDINATORID IS NOT NULL THEN TRUE ELSE FALSE END AS COORDINATOR_FLAG,
	PR.PAY_RATE::FLOAT::VARCHAR AS PAY_RATE,
	TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
	NULL AS MDM_DIM_EMPLOYEE_KEY,   
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                            
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG,
	0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST cg
LEFT JOIN SUPERVISOR_FLAG CMGR ON CG.CAR_ID= CMGR.ADM_INTERNALCASEMGRID
LEFT JOIN SUPERVISOR_FLAG S ON CG.CAR_ID= S.ADM_SUPERVISORID
LEFT JOIN SUPERVISOR_FLAG CO ON CG.CAR_ID= CO.ADM_COORDINATORID
LEFT OUTER JOIN ORIG_HIRE_DATE ohd ON cg.CAR_ID = ohd.CARHR_CARID
LEFT OUTER JOIN REHIRE_DATE rhd ON cg.CAR_ID = rhd.CARHR_CARID
LEFT OUTER JOIN LAST_SERVICE_DATE lsd ON cg.CAR_ID = lsd.CARHR_CARID
LEFT OUTER JOIN LAST_TERM_DATE ltd ON cg.CAR_ID = ltd.CARHR_CARID
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_RACE race ON cg.CAR_RACEID = race.RCE_ID
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.VW_T_CAREGIVER_GENDER gen ON cg.CAR_EMPSEXID = gen.CAR_EMPSEXID
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.VW_T_CAREGIVER_MARITALSTATUS mar ON cg.CAR_MARITALSTATID = mar.CAR_MARITALSTATID
LEFT OUTER JOIN EMP_CAT cat ON cg.CAR_ROLE = cat.CAR_ROLE
LEFT OUTER JOIN PAYROLL car ON trim(car.CARBR_CAREGIVERID) = trim(cg.CAR_ID) AND trim(car.CARBR_BRANCH_ID) = trim(cg.CAR_BRANCHID)																																  
LEFT OUTER JOIN HOME_PHONE hph ON cg.CAR_ID = hph.CPH_CAREGIVERID
LEFT OUTER JOIN CELL_PHONE cph ON cg.CAR_ID = cph.CPH_CAREGIVERID
LEFT OUTER JOIN WORK_PHONE wph ON cg.CAR_ID = wph.CPH_CAREGIVERID
LEFT OUTER JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING AS BRANCH_MAPPING
	ON BRANCH_MAPPING.SOURCE_SYSTEM_ID = 7 AND BRANCH_MAPPING.SYSTEM_CODE = ''MATRIXCARE''
		AND BRANCH_MAPPING.OFFICE_CODE = cg.CAR_BRANCHID::STRING
LEFT OUTER JOIN HAH.DIM_BRANCH AS EMPLOYEE_BRANCH
	ON EMPLOYEE_BRANCH.SOURCE_SYSTEM_ID = 7 AND EMPLOYEE_BRANCH.SYSTEM_CODE = ''MATRIXCARE''
		AND EMPLOYEE_BRANCH.OFFICE_CODE = COALESCE(BRANCH_MAPPING.CONVERGED_OFFICE_CODE, cg.CAR_BRANCHID::STRING)
	LEFT JOIN PAY_RATES PR ON	
	     CG.CAR_ID = PR.CAREGIVERID
WHERE EMPLOYEE_FIRST_NAME NOT IN (''TEST'',''MATRIX'') AND EMPLOYEE_LAST_NAME NOT IN (''TEST'',''SUBJECT'',''TRAINING'') ;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

