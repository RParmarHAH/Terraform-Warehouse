create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_MATRIXCARE_DIM_EMPLOYEE(
	EMPLOYEE_KEY,
	EMPLOYEE_FIRST_NAME,
	EMPLOYEE_LAST_NAME
) as
WITH CAREGIVER AS 
(
SELECT * FROM (SELECT CG.*,M.MASTER_EMPLOYEE_NUMBER,
CASE WHEN M.MASTER_EMPLOYEE_KEY IS NOT NULL THEN 
(row_number() OVER(PARTITION BY M.MASTER_EMPLOYEE_KEY ORDER BY M.EMPLOYEE_NUMBER DESC)) ELSE 1 END AS RN
FROM DISC_PROD.MATRIXCARE.HIST_STVHC_T_CAREGIVER CG 
LEFT JOIN (SELECT * FROM DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_EMPLOYEE_MAPPING_ALL) M 
ON CG.CAR_ID = M.EMPLOYEE_NUMBER
WHERE cg.ETL_DELETED_FLAG= TRUE
AND CAST(cg.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.MATRIXCARE.HIST_STVHC_T_CAREGIVER)
) WHERE RN=1
),
SUPERVISOR_FLAG AS (
SELECT DISTINCT ADM.ADM_INTERNALCASEMGRID ,ADM.ADM_SUPERVISORID ,ADM.ADM_COORDINATORID FROM DISC_PROD.MATRIXCARE.STVHC_T_ADMISSIONS ADM
),
ORIG_HIRE_DATE AS
(
	SELECT DISTINCT mcch.CARHR_CARID, MIN( mcch.CARHR_HIREDATE) AS ORIGINAL_HIRE_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
	WHERE mcch.CARHR_HIREDATE IS NOT NULL
	GROUP BY 1
),
REHIRE_DATE AS
(
	SELECT DISTINCT mcch.CARHR_CARID, MAX( mcch.CARHR_HIREDATE) AS MOST_RECENT_REHIRE_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
	LEFT OUTER JOIN ORIG_HIRE_DATE ohd ON TRIM( mcch.CARHR_CARID) = ohd.CARHR_CARID
	WHERE mcch.CARHR_HIREDATE IS NOT NULL AND mcch.CARHR_HIREDATE::DATE > ohd.ORIGINAL_HIRE_DATE::DATE
	GROUP BY 1
),
LAST_SERVICE_DATE AS
(
	SELECT DISTINCT mcch.CARHR_CARID, MAX( mcch.CARHR_LASTSERVICEDATE) AS LAST_SERVICE_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
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
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERHIRING mcch
	WHERE mcch.CARHR_SEPARATIONDATE::DATE IS NOT NULL
),
EMP_CAT AS
(
	SELECT DISTINCT CAR_ROLE,
		CASE WHEN CAR_ROLE IN (1,3) THEN 'Field' ELSE 'Admin' END AS CAR_ROLE_DESC
	FROM (SELECT DISTINCT CAR_ROLE FROM CAREGIVER)
),
HOME_PHONE AS
(
	SELECT DISTINCT CPH_CAREGIVERID,
		FIRST_VALUE( TRIM( cgp.CPH_PHONE)) IGNORE NULLS OVER( PARTITION BY cgp.CPH_CAREGIVERID
			ORDER BY cgp.CPH_SEQUENCE, cgp.UPDATEDATE::DATE DESC, cgp.INSERTDATE::DATE DESC)
		AS EMPLOYEE_HOME_PHONE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERPHONES cgp
	LEFT OUTER JOIN DISC_PROD.MATRIXCARE.STVHC_T_PHONETYPE pt
		ON cgp.CPH_PHONETYPE = pt.PHT_ID
	WHERE cgp.DELETEDFLAG = FALSE AND UPPER( TRIM( pt.PHT_NAME)) LIKE '%HOME%'
),
CELL_PHONE AS
(
	SELECT DISTINCT CPH_CAREGIVERID,
		FIRST_VALUE( TRIM( cgp.CPH_PHONE)) IGNORE NULLS OVER( PARTITION BY cgp.CPH_CAREGIVERID
			ORDER BY cgp.CPH_SEQUENCE, cgp.UPDATEDATE::DATE DESC, cgp.INSERTDATE::DATE DESC)
		AS EMPLOYEE_CELL_PHONE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERPHONES cgp
	LEFT OUTER JOIN DISC_PROD.MATRIXCARE.STVHC_T_PHONETYPE pt
		ON cgp.CPH_PHONETYPE = pt.PHT_ID
	WHERE cgp.DELETEDFLAG = FALSE AND UPPER( TRIM( pt.PHT_NAME)) LIKE '%MOBILE%'
),
WORK_PHONE AS
(
	SELECT DISTINCT CPH_CAREGIVERID,
		FIRST_VALUE( TRIM( cgp.CPH_PHONE)) IGNORE NULLS OVER( PARTITION BY cgp.CPH_CAREGIVERID
			ORDER BY cgp.CPH_SEQUENCE, cgp.UPDATEDATE::DATE DESC, cgp.INSERTDATE::DATE DESC)
		AS EMPLOYEE_WORK_PHONE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_CAREGIVERPHONES cgp
	LEFT OUTER JOIN DISC_PROD.MATRIXCARE.STVHC_T_PHONETYPE pt
		ON cgp.CPH_PHONETYPE = pt.PHT_ID
	WHERE cgp.DELETEDFLAG = FALSE AND UPPER( TRIM( pt.PHT_NAME)) LIKE '%WORK%'
)
SELECT DISTINCT MD5( 'MATRIXCARE' || '-' || NVL(COALESCE (cg.MASTER_EMPLOYEE_NUMBER,cg.CAR_ID::STRING),'') || '-' || 'MATRIXCARE') AS EMPLOYEE_KEY,
LEFT( UPPER( TRIM( cg.CAR_FIRSTNAME)), 50) AS EMPLOYEE_FIRST_NAME,
LEFT( UPPER( TRIM( cg.CAR_LASTNAME)), 50) AS EMPLOYEE_LAST_NAME
FROM CAREGIVER cg
LEFT JOIN SUPERVISOR_FLAG CMGR ON CG.CAR_ID= CMGR.ADM_INTERNALCASEMGRID
LEFT JOIN SUPERVISOR_FLAG S ON CG.CAR_ID= S.ADM_SUPERVISORID
LEFT JOIN SUPERVISOR_FLAG CO ON CG.CAR_ID= CO.ADM_COORDINATORID
LEFT OUTER JOIN ORIG_HIRE_DATE ohd ON cg.CAR_ID = ohd.CARHR_CARID
LEFT OUTER JOIN REHIRE_DATE rhd ON cg.CAR_ID = rhd.CARHR_CARID
LEFT OUTER JOIN LAST_SERVICE_DATE lsd ON cg.CAR_ID = lsd.CARHR_CARID
LEFT OUTER JOIN LAST_TERM_DATE ltd ON cg.CAR_ID = ltd.CARHR_CARID
LEFT OUTER JOIN DISC_PROD.MATRIXCARE.STVHC_T_RACE race ON cg.CAR_RACEID = race.RCE_ID
LEFT OUTER JOIN DISC_PROD.MATRIXCARE.VW_T_CAREGIVER_GENDER gen ON cg.CAR_EMPSEXID = gen.CAR_EMPSEXID
LEFT OUTER JOIN DISC_PROD.MATRIXCARE.VW_T_CAREGIVER_MARITALSTATUS mar ON cg.CAR_MARITALSTATID = mar.CAR_MARITALSTATID
LEFT OUTER JOIN EMP_CAT cat ON cg.CAR_ROLE = cat.CAR_ROLE
LEFT OUTER JOIN HOME_PHONE hph ON cg.CAR_ID = hph.CPH_CAREGIVERID
LEFT OUTER JOIN CELL_PHONE cph ON cg.CAR_ID = cph.CPH_CAREGIVERID
LEFT OUTER JOIN WORK_PHONE wph ON cg.CAR_ID = wph.CPH_CAREGIVERID
LEFT OUTER JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING AS BRANCH_MAPPING
	ON BRANCH_MAPPING.SOURCE_SYSTEM_ID = 7 AND BRANCH_MAPPING.SYSTEM_CODE = 'MATRIXCARE'
		AND BRANCH_MAPPING.OFFICE_CODE = cg.CAR_BRANCHID::STRING
LEFT OUTER JOIN HAH.DIM_BRANCH AS EMPLOYEE_BRANCH
	ON EMPLOYEE_BRANCH.SOURCE_SYSTEM_ID = 7 AND EMPLOYEE_BRANCH.SYSTEM_CODE = 'MATRIXCARE'
		AND EMPLOYEE_BRANCH.OFFICE_CODE = COALESCE(BRANCH_MAPPING.CONVERGED_OFFICE_CODE, cg.CAR_BRANCHID::STRING)
WHERE EMPLOYEE_FIRST_NAME NOT IN ('TEST','MATRIX') AND EMPLOYEE_LAST_NAME NOT IN ('TEST','SUBJECT','TRAINING');