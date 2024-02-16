CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_ROSTER_AMS_MAPPING_HISTORY("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  ROSTER_AMS_MAPPING_HISTORY
--
-- PURPOSE: Creates one row per CLIENT  
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                	NOTES:
-- --------    -------------------   	-----------------------------------------------------------------------------------------------
-- 05/02/23    	AKASH THAKKER          	Initial development
--*****************************************************************************************************************************
--------------------------------------------
-- IS_LATEST FLAG UPDATE
--------------------------------------------
--Updating all the IS_LATEST flag to False becuase ahead we will check 
--and update flag to True if needed after comparing.
--------------------------------------------------------------------------------------------------------------
UPDATE 
	DW_PROD.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY
SET IS_LATEST = FALSE;
-------------------------------------------
-- Comparing
-------------------------------------------
--We are comparing the Ams_client_key, Partner_client_key, and Roster_name in the ROSTER_AMS_MAPPING_HISTORY
--table. If a match is found, the Is_latest flag will remain "True" because these are matched clients
--and record is already inserted in the table and will be remain latest, 
--we will continue to keep the flag "True".
--------------------------------------------------------------------------------------------------------------
MERGE INTO DW_PROD.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY AS  HIST
USING (
WITH ROSTER_CLIENT AS
(SELECT * FROM (
	SELECT  AMS.ID AS AMS_CLIENT_KEY
	        , CENTENE.ID AS PARTNER_CLIENT_KEY
	        , ''CENTENE'' AS ROSTER_NAME
	        ,max(v.DERIVED_LAST_SERVICE_DATE) AS latest_service_date,
		DENSE_RANK() OVER (PARTITION BY PARTNER_CLIENT_KEY
	ORDER BY
		max(NVL(v.DERIVED_LAST_SERVICE_DATE, ''1900-01-01'')) DESC) R
		,NVL(SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE, ''AMS'') AS SOURCE_SYSTEM_TYPE
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_CENTENE_RL_OUTPUT AMS 
	INNER JOIN DW_PROD.INTEGRATION.DIM_CLIENT_CENTENE_RL_OUTPUT CENTENE 
	    ON AMS.CLUSTER_ID = CENTENE.CLUSTER_ID
	INNER  JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED v ON
		AMS.ID = v.CLIENT_KEY
	INNER JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM SOURCE_SYSTEM
		ON SOURCE_SYSTEM.SOURCE_SYSTEM_ID = v.SOURCE_SYSTEM_ID
		AND SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE=''AMS''
	WHERE AMS.SOURCE_SYSTEM_ID <> 27 
	        AND CENTENE.SOURCE_SYSTEM_ID = 27
	GROUP BY
		ALL) WHERE R=1
	UNION
	SELECT * FROM (
SELECT AMS.ORIGINAL_CLIENT_KEY AS AMS_CLIENT_KEY
			, OSH.ORIGINAL_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, ''OSH'' AS ROSTER_NAME
			,AMS.DERIVED_LAST_SERVICE_DATE AS latest_service_date
			,DENSE_RANK() OVER (PARTITION BY PARTNER_CLIENT_KEY
			ORDER BY max(NVL(AMS.DERIVED_LAST_SERVICE_DATE, ''1900-01-01'')) DESC) R
			,DSS.SOURCE_SYSTEM_TYPE
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED  AS AMS
	INNER JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED AS OSH 
	    ON UPPER(TRIM(AMS.CLIENT_FIRST_NAME)) = UPPER(TRIM(OSH.CLIENT_FIRST_NAME)) 
	    	AND UPPER(TRIM(AMS.CLIENT_LAST_NAME)) = UPPER(TRIM(OSH.CLIENT_LAST_NAME)) 
	    	AND AMS.CLIENT_DOB=OSH.CLIENT_DOB 
	    	AND AMS.CLIENT_ZIP=OSH.CLIENT_ZIP
    INNER JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM DSS 
    	ON AMS.SOURCE_SYSTEM_ID = DSS.SOURCE_SYSTEM_ID 
    		AND DSS.SOURCE_SYSTEM_TYPE=''AMS''
	WHERE OSH.ORIGINAL_SOURCE_SYSTEM_ID = 24
	    	AND AMS.ORIGINAL_SOURCE_SYSTEM_ID <> 24
	    	AND AMS.ORIGINAL_CLIENT_KEY=AMS.CLIENT_KEY
	    	AND OSH.ORIGINAL_CLIENT_KEY=OSH.CLIENT_KEY
	GROUP BY ALL) WHERE R=1
	UNION
	SELECT * FROM (SELECT AMS.ID AS AMS_CLIENT_KEY
			, MOLINA.ID AS PARTNER_CLIENT_KEY 
			, ''MOLINA'' AS ROSTER_NAME
			,max(v.DERIVED_LAST_SERVICE_DATE) AS latest_service_date,
		DENSE_RANK() OVER (PARTITION BY PARTNER_CLIENT_KEY
	ORDER BY
		max(NVL(v.DERIVED_LAST_SERVICE_DATE, ''1900-01-01'')) DESC) R
		,NVL(SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE, ''AMS'') AS SOURCE_SYSTEM_TYPE
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MOLINA_RL_OUTPUT AMS 
	INNER JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MOLINA_RL_OUTPUT MOLINA 
		ON AMS.CLUSTER_ID=MOLINA.CLUSTER_ID 
	INNER  JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED v ON
		AMS.ID = v.CLIENT_KEY
	INNER JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM SOURCE_SYSTEM
		ON SOURCE_SYSTEM.SOURCE_SYSTEM_ID = v.SOURCE_SYSTEM_ID
		AND SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE=''AMS''
	WHERE AMS.SOURCE_SYSTEM_ID <> 32 
			AND MOLINA.SOURCE_SYSTEM_ID = 32
	GROUP BY ALL) WHERE R=1 
	UNION
	SELECT * FROM (SELECT AMS.ID AS AMS_CLIENT_KEY
			, AHC.ID AS PARTNER_CLIENT_KEY
			, ''AMERIHEALTH'' AS ROSTER_NAME 
			,max(v.DERIVED_LAST_SERVICE_DATE) AS latest_service_date,
		DENSE_RANK() OVER (PARTITION BY PARTNER_CLIENT_KEY
	ORDER BY
		max(NVL(v.DERIVED_LAST_SERVICE_DATE, ''1900-01-01'')) DESC) R
		,NVL(SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE, ''AMS'') AS SOURCE_SYSTEM_TYPE
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_AMERIHEALTH_RL_OUTPUT AMS
	INNER JOIN DW_PROD.INTEGRATION.DIM_CLIENT_AMERIHEALTH_RL_OUTPUT AHC 
		ON AMS.CLUSTER_ID = AHC.CLUSTER_ID
	INNER JOIN DISC_PROD.AMERIHEALTH.AMERIHEALTH_SOURCE_DATA AHC_CURRENT_ROSTER 
		ON AHC_CURRENT_ROSTER.EXTERNAL_ID = AHC.CLIENT_NUMBER
	INNER  JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED v ON
		AMS.ID = v.CLIENT_KEY
	INNER JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM SOURCE_SYSTEM
		ON SOURCE_SYSTEM.SOURCE_SYSTEM_ID = v.SOURCE_SYSTEM_ID
		AND SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE=''AMS''
	WHERE AMS.SOURCE_SYSTEM_ID <> 35
			AND AHC.SOURCE_SYSTEM_ID = 35
	GROUP BY ALL ) WHERE R=1
	UNION
	SELECT DC.CLIENT_KEY AS AMS_CLIENT_KEY
			, DC.CLIENT_KEY AS PARTNER_CLIENT_KEY
			, ''ORIGINAL_PILOT'' AS ROSTER_NAME
			,NULL AS latest_service_date
			,NULL AS R
			,NULL AS SOURCE_SYSTEM_TYPE
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DC
	INNER JOIN APP_DB_PROD.CARE_COORDINATION.CLIENT_LIST_50 CL 
		ON CL.CLIENT_KEY = DC.ORIGINAL_CLIENT_KEY
	UNION 
	SELECT AMS_CLIENT_KEY, PARTNER_CLIENT_KEY, ROSTER_NAME
			,NULL AS latest_service_date
			,NULL AS R
			,NULL AS SOURCE_SYSTEM_TYPE
			FROM ( 
		SELECT FV.CLIENT_KEY AS AMS_CLIENT_KEY
				, FV.CLIENT_KEY AS PARTNER_CLIENT_KEY 
				, ''HMNYHF_ROSTER'' AS ROSTER_NAME
		, FALSE AS IS_FIXED
		, (CON.CONTRACT_NAME ILIKE ''%HealthFirst%'') AS IS_HealthFirst
		FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DC
		INNER JOIN DW_PROD.INTEGRATION.FACT_VISIT_MERGED FV
			ON DC.ORIGINAL_CLIENT_KEY = FV.CLIENT_KEY
		INNER JOIN DW_PROD.HAH.DIM_CONTRACT CON
			ON FV.CONTRACT_KEY = CON.CONTRACT_KEY 
		INNER JOIN DW_PROD.HAH.DIM_BRANCH PA_BRANCH
			ON PA_BRANCH.BRANCH_KEY = FV.BRANCH_KEY 
		WHERE FV.CONFIRMED_FLAG =''YES'' 
		AND CON.SOURCE_SYSTEM_ID = 17 
		AND CON.SYSTEM_CODE  IN (''PREFERRED'',''EDISON'') AND IS_HealthFirst = TRUE
		-- Added QUALIFY to look at the Payor/Contract from last confirmed visit
		QUALIFY ROW_NUMBER() OVER (PARTITION BY FV.CLIENT_KEY ORDER BY FV.SERVICE_DATE DESC) = 1
		)
	UNION 
	SELECT DISTINCT DC.CLIENT_KEY AS AMS_CLIENT_KEY
			, cl.CLIENT_KEY AS PARTNER_CLIENT_KEY
			, ''HMILCCCG_ROSTER'' AS ROSTER_NAME
			, NULL AS latest_service_date
			, NULL AS R
			, NULL AS SOURCE_SYSTEM_TYPE
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DC
	INNER JOIN APP_DB_PROD.CARE_COORDINATION.CLIENT_LIST_CC_AND_CCCG CL 
		ON CL.CLIENT_KEY = DC.ORIGINAL_CLIENT_KEY
		WHERE cl.TEST_OR_CONTROL = ''0''
	UNION
	SELECT DISTINCT DC.CLIENT_KEY
			, cl.CLIENT_KEY AS PARTNER_CLIENT_KEY
			, ''HMILCC_ROSTER'' AS ROSTER_NAME
			, NULL AS latest_service_date
			, NULL AS R
			, NULL AS SOURCE_SYSTEM_TYPE
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DC
	INNER JOIN APP_DB_PROD.CARE_COORDINATION.CLIENT_LIST_CC_AND_CCCG CL 
		ON CL.CLIENT_KEY = DC.ORIGINAL_CLIENT_KEY
	INNER JOIN DW_PROD.INTEGRATION.FACT_VISIT_MERGED FV
		ON DC.ORIGINAL_CLIENT_KEY = FV.CLIENT_KEY
	INNER JOIN DW_PROD.HAH.DIM_CONTRACT CON
		ON FV.CONTRACT_KEY = CON.CONTRACT_KEY 
		WHERE cl.TEST_OR_CONTROL = ''1'' AND con.CONTRACT_NAME = ''MCO COUNTY CARE'' 
	UNION
	-- The PAHW clients are not getting populated from Roster
	-- The way to identify the PAHW Client is to look at the Clients received service in PA and payor is Centene
	SELECT AMS_CLIENT_KEY
		, PARTNER_CLIENT_KEY
		, ROSTER_NAME
		,NULL AS latest_service_date
		,NULL AS R
		,NULL AS SOURCE_SYSTEM_TYPE
	FROM
	(
		SELECT FV.CLIENT_KEY AS AMS_CLIENT_KEY
					, FV.CLIENT_KEY AS PARTNER_CLIENT_KEY 
					, ''PAHW_ROSTER'' AS ROSTER_NAME
					, FALSE AS IS_FIXED
					, (C.CONTRACT_CODE = ''PHW'') AS IS_PAHW
		FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DC
		INNER JOIN DW_PROD.INTEGRATION.FACT_VISIT_MERGED FV
				ON DC.ORIGINAL_CLIENT_KEY = FV.CLIENT_KEY
		INNER JOIN DW_PROD.HAH.DIM_CONTRACT C
			ON C.CONTRACT_KEY = FV.CONTRACT_KEY 
		WHERE FV.CONFIRMED_FLAG = ''YES''
		-- Added QUALIFY to look at the Payor/Contract from last confirmed visit
		QUALIFY ROW_NUMBER() OVER (PARTITION BY FV.CLIENT_KEY ORDER BY FV.SERVICE_DATE DESC) = 1
		UNION
		SELECT FV.CLIENT_KEY AS AMS_CLIENT_KEY
				, FV.CLIENT_KEY AS PROGRAM_CLIENT_KEY 
				, ''PAHW_ROSTER'' AS ROSTER_NAME
				, FALSE AS IS_FIXED
				, (CON.CONTRACT_NAME ILIKE ''%CENTENE%'') AS IS_PAHW
		FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DC
		INNER JOIN DW_PROD.INTEGRATION.FACT_VISIT_MERGED FV
			ON DC.ORIGINAL_CLIENT_KEY = FV.CLIENT_KEY
		INNER JOIN DW_PROD.HAH.DIM_CONTRACT CON
			ON FV.CONTRACT_KEY = CON.CONTRACT_KEY 
		INNER JOIN DW_PROD.HAH.DIM_BRANCH PA_BRANCH
			ON PA_BRANCH.BRANCH_KEY = FV.BRANCH_KEY 
		WHERE FV.CONFIRMED_FLAG =''YES'' 
				AND CON.SOURCE_SYSTEM_ID = 17 
				AND CON.SYSTEM_CODE  IN (''OPENSYSTEMS - PA'',''OSHAH - PA'')
		-- Added QUALIFY to look at the Payor/Contract from last confirmed visit
		QUALIFY ROW_NUMBER() OVER (PARTITION BY FV.CLIENT_KEY ORDER BY FV.SERVICE_DATE DESC) = 1
	)
	WHERE IS_PAHW = TRUE
)SELECT AMS_CLIENT_KEY,PARTNER_CLIENT_KEY,ROSTER_NAME FROM ROSTER_CLIENT) AS CURR
ON
	HIST.AMS_CLIENT_KEY = CURR.AMS_CLIENT_KEY
	AND HIST.PARTNER_CLIENT_KEY = CURR.PARTNER_CLIENT_KEY
	AND HIST.ROSTER_NAME = CURR.ROSTER_NAME
	AND HIST.UNMATCHED_DATE IS NULL
WHEN MATCHED THEN 
UPDATE
SET
	HIST.IS_LATEST = TRUE
-------------------------------------------
-- Not Matched
-------------------------------------------
--When a comparison does not result in a match, there is a possibility that a new client might 
--become matched. Additionally, if a client was matched in the past but became unmatched for a period 
--and then matched again, a new entry will be created in the history table with the new matched date, 
--preceding any previous unmatched periods.
-----------------------------------------------------------------------------------------------------
WHEN NOT MATCHED THEN 
INSERT
	(
	Ams_client_key,
	PARTNER_CLIENT_KEY,
	ROSTER_NAME,
	MATCHED_DATE,
	UNMATCHED_DATE,
	IS_LATEST,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG)
VALUES
(
	CURR.AMS_CLIENT_KEY,
	CURR.PARTNER_CLIENT_KEY,
	CURR.ROSTER_NAME,
	current_date,
	Null,
	True,
	:STR_ETL_TASK_KEY,
	:STR_ETL_TASK_KEY,
	convert_timezone(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ,
	CURRENT_USER,
	convert_timezone(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ,
	CURRENT_USER,
	0
);
-------------------------------------------
-- UNMATCHED_DATE UPDATE
-------------------------------------------
--update the UNMATCHED_DATE because last there will be the records which are not matched 
--whose IS_LATEST Flag will be False.
---------------------------------------------------------------------------------------------------------------
UPDATE
	DW_PROD.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY
SET
	UNMATCHED_DATE = CURRENT_DATE,
	ETL_LAST_UPDATED_DATE=convert_timezone(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ,
	ETL_LAST_UPDATED_BY=CURRENT_USER
WHERE
	IS_LATEST = FALSE AND UNMATCHED_DATE IS NULL;
-------------------------------------------
-- IS_LATEST FLAG UPDATE
-------------------------------------------
--update the "IS_LATEST" flag as "True" for the latest client entry because it shows the latest 
--clients updates throught the flag.
--------------------------------------------------------------------------------------------------------------
UPDATE 
	DW_PROD.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY AS UPD
SET IS_LATEST=TRUE 
WHERE
(UPD.PARTNER_CLIENT_KEY,UPD.ROSTER_NAME,UPD.ETL_INSERTED_DATE)
IN (SELECT 
		PARTNER_CLIENT_KEY,
		ROSTER_NAME,
		max(ETL_INSERTED_DATE) AS LATEST_INSERTED_DATE
FROM DW_PROD.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY
GROUP BY ALL);
return ''SUCCESS'';
END;
';