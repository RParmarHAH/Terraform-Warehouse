CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_CLIENT_CROSS_WALK()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

/**********************************************************************************************************
--Name: CLIENT_CROSS_WALK 
--Purpose:- The Table populates the CLIENTS which are part of multiple programs.EX.
--Devlopment Logs:-
--Date          Author              Notes
--02/17/2023    Mohan Kewlani       Initial Development
--14/03/2023	Mohan kewlani		Modified PAHW Client logic to add additiona open system clients
--24/07/2023    AKASH THAKKER       Added New Partner AmeriHealth and PAHW Population logic should be looking at latest payor
***********************************************************************************************************/
INSERT OVERWRITE INTO DW_PROD.integration.client_cross_walk
WITH PAHW_CLIENTS AS 
(SELECT CLIENT_KEY
			, CLIENT_FIRST_NAME
			, CLIENT_LAST_NAME
			, CLIENT_ZIP
	FROM
	(
		SELECT FV.CLIENT_KEY
				, DC.CLIENT_FIRST_NAME
				, DC.CLIENT_LAST_NAME
				, DC.CLIENT_ZIP
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
		SELECT FV.CLIENT_KEY
				, DC.CLIENT_FIRST_NAME
				, DC.CLIENT_LAST_NAME
				, DC.CLIENT_ZIP
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
				AND FV.BRANCH_KEY IN (SELECT BRANCH_KEY FROM DW_PROD.HAH.DIM_BRANCH 
                        		 	  WHERE OFFICE_STATE_CODE = ''PA''
                          		  	  AND OFFICE_CITY IN (''ERIE'',''LACKAWANNA'',''LUZERNE'',''MONROE'',''PHILADELPHIA''))
		-- Added QUALIFY to look at the Payor/Contract from last confirmed visit
		QUALIFY ROW_NUMBER() OVER (PARTITION BY FV.CLIENT_KEY ORDER BY FV.SERVICE_DATE DESC) = 1
	)
	WHERE IS_PAHW = TRUE
),
CENTENE_CLIENTS AS (
	SELECT AMS.ID AS AMS_CLIENT_KEY,CENTENE.ID AS CENTENE_CLIENT_KEY
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_CENTENE_RL_OUTPUT AMS 
	JOIN DW_PROD.INTEGRATION.DIM_CLIENT_CENTENE_RL_OUTPUT CENTENE ON AMS.CLUSTER_ID=CENTENE.CLUSTER_ID 
	WHERE AMS.SOURCE_SYSTEM_ID<>27 AND CENTENE.SOURCE_SYSTEM_ID=27
),
OSH_CLIENTS AS(
	SELECT AMS.ORIGINAL_CLIENT_KEY AS AMS_CLIENT_KEY, OSH.ORIGINAL_CLIENT_KEY AS OSH_CLIENT_KEY
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED  AS AMS
	JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED AS OSH 
	ON upper(Trim(AMS.CLIENT_FIRST_NAME))=upper(trim(OSH.CLIENT_FIRST_NAME)) 
	AND upper(trim(AMS.CLIENT_LAST_NAME))=upper(trim(OSH.CLIENT_LAST_NAME)) 
	AND AMS.CLIENT_DOB=OSH.CLIENT_DOB 
	AND AMS.CLIENT_ZIP=OSH.CLIENT_ZIP
	JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM DSS 
	ON AMS.SOURCE_SYSTEM_ID=DSS.SOURCE_SYSTEM_ID 
	AND DSS.SOURCE_SYSTEM_TYPE=''AMS''
	WHERE OSH.ORIGINAL_SOURCE_SYSTEM_ID=24
	AND AMS.ORIGINAL_SOURCE_SYSTEM_ID<>24
	AND AMS.ORIGINAL_CLIENT_KEY=AMS.CLIENT_KEY
	AND OSH.ORIGINAL_CLIENT_KEY=OSH.CLIENT_KEY
),
MOLINA_CLIENTS AS
	(SELECT AMS.ID AS AMS_CLIENT_KEY,MOLINA.ID AS MOLINA_CLIENT_KEY
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MOLINA_RL_OUTPUT AMS 
	JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MOLINA_RL_OUTPUT MOLINA ON AMS.CLUSTER_ID=MOLINA.CLUSTER_ID 
	WHERE AMS.SOURCE_SYSTEM_ID<>32 AND MOLINA.SOURCE_SYSTEM_ID=32
	)
, AMERIHEALTH_CLIENTS AS 
(
	SELECT AMS.ID AS AMS_CLIENT_KEY
			, AMERIHEALTH.ID AS AMERIHEALTH_CLIENT_KEY
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_AMERIHEALTH_RL_OUTPUT AMS 
	INNER JOIN DW_PROD.INTEGRATION.DIM_CLIENT_AMERIHEALTH_RL_OUTPUT AMERIHEALTH 
		ON AMS.CLUSTER_ID = AMERIHEALTH.CLUSTER_ID 
	WHERE AMS.SOURCE_SYSTEM_ID <> 35
			AND AMERIHEALTH.SOURCE_SYSTEM_ID = 35
),
RESULT  AS (
	SELECT DC.CLIENT_KEY AS AMS_CLIENT_KEY,PAHW.CLIENT_KEY AS PAHW_CLIENTS,CC.CENTENE_CLIENT_KEY AS CENTENE_CLIENTS,OSH.OSH_CLIENT_KEY AS OSH_CLIENTS 
	,MOL.MOLINA_CLIENT_KEY AS MOLINA_CLIENTS,AHC.AMERIHEALTH_CLIENT_KEY AS AMERIHEALTH_CLIENTS
	FROM DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DC
	LEFT JOIN PAHW_CLIENTS PAHW ON PAHW.CLIENT_KEY=DC.ORIGINAL_CLIENT_KEY
	LEFT JOIN CENTENE_CLIENTS CC ON DC.ORIGINAL_CLIENT_KEY=CC.AMS_CLIENT_KEY 
	LEFT JOIN OSH_CLIENTS OSH ON DC.ORIGINAL_CLIENT_KEY=OSH.AMS_CLIENT_KEY
	LEFT JOIN MOLINA_CLIENTS MOL ON DC.ORIGINAL_CLIENT_KEY=MOL.AMS_CLIENT_KEY
	LEFT JOIN AMERIHEALTH_CLIENTS AHC ON DC.ORIGINAL_CLIENT_KEY = AHC.AMS_CLIENT_KEY
	WHERE DC.ORIGINAL_CLIENT_KEY=DC.CLIENT_KEY
)
SELECT * FROM RESULT;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';