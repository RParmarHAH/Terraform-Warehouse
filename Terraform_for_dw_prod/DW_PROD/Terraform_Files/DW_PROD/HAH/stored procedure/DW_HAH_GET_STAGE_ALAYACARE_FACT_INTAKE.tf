resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_FACT_INTAKE" {
	name ="GET_STAGE_ALAYACARE_FACT_INTAKE"
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

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    --*****************************************************************************************************************************
-- NAME:  ALAYACARE_FACT_INTAKE

--	12/13/21     Mir Ali            Initial development
-- 	12/14/21     Vaidehi Shah		Added billrates from visits and all keys and other columns
-- 	12/14/21     Vaidehi Shah		change branch_key to have group id and branch name to have groupid alternative
--	21/12/21	 Vaidehi Shah		leveraging dedupe
--	23/2/22		 Vaidehi Shah		removed visit join due to utilization issue
-- 	03/09/22	 Mir Ali			Added cutover dates for transitioning from Coastal to Alayacare (Georgia)
--  04/22/22	 Pooja Shah			Enhancement to include Auth Dates & PreAuthNo.
--*****************************************************************************************************************************


INSERT OVERWRITE INTO STAGE.ALAYACARE_FACT_INTAKE
WITH FUNDING_BLOCKS AS (
	SELECT L.REPORT_DATE,  
		L.SERVICE_ID, 
		L.FUNDING_BLOCK_START_DATE, L.FUNDING_BLOCK_END_DATE,
		L.FUNDING_FREQUENCY, L.FUNDING_UNITS,
		L.FUNDING_QUANTITY, L.NUMBER_OF_DAYS,
		COUNT(DISTINCT L.CALENDAR_DATE) AS DAYS_IN_PERIOD
			FROM (
		SELECT DISTINCT DATES.FIRST_DAY_OF_MONTH AS REPORT_DATE,
		DATES.CALENDAR_DATE,
		FUNDING_BLOCK.SERVICE_ID,
		FUNDING_BLOCK.MASTER,
		FUNDING_BLOCK.FUNDING_BLOCK_START_DATE, FUNDING_BLOCK.FUNDING_BLOCK_END_DATE,
		FUNDING_BLOCK.FUNDING_FREQUENCY, FUNDING_BLOCK.FUNDING_UNITS,
		FUNDING_BLOCK.FUNDING_QUANTITY, DATES.NUMBER_OF_DAYS,
		DENSE_RANK() OVER (PARTITION BY DATES.CALENDAR_DATE, 
				FUNDING_BLOCK.SERVICE_ID 
			ORDER BY FUNDING_BLOCK.MASTER, 
				FUNDING_BLOCK.FUNDING_BLOCK_CREATE_DATE,
				FUNDING_BLOCK.FUNDING_BLOCK_ID) AS ROW_NUM
FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.FUNDING_BLOCK_TIER_4 AS FUNDING_BLOCK
		JOIN (SELECT FIRST_DAY_OF_MONTH, CALENDAR_DATE, DAY(LAST_DAY_OF_MONTH) AS NUMBER_OF_DAYS
		FROM HAH.DIM_DATE
		) AS DATES
		ON DATES.CALENDAR_DATE BETWEEN FUNDING_BLOCK.FUNDING_BLOCK_START_DATE AND FUNDING_BLOCK.FUNDING_BLOCK_END_DATE
GROUP BY DATES.FIRST_DAY_OF_MONTH, DATES.CALENDAR_DATE, 
		FUNDING_BLOCK.SERVICE_ID, FUNDING_BLOCK.MASTER,
		FUNDING_BLOCK.FUNDING_BLOCK_CREATE_DATE,
		FUNDING_BLOCK.FUNDING_BLOCK_ID,
		FUNDING_BLOCK.FUNDING_BLOCK_START_DATE, FUNDING_BLOCK.FUNDING_BLOCK_END_DATE,
		FUNDING_BLOCK.FUNDING_FREQUENCY, FUNDING_BLOCK.FUNDING_UNITS,
		FUNDING_BLOCK.FUNDING_QUANTITY, DATES.NUMBER_OF_DAYS
		
	) L
	WHERE L.ROW_NUM = 1
--and l.service_id=5656
	GROUP BY L.REPORT_DATE,  
		L.SERVICE_ID, 
		L.FUNDING_BLOCK_START_DATE, L.FUNDING_BLOCK_END_DATE,
		L.FUNDING_FREQUENCY, L.FUNDING_UNITS,
		L.FUNDING_QUANTITY, L.NUMBER_OF_DAYS
)
,
AUTHDATES  --- Added by PJShah on 22042022
AS (
		SELECT 
 SERVICE_CLIENT_ID ,service_funder_id,
 max(MAX_FUNDING_BLOCK_START_DATE ) AS MAX_FUNDING_BLOCK_START_DATE,
		max(FUNDING_BLOCK_END_DATE) AS FUNDING_BLOCK_END_DATE ,
max(MAX_SERVICE_START_DATE) AS MAX_SERVICE_START_DATE,
max(SERVICE_PROJECTED_END_DATE) AS SERVICE_PROJECTED_END_DATE

 FROM 
		(
		SELECT   maxdt.SERVICE_CLIENT_ID ,maxdt.service_funder_id, maxdt.SERVICE_ID,MAXDT.MAX_FUNDING_BLOCK_START_DATE ,
		expdt.FUNDING_BLOCK_END_DATE ,MAXDT.MAX_SERVICE_START_DATE,SVCEND.SERVICE_PROJECTED_END_DATE
		FROM 
		(
		SELECT svc.SERVICE_CLIENT_ID,svc.service_funder_id,FUNDING_BLOCK.MASTER ,FUNDING_BLOCK.FUNDING_BLOCK_CREATE_DATE,FUNDING_BLOCK.FUNDING_BLOCK_ID ,FUNDING_BLOCK.SERVICE_ID
		--ROW_NUMBER() OVER (PARTITION BY SERVICE_ID  ORDER BY  MASTER ,FUNDING_BLOCK_CREATE_DATE,FUNDING_BLOCK_ID  desc)AS rownum
		--,MAX(FUNDING_BLOCK.FUNDING_BLOCK_START_DATE) OVER (PARTITION BY FUNDING_BLOCK.SERVICE_ID  ORDER BY FUNDING_BLOCK.MASTER ,FUNDING_BLOCK.FUNDING_BLOCK_CREATE_DATE,FUNDING_BLOCK.FUNDING_BLOCK_ID  desc) AS MAX_FUNDING_BLOCK_START_DATE
		,MAX(FUNDING_BLOCK.FUNDING_BLOCK_START_DATE) OVER (PARTITION BY FUNDING_BLOCK.SERVICE_ID  ) AS MAX_FUNDING_BLOCK_START_DATE
		,MAX(svc.SERVICE_START_DATE) OVER (PARTITION BY svc.SERVICE_CLIENT_ID,SERVICE_FUNDER_ID  ORDER BY SERVICE_START_DATE desc) AS MAX_SERVICE_START_DATE
		--,MAX(FUNDING_BLOCK.FUNDING_BLOCK_START_DATE)
-----------------------------IMP NOTE Added by PJShah on 22042022 -------------------------------------
-- Considering  FUNDING_BLOCK_CREATE_DATE for generating max date gives multiple records 
-------------------------------------------------------------------------------------------------------
FROM DISC_${var.SF_ENVIRONMENT}.ALAYACARE.FUNDING_BLOCK_TIER_4 FUNDING_BLOCK
		JOIN disc_${var.SF_ENVIRONMENT}.ALAYACARE.SERVICE svc ON svc.SERVICE_ID = FUNDING_BLOCK.service_id
		--WHERE FUNDING_BLOCK.SERVICE_ID in (1533,5656)
		)maxdt 
		JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.FUNDING_BLOCK_TIER_4 expdt ON maxdt.service_id=expdt.SERVICE_ID AND
		maxdt.MAX_FUNDING_BLOCK_START_DATE=expdt.FUNDING_BLOCK_START_DATE
		join  DISC_${var.SF_ENVIRONMENT}.ALAYACARE.SERVICE SVCEND ON SVCEND.SERVICE_ID=MAXDT.SERVICE_ID
												AND SVCEND.SERVICE_CLIENT_ID=MAXDT.SERVICE_CLIENT_ID
												AND SVCEND.SERVICE_FUNDER_ID=MAXDT.SERVICE_FUNDER_ID
--where maxdt.SERVICE_CLIENT_ID =1677 and maxdt.service_funder_id	=53	
GROUP BY maxdt.SERVICE_ID,MAXDT.MAX_FUNDING_BLOCK_START_DATE ,
		expdt.FUNDING_BLOCK_END_DATE ,MAXDT.MAX_SERVICE_START_DATE,maxdt.SERVICE_CLIENT_ID,maxdt.service_funder_id
		,SVCEND.SERVICE_PROJECTED_END_DATE
)T
GROUP BY SERVICE_CLIENT_ID,service_funder_id
		
),
BILL_RATES AS (
SELECT *
FROM (
	SELECT L.*, BILL_RATE.RATE,
		ROW_NUMBER() OVER (PARTITION BY L.REPORT_DATE , L.CLIENT_KEY , L.CONTRACT_KEY
			ORDER BY IFF(L.REPORT_DATE >= DATE_TRUNC(MONTH, BILL_RATE.START_DATE), 0, 1), BILL_RATE.START_DATE) AS ROW_NUM
	FROM (
		SELECT REPORT_DATE,MD5(NVL(BRANCH.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION, ''Unknown'') || '' ('' || NVL(SERVICE.BRANCH_ID, ''-1'') || '')'' || ''-'' || NVL(TO_VARCHAR(SERVICE.SERVICE_FUNDER_ID), ''Unknown'') || ''-'' || NVL(TO_VARCHAR(SERVICE.SERVICE_CODE_ID), ''Unknown'') || ''-'' || ''ALAYACARE'') AS CONTRACT_KEY,
		MD5(NVL(BRANCH.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION, ''Unknown'') || '' ('' || NVL(SERVICE.BRANCH_ID, ''-1'') || '')''  || ''-'' || NVL(SERVICE.SERVICE_CLIENT_ID, ''-1'') || ''-'' || ''ALAYACARE'') AS CLIENT_KEY,
		SERVICE.SERVICE_BILL_CODE_ID,
		ROUND(AVG( IFF(VISITS.VISIT_COMPUTED_RATE_UNITS = ''hours'', 
					VISITS.VISIT_COMPUTED_RATE, 
					(VISITS.VISIT_COMPUTED_RATE / COALESCE(NULLIF(VISITS.VISIT_SCHEDULED_DURATION, 0), NULLIF(VISITS.VISIT_HOURS_APPROVED, 0), 1))) ),2) AS VISIT_BILL_RATE
		FROM FUNDING_BLOCKS AS FUNDING_BLOCK
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.SERVICE AS SERVICE
		ON SERVICE.SERVICE_ID = FUNDING_BLOCK.SERVICE_ID
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH AS BRANCH
		ON BRANCH.BRANCH_ID = SERVICE.BRANCH_ID
		LEFT JOIN  DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT AS VISITS
		ON VISITS.SERVICE_ID =SERVICE.SERVICE_ID
		AND VISITS.CLIENT_ID =SERVICE.SERVICE_CLIENT_ID 
		WHERE FUNDING_BLOCK.FUNDING_UNITS = ''hours''
		AND FUNDING_BLOCK.FUNDING_FREQUENCY <> ''custom''
		AND FUNDING_BLOCK.FUNDING_QUANTITY > 0
		GROUP BY REPORT_DATE , CLIENT_KEY , CONTRACT_KEY, SERVICE.SERVICE_BILL_CODE_ID
	) L
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BILL_RATE AS BILL_RATE
		ON BILL_RATE.BILL_CODE_ID = L.SERVICE_BILL_CODE_ID 
) L2
WHERE L2.ROW_NUM = 1
)
,CLIENT AS  --VISIT DATA
(
SELECT * FROM 
(
	SELECT CLIENT_ID,MASTER_ID,CLIENT_ID AS ORIGINAL_RECORD_ID,GUID,BRANCH_ID
	FROM  DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_MASTER_LIST 
) 
UNION
SELECT * FROM 
(
	SELECT DISTINCT ID,MASTER_ID,ID AS ORIGINAL_RECORD_ID,GUID,BRANCH_ID
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_MATCH_LIST 
	WHERE ID NOT IN (SELECT CLIENT_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_MASTER_LIST ) 
) 
)
--BRANCH_KEY ||CONTRACT_KEY ||CLIENT_ID||REPORT_DATE||ALAYACARE
,DATA AS (SELECT SERVICE.SERVICE_CLIENT_ID,
REPORT_DATE,--CHANGE BRANCH.BRANCHID TO SERVICE.BRANCHID
MD5(NVL(BRANCH.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION, ''Unknown'') || '' ('' || NVL(SERVICE.BRANCH_ID, ''-1'') || '')'' || ''-'' ||  TRIM(NVL(GROUPS.GROUP_ID,-1)) || ''-'' || NVL(TO_VARCHAR(SERVICE.SERVICE_FUNDER_ID), ''Unknown'')  || ''-''|| NVL(TO_VARCHAR(SERVICE.SERVICE_CODE_ID), ''Unknown'')||''-'' || SERVICE.SERVICE_CLIENT_ID||''-'' ||  REPORT_DATE || ''-''||''ALAYACARE'' ) AS INTAKE_KEY,
MD5(NVL(BRANCH.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION, ''Unknown'') || '' ('' || NVL(SERVICE.BRANCH_ID, ''-1'') || '')''  || ''-'' || TRIM(NVL(GROUPS.GROUP_ID,-1)) || ''-'' || ''ALAYACARE'') AS BRANCH_KEY,
MD5(NVL(TRIM(BRANCH.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(SERVICE.BRANCH_ID, ''-1'') || '')''  || ''-'' || NVL(COALESCE(C.MASTER_ID::INT,SERVICE.SERVICE_CLIENT_ID::INT),''-1'') || ''-'' || ''ALAYACARE'') AS CLIENT_KEY,
9 AS SOURCE_SYSTEM_ID,
IFF(FUNDING_BLOCK.FUNDING_BLOCK_START_DATE<REPORT_DATE,REPORT_DATE,FUNDING_BLOCK.FUNDING_BLOCK_START_DATE) AS REAUTHORIZED_DATE,
--FUNDING_BLOCK.STARTDATE IF FB.STDT IS LESS THAN REPORTDATE TAKE REPORTDATE ELSE TAKE FB.STARTDATE
NVL(UPPER(TRIM(GROUPS.PROFILE_COMPANY)), ''Unknown ('' || NVL(GROUPS.GROUP_ID, -1) || '')'')  AS BRANCH_NAME,
NVL(BRANCH.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION, ''Unknown'') || '' ('' || NVL(SERVICE.BRANCH_ID, ''-1'') || '')'' AS SYSTEM_CODE,
MD5(NVL(BRANCH.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION, ''Unknown'') || '' ('' || NVL(SERVICE.BRANCH_ID, ''-1'') || '')'' || ''-'' || NVL(TO_VARCHAR(SERVICE.SERVICE_FUNDER_ID), ''Unknown'') || ''-'' || NVL(TO_VARCHAR(SERVICE.SERVICE_CODE_ID), ''Unknown'') || ''-'' || ''ALAYACARE'') AS CONTRACT_KEY,
NVL(TO_VARCHAR(SERVICE.SERVICE_FUNDER_ID), ''Unknown'') AS CONTRACT_CODE,
CASE FUNDING_BLOCK.FUNDING_FREQUENCY
WHEN ''monthly'' THEN FUNDING_BLOCK.FUNDING_QUANTITY
WHEN ''total'' THEN (FUNDING_BLOCK.FUNDING_QUANTITY / (DATEDIFF(DAY, FUNDING_BLOCK.FUNDING_BLOCK_START_DATE, FUNDING_BLOCK.FUNDING_BLOCK_END_DATE) + 1)) * FUNDING_BLOCK.DAYS_IN_PERIOD
 WHEN ''weekly'' THEN (FUNDING_BLOCK.FUNDING_QUANTITY / 7.0) * FUNDING_BLOCK.DAYS_IN_PERIOD
END AS HOURS_AUTHORIZED,
CASE FUNDING_BLOCK.FUNDING_FREQUENCY
 WHEN ''monthly'' THEN FUNDING_BLOCK.FUNDING_QUANTITY
WHEN ''total'' THEN (FUNDING_BLOCK.FUNDING_QUANTITY / (DATEDIFF(DAY, FUNDING_BLOCK.FUNDING_BLOCK_START_DATE, FUNDING_BLOCK.FUNDING_BLOCK_END_DATE) + 1)) * FUNDING_BLOCK.DAYS_IN_PERIOD
WHEN ''weekly'' THEN (FUNDING_BLOCK.FUNDING_QUANTITY / 7.0) * FUNDING_BLOCK.NUMBER_OF_DAYS
END AS HOURS_AUTHORIZED_NON_ADJUSTED
/*,IFF(VISITS.VISIT_COMPUTED_RATE_UNITS = ''hours'', 
			VISITS.VISIT_COMPUTED_RATE, 
			(VISITS.VISIT_COMPUTED_RATE / COALESCE(NULLIF(VISITS.VISIT_SCHEDULED_DURATION, 0), NULLIF(VISITS.VISIT_HOURS_APPROVED, 0), 1))) AS BILL_RATE -- ASK*/
FROM FUNDING_BLOCKS AS FUNDING_BLOCK
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.SERVICE AS SERVICE
ON SERVICE.SERVICE_ID = FUNDING_BLOCK.SERVICE_ID
LEFT JOIN CLIENT C
ON C.CLIENT_ID =SERVICE.SERVICE_CLIENT_ID
AND C.BRANCH_ID=SERVICE.BRANCH_ID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH AS BRANCH
ON BRANCH.BRANCH_ID = SERVICE.BRANCH_ID
/*LEFT JOIN  DISC_${var.SF_ENVIRONMENT}.ALAYACARE.VISIT AS VISITS
ON VISITS.SERVICE_ID =SERVICE.SERVICE_ID
AND VISITS.CLIENT_ID =SERVICE.SERVICE_CLIENT_ID */
--LEFT JOIN  DISC_DEDUPE_${var.SF_ENVIRONMENT}.ALAYACARE.CLIENT_MASTER_ALAYACARE C
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.TBL_GUID_COST_CENTRE_TIER_4 COST_CENTRE_MAPPING
ON COST_CENTRE_MAPPING.GUID_TO = C.GUID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.TBL_COST_CENTRES_TIER_4 AS COST_CENTRE
ON COST_CENTRE.ID = COST_CENTRE_MAPPING.COST_CENTRE_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.GROUPS AS GROUPS
ON GROUPS.BRANCH_ID = COST_CENTRE.PROPERTIES_BRANCH_ID
AND GROUPS.PROFILE_COMPANY = COST_CENTRE.PROPERTIES_DESCRIPTION
--AND BRANCH.BRANCH_ID = COALESCE(GROUPS.BRANCH_ID, C.BRANCH_ID) 
AND BRANCH.BRANCH_ID = SERVICE.BRANCH_ID
WHERE FUNDING_BLOCK.FUNDING_UNITS = ''hours''
AND FUNDING_BLOCK.FUNDING_FREQUENCY <> ''custom''
AND FUNDING_BLOCK.FUNDING_QUANTITY > 0
--GROUP BY SERVICE_CLIENT_ID,REPORT_DATE,BRANCH_KEY,CLIENT_KEY,SOURCE_SYSTEM_ID,SYSTEM_CODE,CONTRACT_KEY,CONTRACT_CODE
ORDER BY CLIENT_KEY,REPORT_dATE)
,
PER_CLIENT_DATA AS(
SELECT INTAKE_KEY,SERVICE_CLIENT_ID,
DATA.REPORT_DATE,
DATA.BRANCH_KEY,
DATA.CLIENT_KEY,
DATA.SOURCE_SYSTEM_ID,
MAX(REAUTHORIZED_DATE) AS REAUTHORIZED_DATE,
DATA.SYSTEM_CODE,
DATA.CONTRACT_KEY,
DATA.CONTRACT_CODE,
DATA.BRANCH_NAME,
SUM(HOURS_AUTHORIZED) AS HOURS_AUTHORIZED,
SUM(HOURS_AUTHORIZED_NON_ADJUSTED) AS HOURS_AUTHORIZED_NON_ADJUSTED,NVL(AVG(COALESCE(VISIT_BILL_RATE, RATE)),0) AS BILL_RATE
FROM DATA
LEFT JOIN BILL_RATES ON BILL_RATES.CONTRACT_KEY=DATA.CONTRACT_KEY
AND BILL_RATES.CLIENT_KEY=DATA.CLIENT_KEY
AND BILL_RATES.REPORT_DATE=DATA.REPORT_DATE
--ADD REPORT_DATE IN JOIN
GROUP BY INTAKE_KEY,SERVICE_CLIENT_ID,DATA.REPORT_DATE,DATA.BRANCH_KEY,DATA.CLIENT_KEY,DATA.SOURCE_SYSTEM_ID,DATA.SYSTEM_CODE,DATA.CONTRACT_KEY,DATA.CONTRACT_CODE,DATA.BRANCH_NAME--,BILL_RATE
), RESULTS AS (
	SELECT  DATA.INTAKE_KEY
		,DATA.REPORT_DATE
		,DATA.BRANCH_KEY
		,DATA.CLIENT_KEY
		,DATA.CONTRACT_KEY
		,DATA.SOURCE_SYSTEM_ID
		,DATA.REAUTHORIZED_DATE
		,DATA.BRANCH_NAME
		,DATA.SERVICE_CLIENT_ID AS CLIENT_NUMBER
		,DATA.CONTRACT_CODE
		,DATA.BILL_RATE
		,DATA.SYSTEM_CODE
		,NULL AS CASE_MANAGER   
		,DATA.HOURS_AUTHORIZED 
		,DATA.HOURS_AUTHORIZED_NON_ADJUSTED
		,NVL(CUTOVER.START_DATE, DATE_TRUNC(MONTH, DATA.REPORT_DATE)) AS START_DATE_ONLY_CUTOVER
		,NVL(CUTOVER.END_DATE, LAST_DAY(DATA.REPORT_DATE)) AS END_DATE_ONLY_CUTOVER
		,IFF(START_DATE_ONLY_CUTOVER > DATE_TRUNC(MONTH, DATA.REPORT_DATE), START_DATE_ONLY_CUTOVER, DATE_TRUNC(MONTH, DATA.REPORT_DATE)) AS START_DATE_WITH_CUTOVER
		,IFF(END_DATE_ONLY_CUTOVER < LAST_DAY(DATA.REPORT_DATE), END_DATE_ONLY_CUTOVER, LAST_DAY(DATA.REPORT_DATE)) AS END_DATE_WITH_CUTOVER
		FROM PER_CLIENT_DATA AS DATA
		LEFT JOIN HAH.FACT_SYSTEM_CUTOVER_DATE AS CUTOVER
			ON CUTOVER.SOURCE_SYSTEM_ID = DATA.SOURCE_SYSTEM_ID 
				AND CUTOVER.SYSTEM_CODE = DATA.SYSTEM_CODE
				AND NVL(CUTOVER.BRANCH_KEY, DATA.BRANCH_KEY) = DATA.BRANCH_KEY
				AND NVL(CUTOVER.CONTRACT_KEY, DATA.CONTRACT_KEY) = DATA.CONTRACT_KEY
)
	SELECT INTAKE_KEY,
		REPORT_DATE,
		BRANCH_KEY,
		CLIENT_KEY,
		CONTRACT_KEY,
		SOURCE_SYSTEM_ID,
		NULL AS PRE_AUTH_NUMBER, -- Added by PJShah on 22042022
		AUTHDT.MAX_SERVICE_START_DATE AS BEGIN_SERVICE_DATE,  -- Added by PJShah on 22042022                        
		AUTHDT.SERVICE_PROJECTED_END_DATE AS END_SERVICE_DATE,  -- Added by PJShah on 22042022
		AUTHDT.MAX_FUNDING_BLOCK_START_DATE AS LATEST_AUTH_BEGIN_DATE,  -- Added by PJShah on 22042022               
		AUTHDT.FUNDING_BLOCK_END_DATE AS LATEST_AUTH_END_DATE,  -- Added by PJShah on 22042022
		REAUTHORIZED_DATE,
		BRANCH_NAME,
		DATA.CLIENT_NUMBER,
		CONTRACT_CODE,
		BILL_RATE,
		UPPER(DATA.SYSTEM_CODE) AS SYSTEM_CODE,
		CASE_MANAGER,
		HOURS_AUTHORIZED * CAST(
			(DATEDIFF(DAY, START_DATE_WITH_CUTOVER, END_DATE_WITH_CUTOVER) + 1)
			/ DAY(LAST_DAY(REPORT_DATE)) AS DECIMAL(12, 5)) AS HOURS_AUTHORIZED,
		HOURS_AUTHORIZED_NON_ADJUSTED,
		-- ETL Fields
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	FROM RESULTS DATA
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.CONFIGURATION CONFIG 
	ON CONFIG.SYSTEM_CODE=DATA.SYSTEM_CODE
	AND CONFIG.CONFIGURATION_ACTIVE=TRUE
	AND CONFIG.SYSTEM_CODE IS NOT NULL
	LEFT JOIN AUTHDATES AS AUTHDT ON AUTHDT.SERVICE_CLIENT_ID= DATA.CLIENT_NUMBER 
				AND AUTHDT.SERVICE_FUNDER_ID=DATA.CONTRACT_CODE -- ADDED BY PJSHAH ON 22042022
	WHERE REPORT_DATE BETWEEN DATE_TRUNC(MONTH, START_DATE_WITH_CUTOVER) AND LAST_DAY(END_DATE_WITH_CUTOVER);
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

