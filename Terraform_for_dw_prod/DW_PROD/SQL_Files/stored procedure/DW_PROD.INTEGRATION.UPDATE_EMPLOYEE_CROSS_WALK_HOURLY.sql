CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.UPDATE_EMPLOYEE_CROSS_WALK_HOURLY("ENVIRONMENT" VARCHAR(10), "STR_ETL_TASK_KEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN 

--*****************************************************************************************************************************
-- NAME:  UPDATE_EMPLOYEE_CROSS_WALK_HOURLY
--
-- PURPOSE: Update WORKDAY_INTERNAL_ID in Employee crosswalk
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 22/09/2023	Ramesh Mokariya/Gaurav			Initial Development
--note --on urgent bases we added ENVIRONMENT param but didnt utilized but we are going utilize this and will update this code
--
--*****************************************************************************************************************************


--
-- *********************************************************************************
-- Step 1: Inserting records into Exception table for which we already have Workday ID assigned to some other Enterprise ID

INSERT INTO DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID
(EMPLOYEE_ENTERPRISE_ID, FIRST_NAME,LAST_NAME, WORKDAY_INTERNAL_ID,WORKDAY_ID_OF_MAPPING)
SELECT CW.EMPLOYEE_ENTERPRISE_ID, CW.FIRST_NAME, CW.LAST_NAME, CW.WORKDAY_INTERNAL_ID, MAP.WORKDAY_ID
FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK CW 
JOIN DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING AS MAP 
	WHERE CW.EMPLOYEE_ENTERPRISE_ID = MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID 
	AND MAP.WORKDAY_ID IN 
		(SELECT DISTINCT MAP.WORKDAY_ID 
		FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK CW 
		JOIN DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING MAP 
			ON MAP.WORKDAY_ID = CW.WORKDAY_INTERNAL_ID 
			AND MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID <> CW.EMPLOYEE_ENTERPRISE_ID 
			AND CW.INACTIVE <> TRUE AND CW.DUP_FLAG <> TRUE
		WHERE CW.WORKDAY_INTERNAL_ID in 
			(select distinct WORKDAY_ID from DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING)
		AND MAP.CURRENT_RECORDS = TRUE
		) 
AND CW.EMPLOYEE_ENTERPRISE_ID||''-''||CW.WORKDAY_INTERNAL_ID||''-''||MAP.WORKDAY_ID
NOT IN 
	(SELECT  EMPLOYEE_ENTERPRISE_ID||''-''||WORKDAY_INTERNAL_ID||''-''||WORKDAY_ID_OF_MAPPING
	FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID);

-- *********************************************************************************
-- Step 1.1: Updating Workday_internal_id and Payroll ID as NULL which are available in WORKER_EXCLUDE_LIST

UPDATE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK 
SET WORKDAY_INTERNAL_ID = NULL
WHERE WORKDAY_INTERNAL_ID IN (SELECT "CFI INT005 Worker ID LRV" FROM DISC_PROD.WORKDAY.WORKER_EXCLUDE_LIST)
AND DUP_FLAG <> TRUE AND INACTIVE <> TRUE;


-- Inactivating the records which have just payroll details
UPDATE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK 
SET INACTIVE = TRUE 
WHERE EMPLOYEE_ENTERPRISE_ID IN 
	(SELECT EMPLOYEE_ENTERPRISE_ID
	FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK 
	WHERE PAYROLL_EMPLOYEE_ID IN 
		(SELECT "CFI INT005 Worker ID LRV" FROM DISC_PROD.WORKDAY.WORKER_EXCLUDE_LIST)
	AND PAYROLL_SYSTEM_CODE = ''WORKDAY''
	AND INACTIVE <> TRUE AND DUP_FLAG <> TRUE
	AND AMS_EMPLOYEE_KEY IS NULL
	)
;

-- Making payroll attributes NULL where AMS is available
UPDATE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK 
SET PAYROLL_EMPLOYEE_KEY = NULL,
	PAYROLL_SOURCE_SYSTEM_ID = NULL,
	PAYROLL_SYSTEM_CODE = NULL,
	PAYROLL_EMPLOYEE_ID = NULL,
	PAYROLL_METADATA = NULL 
WHERE PAYROLL_EMPLOYEE_ID IN 
	(SELECT "CFI INT005 Worker ID LRV" FROM DISC_PROD.WORKDAY.WORKER_EXCLUDE_LIST)
AND PAYROLL_SYSTEM_CODE = ''WORKDAY''
AND DUP_FLAG <> TRUE AND INACTIVE <> TRUE
AND AMS_EMPLOYEE_KEY IS NOT NULL
;

-- *********************************************************************************
-- Step 1.2: Updating Workday_internal_id based on Enterprise ID 

UPDATE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK  CW
SET CW.WORKDAY_INTERNAL_ID = MAP.WORKDAY_ID,
	CW.ETL_LAST_UPDATED_DATE = CURRENT_TIMESTAMP,
	CW.ETL_LAST_UPDATED_BY = CURRENT_USER
from DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING AS MAP 
WHERE CW.EMPLOYEE_ENTERPRISE_ID = MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID 
-- Updating only for NULL Workday ID
AND MAP.CURRENT_RECORDS = TRUE
AND COALESCE(MAP.ON_HOLD, FALSE) <> TRUE
AND CW.WORKDAY_INTERNAL_ID IS NULL
AND MAP.WORKDAY_ID not in 
	(select distinct NVL(WORKDAY_INTERNAL_ID,'''') from DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK 
	WHERE WORKDAY_INTERNAL_ID IS NOT NULL
	AND INACTIVE <> TRUE AND DUP_FLAG <> TRUE)
-- Excluding Exception records
AND CW.EMPLOYEE_ENTERPRISE_ID NOT IN 
	(SELECT EMPLOYEE_ENTERPRISE_ID
	FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID);


-- *********************************************************************************
-- Step 2: Updating WORKDAY_ID if Paradox record is already present in the croswalk

---UPDATE WORKDAY INTERNAL ID
UPDATE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK TGT
SET TGT.WORKDAY_INTERNAL_ID = SRC.WORKDAY_ID
FROM (
    SELECT CW.EMPLOYEE_ENTERPRISE_ID, WP.WORKDAY_ID 
    FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK CW
    LEFT JOIN DW_PROD.INTEGRATION.VW_WORKDAY_PARADOX_APPLICANT_MAPPING WP
        ON CW.APPLICANT_EMPLOYEE_KEY = WP.PARADOX_APPLICANT_KEY  
    WHERE CW.APPLICANT_EMPLOYEE_KEY  IN (
            SELECT PARADOX_APPLICANT_KEY
            FROM DW_PROD.INTEGRATION.VW_WORKDAY_PARADOX_APPLICANT_MAPPING
    )
        AND CW.APPLICANT_EMPLOYEE_KEY IS NOT NULL
        AND CW.INACTIVE = FALSE AND DUP_FLAG = FALSE
        AND CW.WORKDAY_INTERNAL_ID IS NULL
) AS SRC
WHERE SRC.EMPLOYEE_ENTERPRISE_ID = TGT.EMPLOYEE_ENTERPRISE_ID
-- Excluding Workday IDs which are already available in crosswalk
AND SRC.WORKDAY_ID NOT IN 
	(
	SELECT DISTINCT NVL(WORKDAY_INTERNAL_ID, '''') 
	FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK
	WHERE INACTIVE <> TRUE AND DUP_FLAG <> TRUE 
	);

-- *********************************************************************************
-- Step 3: Inserting Applicants which are new 


INSERT INTO DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK
(EMPLOYEE_ENTERPRISE_ID, WORKDAY_INTERNAL_ID, APPLICANT_EMPLOYEE_ID, APPLICANT_SOURCE_SYSTEM_ID, APPLICANT_SYSTEM_CODE, FIRST_NAME, LAST_NAME, BRANCH_STATE_CODE,APPLICANT_EMPLOYEE_KEY ,
ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG, DUP_FLAG)
SELECT COALESCE((SELECT MAX(EMPLOYEE_ENTERPRISE_ID) FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK),10000000)+ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS EMPLOYEE_ENTERPRISE_ID,
	APPLICANT_ID AS WORKDAY_INTERNAL_ID, 
	APPLICANT_ID AS APPLICANT_EMPLOYEE_ID,
	SOURCE_SYSTEM_ID AS APPLICANT_SOURCE_SYSTEM_ID,
	SYSTEM_CODE AS APPLICANT_SYSTEM_CODE, 
	FIRST_NAME AS FIRST_NAME,
	LAST_NAME AS LAST_NAME,
	STATE_CODE AS BRANCH_STATE_CODE,
	APPLICANT_KEY AS APPLICANT_EMPLOYEE_KEY,
	-1 AS ETL_TASK_KEY,
	-1 AS ETL_INSERTED_TASK_KEY,
	CURRENT_TIMESTAMP,
    CURRENT_USER,
    CURRENT_TIMESTAMP,
    CURRENT_USER,
	0,
	FALSE
FROM DW_PROD."STAGE".WORKDAY_DIM_APPLICANT 
WHERE NVL(APPLICANT_ID,'''') NOT IN 
	(SELECT DISTINCT NVL(WORKDAY_INTERNAL_ID,'''') 
	FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK)
AND SOURCE_SYSTEM_ID = 36
AND NVL(APPLICANT_KEY,'''') NOT IN 
	(SELECT DISTINCT NVL(APPLICANT_EMPLOYEE_KEY,'''') 
	FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK)
AND APPLICANT_EMPLOYEE_ID NOT IN 
	(SELECT DISTINCT COALESCE(PARADOX_ID, WORKDAY_ID) FROM DW_PROD.INTEGRATION.APPLICANT_CROSSWALK_MAPPING)
;
--

-- Step 3:
UPDATE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK CW
SET
	CW.WORKDAY_INTERNAL_ID = MAP.WORKDAY_ID,
	CW.APPLICANT_EMPLOYEE_ID = COALESCE(MAP.PARADOX_ID, MAP.WORKDAY_ID),
	CW.APPLICANT_EMPLOYEE_KEY = COALESCE (FA.APPLICANT_KEY, APP.APPLICANT_KEY),
	CW.APPLICANT_SOURCE_SYSTEM_ID = COALESCE (FA.SOURCE_SYSTEM_ID ,APP.SOURCE_SYSTEM_ID),
	CW.APPLICANT_SYSTEM_CODE = COALESCE(FA.SYSTEM_CODE ,APP.SYSTEM_CODE),
	CW.ETL_LAST_UPDATED_DATE = CURRENT_TIMESTAMP,
	CW.ETL_LAST_UPDATED_BY = CURRENT_USER
FROM DW_PROD.INTEGRATION.APPLICANT_CROSSWALK_MAPPING AS MAP
LEFT JOIN DW_PROD.STAGE.WORKDAY_DIM_APPLICANT APP 
	ON APP.APPLICANT_ID = COALESCE(MAP.PARADOX_ID, MAP.WORKDAY_ID) 
LEFT JOIN DW_PROD.HAH.FACT_APPLICANT_STATUS FA 
	ON FA.CANDIDATE_ID = MAP.PARADOX_ID
WHERE CW.EMPLOYEE_ENTERPRISE_ID = MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID 
AND MAP.CURRENT_RECORDS = TRUE
AND COALESCE(MAP.ON_HOLD, FALSE) <> TRUE
-- Updating only for NULL Workday ID
AND CW.WORKDAY_INTERNAL_ID IS NULL
AND MAP.WORKDAY_ID not in 
	(select distinct NVL(WORKDAY_INTERNAL_ID,'''') from DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK 
	WHERE WORKDAY_INTERNAL_ID IS NOT NULL
	AND INACTIVE <> TRUE AND DUP_FLAG <> TRUE)
AND MAP.CROSSWALK_EMPLOYEE_ENTERPRISE_ID NOT IN 
	(SELECT DISTINCT CROSSWALK_EMPLOYEE_ENTERPRISE_ID FROM DW_PROD.INTEGRATION.WORKDAY_CROSSWALK_MAPPING)
;

-- *********************************************************************************
-- Step 4: Making ID without AMS Inactive if any workday internal id got duplicate

UPDATE DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK
SET INACTIVE = TRUE 
WHERE WORKDAY_INTERNAL_ID IN
	(SELECT WORKDAY_INTERNAL_ID 
	FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK 
	WHERE NVL(INACTIVE, FALSE) <> TRUE AND NVL(DUP_FLAG, FALSE) <> TRUE 
	GROUP BY 1 HAVING COUNT(*)>1)
AND AMS_EMPLOYEE_KEY IS NULL 
AND PAYROLL_EMPLOYEE_KEY IS NULL
AND NVL(INACTIVE, FALSE) <> TRUE AND NVL(DUP_FLAG, FALSE) <> TRUE ;

-- *********************************************************************************
-- Step 5: Inserting changed records in historical hourly table


INSERT INTO DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_HISTORICAL_HOURLY 
SELECT * EXCLUDE (ETL_INSERTED_DATE, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG, AMS_PUBLIC_ID, AMS_PAYROLL_ID, EMPLOYEE_SSN),
		CURRENT_TIMESTAMP, CURRENT_USER, AMS_PUBLIC_ID, EMPLOYEE_SSN 
FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK AT (OFFSET => -60*60*2)
EXCEPT 
SELECT * EXCLUDE (ETL_INSERTED_DATE, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG, AMS_PUBLIC_ID, AMS_PAYROLL_ID, EMPLOYEE_SSN),
		CURRENT_TIMESTAMP, CURRENT_USER, AMS_PUBLIC_ID , EMPLOYEE_SSN
FROM DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK;

return ''SUCCEED'';
end;
';