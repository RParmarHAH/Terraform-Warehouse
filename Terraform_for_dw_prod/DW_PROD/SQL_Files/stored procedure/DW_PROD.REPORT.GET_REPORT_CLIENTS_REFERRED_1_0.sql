CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_CLIENTS_REFERRED_1_0("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN
INSERT OVERWRITE INTO DW_PROD.REPORT.CLIENTS_REFERRED_1_0
WITH FUTURE_VISITS AS 
(
SELECT
	CLIENT_KEY,
	MIN(REPORT_DATE) AS NEXT_SCHEDULED_VISIT_DATE
FROM
	INTEGRATION.FACT_VISIT_MERGED FVM
LEFT JOIN HAH.DIM_CONTRACT DC ON
	DC.CONTRACT_KEY = FVM.CONTRACT_KEY
WHERE
	FVM.REPORT_DATE>CURRENT_DATE
	AND DC.BILLABLE_FLAG = ''TRUE''
GROUP BY
	CLIENT_KEY
)
, FUTURE_VISITS_EVV AS 
(
SELECT
	CLIENT_KEY,
	MIN(REPORT_DATE) AS NEXT_SCHEDULED_VISIT_DATE
FROM
	HAH.FACT_EVV_VISIT FE
LEFT JOIN HAH.DIM_CONTRACT DC ON
	DC.CONTRACT_KEY = FE.CONTRACT_KEY
WHERE
	FE.REPORT_DATE>CURRENT_DATE
	AND DC.BILLABLE_FLAG = ''TRUE''
GROUP BY
	CLIENT_KEY 
),OPEN_REFERREL AS (SELECT V.CLIENT_KEY 
	, MIN( V.REPORT_DATE  ) AS FIRST_BILLABLE_SERVICE
	, MAX( V.REPORT_DATE  ) AS LAST_BILLABLE_SERVICE
	FROM DW_PROD.INTEGRATION.FACT_VISIT_MERGED V
	LEFT JOIN DW_PROD.HAH.DIM_CONTRACT  DC ON DC.CONTRACT_KEY = V.CONTRACT_KEY
	JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED C ON V.ORIGINAL_CLIENT_KEY = C.ORIGINAL_CLIENT_KEY
	WHERE DC.BILLABLE_FLAG =TRUE
	GROUP BY ALL)
, CLIENTS_SERVICE_DATES AS (
	SELECT V.CLIENT_KEY 
	, MIN(V.REPORT_DATE) AS FIRST_SERVICE_DATE
	, MAX(V.REPORT_DATE) AS LAST_SERVICE_DATE
	FROM DW_PROD.INTEGRATION.FACT_VISIT_MERGED V
--	LEFT JOIN DW_PROD.HAH.DIM_CONTRACT  DC ON DC.CONTRACT_KEY = V.CONTRACT_KEY
	JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED C ON V.ORIGINAL_CLIENT_KEY = C.ORIGINAL_CLIENT_KEY
	WHERE CONFIRMED_FLAG =''YES''
	GROUP BY ALL
), CLIENT_METRIC AS (
	SELECT DISTINCT A.*
	,FIRST_VALUE(V.SUPERVISOR_KEY) OVER(PARTITION BY A.CLIENT_KEY ORDER BY V.REPORT_DATE,V.HOURS_SERVED DESC) AS SUPERVISOR_KEY
--	, V.BRANCH_KEY 
	,FIRST_VALUE(V.BRANCH_KEY) OVER(PARTITION BY A.CLIENT_KEY ORDER BY V.REPORT_DATE) AS BRANCH_KEY
	,FIRST_VALUE(V2.ORIGINAL_BRANCH_KEY) OVER (PARTITION BY A.CLIENT_KEY ORDER BY IFF(V.CLIENT_KEY=V2.ORIGINAL_CLIENT_KEY ,0,1)) AS ORIGINAL_BRANCH_KEY
	FROM CLIENTS_SERVICE_DATES A
	JOIN DW_PROD.INTEGRATION.FACT_VISIT_MERGED V ON A.CLIENT_KEY  = V.CLIENT_KEY AND A.FIRST_SERVICE_DATE = V.REPORT_DATE AND v.CONFIRMED_FLAG =''YES''
	JOIN DW_PROD.INTEGRATION.FACT_VISIT_MERGED V2 ON A.CLIENT_KEY  = V2.CLIENT_KEY  AND v2.CONFIRMED_FLAG =''YES''
),
CLIENT_INFO AS 
(
	SELECT DISTINCT  I.CONTRACT_KEY AS FIRST_CONTRACT_KEY
					, NULL AS FIRST_PARTNER_CONTRACT_SERVICE_KEY
					, NULL AS TYPE
					, C.REFERRALS 
					, I.HOURS_AUTHORIZED_NON_ADJUSTED AS FIRST_NON_ADJUSTED_AUTH_HOURS
					, I.HOURS_AUTHORIZED AS FIRST_ADJUSTED_AUTH_HOURS
					, COALESCE(FEV.NEXT_SCHEDULED_VISIT_DATE,FV.NEXT_SCHEDULED_VISIT_DATE) NEXT_SCHEDULED_VISIT_DATE
					, C.CLIENT_NUMBER
					, C.CLIENT_KEY
					, C.SOURCE_SYSTEM_ID
					, FIRST_VALUE(COALESCE(c.Original_Source_System_Id, -1)) OVER (PARTITION BY c.Client_Key ORDER BY IFF(c.Original_Source_System_ID <> c.Source_System_ID, 0, 1)) AS Original_Source_System_ID
					, C.CLIENT_NAME
					, C.CLIENT_HOME_PHONE
					, C.CLIENT_WORK_PHONE
					, COALESCE(CM.SUPERVISOR_KEY,C.PRIMARY_SUPERVISOR_KEY,C.SECONDARY_SUPERVISOR_KEY) AS SUPERVISOR_KEY
					,CM.BRANCH_KEY
					,CM.ORIGINAL_BRANCH_KEY
--					,CM.FIRST_SERVICE_DATE AS FIRST_VISIT_DATE
--					,CM.LAST_SERVICE_DATE AS LATEST_VISIT_DATE
					,FIRST_VALUE(CSD.FIRST_BILLABLE_SERVICE) IGNORE NULLS OVER(PARTITION BY C.CLIENT_KEY ORDER BY CSD.FIRST_BILLABLE_SERVICE DESC) AS FIRST_VISIT_DATE
					,FIRST_VALUE(CSD.LAST_BILLABLE_SERVICE) IGNORE NULLS OVER(PARTITION BY C.CLIENT_KEY ORDER BY CSD.LAST_BILLABLE_SERVICE DESC) AS LATEST_VISIT_DATE
					,C.DERIVED_REFERRAL_DATE AS REFERRED_DATE
					, CASE WHEN (FIRST_VISIT_DATE IS NOT NULL AND C.DAYS_TO_SERVICE IS NOT NULL) THEN DATEDIFF(''DAY'',REFERRED_DATE,FIRST_VISIT_DATE) 
  						   ELSE NULL END AS DAYS_TO_SERVICE
					, CASE WHEN C.END_DATE IS NOT NULL 
							THEN CASE WHEN FIRST_VISIT_DATE IS NULL AND LATEST_VISIT_DATE IS NULL AND C.END_DATE>=CURRENT_DATE THEN 1 ELSE 0 END
						   ELSE CASE WHEN FIRST_VISIT_DATE IS NULL AND LATEST_VISIT_DATE IS NULL THEN 1 ELSE 0 END
					  END AS OPEN_REFERRAL
					, CASE WHEN OPEN_REFERRAL=1 THEN DATEDIFF(''DAY'',REFERRED_DATE,CURRENT_DATE) ELSE NULL END AS REFERRAL_AGE
FROM INTEGRATION.DIM_CLIENT_MERGED C
LEFT JOIN CLIENT_METRIC CM ON CM.CLIENT_KEY = C.CLIENT_KEY
LEFT JOIN OPEN_REFERREL CSD ON  CSD.CLIENT_KEY = C.CLIENT_KEY
LEFT JOIN INTEGRATION.FACT_INTAKE_MERGED I 
	ON C.ORIGINAL_CLIENT_KEY=I.ORIGINAL_CLIENT_KEY
LEFT JOIN FUTURE_VISITS FV 
	ON FV.CLIENT_KEY=C.CLIENT_KEY
LEFT JOIN FUTURE_VISITS_EVV FEV 
	ON FEV.CLIENT_KEY=C.CLIENT_KEY
WHERE C.SOURCE_SYSTEM_ID NOT IN (4,7,17,13,9,3,19,8,16,1,2)
QUALIFY DENSE_RANK() OVER (PARTITION BY C.CLIENT_KEY ORDER BY I.REPORT_DATE) = 1
)
SELECT DISTINCT FIRST_CONTRACT_KEY
				,FIRST_PARTNER_CONTRACT_SERVICE_KEY
				,TYPE
				, FIRST_ADJUSTED_AUTH_HOURS
				, FIRST_NON_ADJUSTED_AUTH_HOURS
				, NEXT_SCHEDULED_VISIT_DATE
				, CLIENT_NUMBER
				, CLIENT_KEY
				, SOURCE_SYSTEM_ID
				, ORIGINAL_SOURCE_SYSTEM_ID
				, CLIENT_NAME
				, CLIENT_HOME_PHONE
				, CLIENT_WORK_PHONE
				, SUPERVISOR_KEY
				, BRANCH_KEY
				, ORIGINAL_BRANCH_KEY
				, REFERRED_DATE
				, DAYS_TO_SERVICE
				, OPEN_REFERRAL
				, REFERRALS 
				, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
				, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
				, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
				, CURRENT_USER AS ETL_INSERTED_BY
				, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
				, CURRENT_USER AS ETL_LAST_UPDATED_BY
				, 0 AS ETL_DELETED_FLAG
FROM CLIENT_INFO ;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';