create or replace view DW_PROD.PUBLIC.WORKDAY_BASE_VIEW(
	EMPLOYEE_ID,
	FIRST_NAME,
	MIDDLE_NAME,
	LAST_NAME,
	SSN,
	BIRTH_DATE,
	ADDRESS_LINE_DATA,
	ADDRESS_LINE_DATA_2,
	MUNICIPALITY,
	REGION,
	POSTAL_CODE,
	HOME_PHONE,
	WORK_PHONE,
	HOME_EMAIL_ADDRESS,
	WORK_EMAIL_ADDRESS,
	AMS_COST_CENTER_HIERARCHY,
	LOCATION_HIERARCHY,
	WORKER_TYPE,
	PAY_RATE_TYPE,
	ACTIVE,
	ORIGINAL_HIRE_DATE,
	HIRE_DATE,
	TERMINATION_DATE,
	REHIRE,
	PRE_BOARDING_COMPLETION,
	SEND_TO_AMS,
	ON_EXCLUDE_LIST
) as
WITH ORG AS (
    SELECT
        EMPLOYEE_ID, ORGANIZATION_NAME
    FROM
        DISC_PROD.WORKDAY.WORKER_ORGANIZATION_DATA
    WHERE
        ORGANIZATION_TYPE = 'Location_Hierarchy'
        AND ORGANIZATION_SUBTYPE = 'Geographic_Division'
)
, EMAIL_DATA AS (
	SELECT
		EMPLOYEE_ID,
		MAX(CASE WHEN EMAIL_TYPE = 'HOME' THEN EMAIL_ADDRESS END) AS HOME_EMAIL_ADDRESS,
		MAX(CASE WHEN EMAIL_TYPE = 'WORK' THEN EMAIL_ADDRESS END) AS WORK_EMAIL_ADDRESS
	FROM
		(
			SELECT 
				EMPLOYEE_ID,
				NULLIF(UPPER(TRIM(EMAIL_TYPE)),'') AS EMAIL_TYPE,
				NULLIF(UPPER(TRIM(EMAIL_ADDRESS)),'') AS EMAIL_ADDRESS
			FROM DISC_PROD.WORKDAY.WORKER_EMAIL_DATA
			WHERE IS_PRIMARY = TRUE
		)
	GROUP BY
		EMPLOYEE_ID
)
, PHONE_DATA AS (
	SELECT
		EMPLOYEE_ID,
		MAX(CASE WHEN PHONE_TYPE = 'HOME' THEN PHONE_TYPE END) AS HOME_PHONE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = 'HOME' THEN PHONE_AREA_CODE END) AS HOME_PHONE_AREA_CODE,
		MAX(CASE WHEN PHONE_TYPE = 'HOME' THEN PHONE_NUMBER END) AS HOME_PHONE_NUMBER,
		MAX(CASE WHEN PHONE_TYPE = 'WORK' THEN PHONE_TYPE END) AS WORK_PHONE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = 'WORK' THEN PHONE_AREA_CODE END) AS WORK_PHONE_AREA_CODE,
		MAX(CASE WHEN PHONE_TYPE = 'WORK' THEN PHONE_NUMBER END) AS WORK_PHONE_NUMBER
	FROM
		(
			SELECT 
				EMPLOYEE_ID,
				NULLIF(UPPER(TRIM(PHONE_TYPE)),'') AS PHONE_TYPE,
				NULLIF(UPPER(TRIM(PHONE_DEVICE_TYPE)),'') AS PHONE_DEVICE_TYPE,
				NULLIF(TRIM(PHONE_AREA_CODE),'') AS PHONE_AREA_CODE,
				NULLIF(TRIM(PHONE_NUMBER),'') AS PHONE_NUMBER
			FROM DISC_PROD.WORKDAY.WORKER_PHONE_DATA
			WHERE IS_PRIMARY = TRUE
		)
	GROUP BY EMPLOYEE_ID
)
, EMAIL_DATA AS (
	SELECT
		EMPLOYEE_ID,
		MAX(CASE WHEN EMAIL_TYPE = 'HOME' THEN EMAIL_ADDRESS END) AS HOME_EMAIL_ADDRESS,
		MAX(CASE WHEN EMAIL_TYPE = 'WORK' THEN EMAIL_ADDRESS END) AS WORK_EMAIL_ADDRESS
	FROM
		(
			SELECT 
				EMPLOYEE_ID,
				NULLIF(UPPER(TRIM(EMAIL_TYPE)),'') AS EMAIL_TYPE,
				NULLIF(UPPER(TRIM(EMAIL_ADDRESS)),'') AS EMAIL_ADDRESS
			FROM DISC_PROD.WORKDAY.WORKER_EMAIL_DATA
			WHERE IS_PRIMARY = TRUE
		)
	GROUP BY 
		EMPLOYEE_ID
)
, WORKDAY AS (
	SELECT
	    S.EMPLOYEE_ID,
	    NM.FIRST_NAME,
	    NM.MIDDLE_NAME,
	    NM.LAST_NAME,
	    ID.ID AS SSN,
	    PER.BIRTH_DATE,
	    replace(ADDRESS.ADDRESS_LINE_DATA,'\n','') ADDRESS_LINE_DATA,
	    ADDRESS.ADDRESS_LINE_DATA_2,
	    ADDRESS.MUNICIPALITY,
	    ADDRESS.REGION,
	    ADDRESS.POSTAL_CODE,
	    NVL(CONCAT(PD.HOME_PHONE_AREA_CODE, PD.HOME_PHONE_NUMBER),PD.HOME_PHONE_NUMBER) AS HOME_PHONE,
	    NVL(CONCAT(PD.WORK_PHONE_AREA_CODE, PD.WORK_PHONE_NUMBER),PD.WORK_PHONE_NUMBER) AS WORK_PHONE,
	    ED.HOME_EMAIL_ADDRESS,
	    ED.WORK_EMAIL_ADDRESS,
	    AD.AMS_COST_CENTER_HIERARCHY,
	    ORG.ORGANIZATION_NAME AS LOCATION_HIERARCHY,
	    P.WORKER_TYPE AS WORKER_TYPE,
	    P.PAY_RATE_TYPE AS PAY_RATE_TYPE,
	    ST.ACTIVE,
	    ST.ORIGINAL_HIRE_DATE,
	    ST.HIRE_DATE,
	    ST.TERMINATION_DATE,
	    ST.REHIRE,
	    AD.PRE_BOARDING_COMPLETION,
	    AD.SEND_TO_AMS,
	    EX."CFI INT005 Worker ID LRV" IS NOT NULL AS ON_EXCLUDE_LIST
	FROM
	    DISC_PROD.WORKDAY.WORKER_SUMMARY S
	LEFT JOIN
	    DISC_PROD.WORKDAY.WORKER_ADDITIONAL_INFORMATION AD
	    ON AD.EMPLOYEE_ID = S.EMPLOYEE_ID
	LEFT JOIN
	    DISC_PROD.WORKDAY.WORKER_POSITION_DATA P
	    ON P.EMPLOYEE_ID = S.EMPLOYEE_ID
	LEFT JOIN 
	    DISC_PROD.WORKDAY.WORKER_NAME_DATA NM
	    ON NM.EMPLOYEE_ID = S.EMPLOYEE_ID AND NM.NAME_TYPE = 'Legal'
	LEFT JOIN 
	    DISC_PROD.WORKDAY.WORKER_IDENTIFICATION_DATA ID
	    ON ID.EMPLOYEE_ID = S.EMPLOYEE_ID AND ID.ID_TYPE = 'USA-SSN'
	LEFT JOIN 
	    DISC_PROD.WORKDAY.WORKER_PERSONAL PER
	    ON PER.EMPLOYEE_ID = S.EMPLOYEE_ID
	LEFT JOIN
		EMAIL_DATA ED
		ON ED.EMPLOYEE_ID = S.EMPLOYEE_ID
	LEFT JOIN
		PHONE_DATA PD
		ON PD.EMPLOYEE_ID = S.EMPLOYEE_ID
	LEFT JOIN
	    ORG
	    ON ORG.EMPLOYEE_ID = S.EMPLOYEE_ID
	LEFT JOIN
	    DISC_PROD.WORKDAY.WORKER_STATUS ST
	    ON ST.EMPLOYEE_ID = S.EMPLOYEE_ID
	LEFT JOIN
	    DISC_PROD.WORKDAY.WORKER_ADDRESS_DATA ADDRESS
	    ON ADDRESS.EMPLOYEE_ID = S.EMPLOYEE_ID AND ADDRESS.ADDRESS_TYPE = 'HOME'
	LEFT JOIN
	    DISC_PROD.WORKDAY.WORKER_EXCLUDE_LIST EX
	    ON EX."CFI INT005 Worker ID LRV" = S.EMPLOYEE_ID
)
SELECT * FROM WORKDAY;