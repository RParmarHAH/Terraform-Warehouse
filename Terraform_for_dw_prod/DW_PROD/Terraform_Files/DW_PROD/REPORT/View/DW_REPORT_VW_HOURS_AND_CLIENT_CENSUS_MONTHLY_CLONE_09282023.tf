resource "snowflake_view" "DW_REPORT_VW_HOURS_AND_CLIENT_CENSUS_MONTHLY_CLONE_09282023" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_HOURS_AND_CLIENT_CENSUS_MONTHLY_CLONE_09282023"
	statement = <<-SQL
	 WITH DATES AS 
(
		SELECT FIRST_DAY_OF_MONTH, PERIOD_NAME
		FROM REPORT.VW_EXECUTIVE_OPERATIONS_EXCELLENCE_UTILIZATION_DIM_DATE
	),
	CONTRACTS_CLIENTS AS (
		SELECT C.CONTRACT_KEY,
			C.CONTRACT_CODE, 
			C.CONTRACT_NAME, 
			C.REVENUE_CATEGORY,
			INCLUDE_FOR_EXEC_OPS_CLIENTS AS INCLUDE_FOR_CLIENTS,
			--INCLUDE_FOR_EXEC_OPS_HOURS AS INCLUDE_FOR_HOURS,
			INCLUDE_FOR_OPS_PERF_HOURS
		FROM REPORT.VW_DASHBOARD_CONTRACTS C
		WHERE INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE --OR INCLUDE_FOR_EXEC_OPS_HOURS = TRUE 
		),
		CONTRACTS AS (
		SELECT DISTINCT C.CONTRACT_KEY,
			C.CONTRACT_CODE, 
			C.CONTRACT_NAME, 
			C.REVENUE_CATEGORY,
			--INCLUDE_FOR_EXEC_OPS_CLIENTS AS INCLUDE_FOR_CLIENTS,
			INCLUDE_FOR_EXEC_OPS_HOURS AS INCLUDE_FOR_HOURS,
			INCLUDE_FOR_OPS_PERF_HOURS
		FROM REPORT.VW_DASHBOARD_CONTRACTS C
		LEFT JOIN (SELECT DISTINCT CONTRACT_KEY ,BILL_UNIT_TYPE FROM HAH.FACT_VISIT) V ON C.CONTRACT_KEY = V.CONTRACT_KEY
		WHERE nvl(V.BILL_UNIT_TYPE,'Hourly') ='Hourly' AND --(INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE OR
		INCLUDE_FOR_EXEC_OPS_HOURS = TRUE 
	)
	, UTILIZATION_DATA_1 AS (
		SELECT  DATA.PERIOD_BEGIN_DATE,
		    DATA.PERIOD_BEGIN_DATE AS REPORT_DATE,
			DATES.PERIOD_NAME,
--			NULL AS TYPE,
			DATA.BRANCH_KEY,
			DATA.STATE,  
			DATA.OFFICE_NUMBER,
			DATA.OFFICE_NAME,
			DATA.SUPERVISOR_KEY,
			DATA.SUPERVISOR_CODE,
			DATA.ABSOLUTE_FIRST_SERVICE_DATE,
            DATA.ABSOLUTE_LAST_SERVICE_DATE,
			DATA.CLIENT_KEY AS CLIENT_KEY_DATA, 
			DATA.CLIENT_NUMBER, 
			DATA.ORIGINAL_SOURCE_SYSTEM_ID,
			DATA.SOURCE_SYSTEM_ID,
--			NULL AS SYSTEM_CODE,
			DATA.CONTRACT_KEY,
			DATA.CONTRACT_CODE,
--			NULL AS SERVICE_CODE,
--			NULL AS PARTNER_CODE,
			CONTRACT.CONTRACT_NAME,
			CC.INCLUDE_FOR_CLIENTS,
			CONTRACT.INCLUDE_FOR_HOURS,
			CONTRACT.REVENUE_CATEGORY,
			CASE WHEN CC.INCLUDE_FOR_CLIENTS = 1 THEN DATA.CLIENT_KEY END CLIENT_KEY,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 THEN DATA.HOURS_BILLED END, 0) HOURS_BILLED_ALL,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 THEN DATA.HOURS_SERVED END, 0) HOURS_SERVED_ALL,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 THEN DATA.HOURS_AUTHORIZED END, 0) HOURS_AUTHORIZED_ALL,
			COALESCE(CASE WHEN CONTRACT.INCLUDE_FOR_OPS_PERF_HOURS=1 THEN DATA.OVER_AUTHED_HOURS END,0) AS OVER_AUTHED_HOURS,
			COALESCE(CASE WHEN CONTRACT.INCLUDE_FOR_OPS_PERF_HOURS=1 THEN DATA.HOURS_AUTHORIZED_NON_ADJUSTED END,0) AS HOURS_AUTHORIZED_NON_ADJUSTED_ALL,
			COALESCE(CASE WHEN CONTRACT.INCLUDE_FOR_OPS_PERF_HOURS=1 THEN DATA.HOURS_SERVED END,0) AS HOURS_SERVED,
			CASE WHEN CONTRACT.INCLUDE_FOR_OPS_PERF_HOURS=1 THEN DATA.CLIENT_KEY ELSE NULL END AS CLIENT_KEY_HOURS,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_SERVED END, 0) HOURS_SERVED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_BILLED END, 0) HOURS_BILLED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_AUTHORIZED END, 0) HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN CONTRACT.INCLUDE_FOR_HOURS = 1 AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_AUTHORIZED_NON_ADJUSTED END, 0) HOURS_AUTHORIZED_NON_ADJUSTED_WHERE_AUTH_EXISTS,
			DATA.ETL_LAST_UPDATED_DATE,
			DATA.VISITS_ALL,
			DATA.VISITS_CLEAN_SHIFTS,
			DATA.VISITS_NEED_MAINTENANCE,
            IFF(COALESCE(CCSI_BRANCH.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY,MATRIXCARE_CLIENT.CLIENT_KEY ,ALAYACARE_CLIENT.CLIENT_KEY,PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY, PREFERRED_CLIENT.CLIENT_KEY,EDISON_CLIENT.CLIENT_KEY,MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY,LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY,ASR_CLIENT.CLIENT_KEY,CLEARCARE_CLIENT.CLIENT_KEY,ALLIANCE_CLIENT.CLIENT_KEY,OPENSYSTEMS_CLIENT.CLIENT_KEY,AXXESS_CLIENT.CLIENT_KEY, ALL_GEN_CLIENT.CLIENT_KEY) IS NULL, FALSE, TRUE) AS CLIENT_ACQUIRED_FLAG,
       CASE WHEN COALESCE(CCSI_BRANCH.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY) IS NOT NULL THEN 'CCSI' 
            WHEN MATRIXCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ADAPTIVE' 
            WHEN ALAYACARE_CLIENT.CLIENT_KEY IS NOT NULL THEN UPPER(ALAYACARE_CLIENT.AQUISITION_NAME)
			WHEN PREFERRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'PREFERRED'
            WHEN PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'PRAETORIAN' 
            WHEN EDISON_CLIENT.CLIENT_KEY IS NOT NULL THEN 'EDISON'
            WHEN MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'MERIDIUS'
            WHEN LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'LONGEVITY'
		    WHEN ASR_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ASR'
			WHEN CLEARCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'CLEARCARE'
			WHEN ALLIANCE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ALLIANCE'
			WHEN OPENSYSTEMS_CLIENT.CLIENT_KEY IS NOT NULL THEN 'OPENSYSTEMS'
			WHEN AXXESS_CLIENT.CLIENT_KEY IS NOT NULL THEN 'AXXESS'
			WHEN ALL_GEN_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ALL GENERATIONS'
            ELSE NULL END AS CLIENT_ACQUISITION_NAME,
      		DATA.NPS,
		    DATA.HOURS_SCHEDULED,
			DATA.HOURS_CANCELLED, 
			DATA.HOURS_IN_REVIEW,
			DATA.HOURS_MISSED, 
			DATA.HOURS_RESCHEDULED,
			DATA.FUTURE_HOURS,
			DATA.FUTURE_HOURS_NO_CAREGIVER,
			DATA.FUTURE_CANCELLED_HOURS, 
			DATA.FUTURE_HOLD_HOURS,
			DATA.VISITS_SCHEDULED, 
			DATA.VISITS_COMPLETED,
			DATA.VISITS_CANCELLED,
			DATA.VISITS_IN_REVIEW,
			DATA.VISITS_MISSED,
			DATA.VISITS_RESCHEDULED,
			DATA.FUTURE_VISITS,
			DATA.FUTURE_CANCELLED_VISITS,
			DATA.FUTURE_HOLD_VISITS,
			DATA.CLIENT_SERVED_FLAG
		FROM REPORT.UTILIZATION_1_0 AS DATA
		INNER JOIN CONTRACTS_CLIENTS CC ON CC.CONTRACT_KEY = DATA.CONTRACT_KEY
		left join DW_${var.SF_ENVIRONMENT}.REPORT.MS_OSHAH_CONTRACT_MAP mc on mc.client_key = data.client_key and mc.contract_key=data.contract_key and data.period_begin_date='2023-08-01' 																																																																																																																	  
		LEFT JOIN CONTRACTS CONTRACT
			ON CONTRACT.CONTRACT_KEY = DATA.CONTRACT_KEY
		JOIN DATES DATES 
			ON DATES.FIRST_DAY_OF_MONTH = DATA.PERIOD_BEGIN_DATE 
--LEFT OUTER JOIN (SELECT DISTINCT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 8) CCSI_BRANCH
--                        ON CCSI_BRANCH.BRANCH_KEY = DATA.ORIGINAL_BRANCH_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED CCSI_BRANCH ON 
	      CCSI_BRANCH.CLIENT_KEY = DATA.CLIENT_KEY AND
	      CCSI_BRANCH.CONTRACT_KEY = DATA.CONTRACT_KEY AND
	      CCSI_BRANCH.BRANCH_KEY = DATA.BRANCH_KEY AND
	      CCSI_BRANCH.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      CCSI_BRANCH.AQUISITION_NAME ='CCSI' 
LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED WHERE AQUISITION_NAME = 'CCSI') CCSI_ACQUIRED_CLIENT
                        ON CCSI_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND PERIOD_BEGIN_DATE >= '2021-07-01'      
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Altamaha') ALTAMAHA_CLIENT
--                        ON ALTAMAHA_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY  
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED ALAYACARE_CLIENT ON 
	      ALAYACARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      ALAYACARE_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
	      ALAYACARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      ALAYACARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      ALAYACARE_CLIENT.SOURCE_SYSTEM_ID = 9  
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Praetorian') PRAETORIAN_ACQUIRED_CLIENT
--                        ON PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND DATA.PERIOD_BEGIN_DATE >= '2022-01-01'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED PRAETORIAN_ACQUIRED_CLIENT ON 
	      PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      PRAETORIAN_ACQUIRED_CLIENT.AQUISITION_NAME ='Praetorian' AND 
	      DATA.PERIOD_BEGIN_DATE >= '2022-01-01'	      
--LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE branch_name like 'A__%' and system_code = 'MATRIXCARE') MATRIXCARE_BRANCH
--      ON MATRIXCARE_BRANCH.BRANCH_KEY = DATA.ORIGINAL_BRANCH_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED MATRIXCARE_CLIENT
      ON MATRIXCARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      MATRIXCARE_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      MATRIXCARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      MATRIXCARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      MATRIXCARE_CLIENT.AQUISITION_NAME ='ADAPTIVE'
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Preferred') PREFERRED_CLIENT
--         ON PREFERRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED PREFERRED_CLIENT
      ON PREFERRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      PREFERRED_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      PREFERRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      PREFERRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      PREFERRED_CLIENT.AQUISITION_NAME ='PREFERRED'
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Edison') EDISON_CLIENT
--         ON EDISON_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED EDISON_CLIENT
      ON EDISON_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      EDISON_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      EDISON_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      EDISON_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      EDISON_CLIENT.AQUISITION_NAME ='EDISON'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED MERIDIUS_ACQUIRED_CLIENT ON 
	      MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      MERIDIUS_ACQUIRED_CLIENT.AQUISITION_NAME ='Meridius'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED LONGEVITY_ACQUIRED_CLIENT ON 
	      LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      LONGEVITY_ACQUIRED_CLIENT.AQUISITION_NAME ='Longevity'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED ASR_CLIENT
      ON ASR_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      ASR_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      ASR_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      ASR_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      ASR_CLIENT.AQUISITION_NAME ='ASR'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED CLEARCARE_CLIENT
      ON CLEARCARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      CLEARCARE_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      CLEARCARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      CLEARCARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      CLEARCARE_CLIENT.AQUISITION_NAME ='CLEARCARE'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED ALLIANCE_CLIENT
      ON ALLIANCE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      ALLIANCE_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      ALLIANCE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      ALLIANCE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      ALLIANCE_CLIENT.AQUISITION_NAME ='ALLIANCE'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED OPENSYSTEMS_CLIENT
      ON OPENSYSTEMS_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      OPENSYSTEMS_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      OPENSYSTEMS_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      OPENSYSTEMS_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      OPENSYSTEMS_CLIENT.AQUISITION_NAME ='OPENSYSTEMS'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED AXXESS_CLIENT
      ON AXXESS_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      AXXESS_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      AXXESS_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      AXXESS_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      AXXESS_CLIENT.AQUISITION_NAME ='AXXESS'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED ALL_GEN_CLIENT
      ON ALL_GEN_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      ALL_GEN_CLIENT.CONTRACT_KEY = DATA.CONTRACT_KEY AND
      ALL_GEN_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      ALL_GEN_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      ALL_GEN_CLIENT.AQUISITION_NAME ='All Generations'
WHERE PERIOD_BEGIN_DATE <= DATEADD( 'MONTH', 2, CURRENT_DATE)
AND IFF(DATA.CLIENT_SERVED_FLAG = TRUE, NVL(DATA.HOURS_SERVED, 0), 1) > 0
and mc.client_key is null
--AND NOT(DATA.SOURCE_SYSTEM_ID IN (17,7,4)-- AND DATA.STATE='DE')
	--)
	)
    ,
	FINAL_UTILIZATION_1 AS (
	SELECT DISTINCT PERIOD_BEGIN_DATE, PERIOD_NAME,--	TYPE,
	STATE, BRANCH_KEY, OFFICE_NUMBER, OFFICE_NAME, SUPERVISOR_KEY, SUPERVISOR_CODE, 
ABSOLUTE_FIRST_SERVICE_DATE, ABSOLUTE_LAST_SERVICE_DATE,	
CLIENT_KEY_DATA, CLIENT_NUMBER,	ORIGINAL_SOURCE_SYSTEM_ID, SOURCE_SYSTEM_ID,-- SYSTEM_CODE,
CONTRACT_KEY, NULL AS PARTNER_CONTRACT_SERVICE_KEY, CONTRACT_CODE, --SERVICE_CODE,PARTNER_CODE,
CLIENT_KEY, HOURS_SCHEDULED, HOURS_CANCELLED, HOURS_IN_REVIEW, HOURS_MISSED, HOURS_RESCHEDULED,	FUTURE_HOURS,FUTURE_HOURS_NO_CAREGIVER,
FUTURE_CANCELLED_HOURS, FUTURE_HOLD_HOURS,													
HOURS_SERVED_WHERE_AUTH_EXISTS,	HOURS_BILLED_WHERE_AUTH_EXISTS,	HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,	HOURS_AUTHORIZED_NON_ADJUSTED_WHERE_AUTH_EXISTS,
HOURS_SERVED_ALL, HOURS_BILLED_ALL,	HOURS_AUTHORIZED_ALL,	HOURS_AUTHORIZED_NON_ADJUSTED_ALL,
INCLUDE_FOR_CLIENTS,	INCLUDE_FOR_HOURS, REVENUE_CATEGORY,	
VISITS_ALL,	VISITS_CLEAN_SHIFTS,	VISITS_NEED_MAINTENANCE,	
VISITS_SCHEDULED,	VISITS_COMPLETED,	VISITS_CANCELLED,	VISITS_IN_REVIEW,	VISITS_MISSED,	VISITS_RESCHEDULED,	FUTURE_VISITS,	FUTURE_CANCELLED_VISITS,	FUTURE_HOLD_VISITS,	
CLIENT_ACQUIRED_FLAG,	CLIENT_ACQUISITION_NAME,	CLIENT_SERVED_FLAG,	NPS, ETL_LAST_UPDATED_DATE
	FROM UTILIZATION_DATA_1
	)
	,UTILIZATION_DATA_2 AS (
		SELECT DATA.PERIOD_BEGIN_DATE,
		    DATA.PERIOD_BEGIN_DATE AS REPORT_DATE,
			DATES.PERIOD_NAME,
--			DATA.TYPE,
			DATA.BRANCH_KEY,
			DATA.STATE,  
			DATA.OFFICE_NUMBER,
			DATA.OFFICE_NAME,
			DATA.SUPERVISOR_KEY,
			DATA.SUPERVISOR_CODE,
			DATA.ABSOLUTE_FIRST_SERVICE_DATE,
            DATA.ABSOLUTE_LAST_SERVICE_DATE,
			DATA.CLIENT_KEY AS CLIENT_KEY_DATA, 
			DATA.CLIENT_NUMBER, 
			DATA.ORIGINAL_SOURCE_SYSTEM_ID,
			DATA.SOURCE_SYSTEM_ID,
--			PCS.SYSTEM_CODE ,
			DATA.CONTRACT_KEY,
			DATA.PARTNER_CONTRACT_SERVICE_KEY,
			DATA.CONTRACT_CODE,
			--DATA.CONTRACT_NAME,
--			DATA.SERVICE_CODE,
--			DATA.PARTNER_CODE,
--			IFNULL(B.REVENUE_CATEGORY,CASE WHEN PCS.SOURCE_SYSTEM_ID =4 AND PCS.SYSTEM_CODE ='CC_8485' THEN 'CC' 
--										   WHEN PCS.SOURCE_SYSTEM_ID =4 AND PCS.SYSTEM_CODE ='8485' THEN 'HC' END)
			B.REVENUE_CATEGORY AS REV_CATEGORY,
			DATA.CLIENT_KEY,
--			DATA.HOURS_BILLED AS HOURS_BILLED_ALL,
			nvl(mc.mer_billhours,DATA.HOURS_BILLED) AS HOURS_BILLED_ALL,			
			IFF(DATA.TYPE='Hourly' , nvl(mc.merhrs, DATA.HOURS_SERVED),0) AS HOURS_SERVED_ALL,																									
--			IFF(DATA.TYPE='Hourly', DATA.HOURS_SERVED,0) AS HOURS_SERVED_ALL,
			IFF(DATA.TYPE='Hourly', DATA.HOURS_AUTHORIZED_NON_ADJUSTED,0) AS HOURS_AUTHORIZED_ALL,
			DATA.OVER_AUTHED_HOURS AS OVER_AUTHED_HOURS,
			IFF(DATA.TYPE='Hourly' ,COALESCE(DATA.HOURS_AUTHORIZED_NON_ADJUSTED,0),0) AS HOURS_AUTHORIZED_NON_ADJUSTED_ALL,
			COALESCE(DATA.HOURS_SERVED,0) AS HOURS_SERVED,
			--CASE WHEN CONTRACT.INCLUDE_FOR_OPS_PERF_HOURS=1 THEN DATA.CLIENT_KEY ELSE NULL END AS CLIENT_KEY,
--			NVL(CASE WHEN DATA.TYPE='Hourly' AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_SERVED END, 0) HOURS_SERVED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN DATA.TYPE='Hourly' AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN nvl(mc.merhrs, DATA.HOURS_SERVED) END, 0) HOURS_SERVED_WHERE_AUTH_EXISTS,			
--			NVL(CASE WHEN DATA.TYPE='Hourly' AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_BILLED END, 0) HOURS_BILLED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN DATA.TYPE='Hourly' AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN nvl(mc.mer_billhours,DATA.HOURS_BILLED) END, 0) HOURS_BILLED_WHERE_AUTH_EXISTS,			
			NVL(CASE WHEN DATA.TYPE='Hourly' AND NOT (NVL(DATA.HOURS_AUTHORIZED, 0) = 0 OR DATA.HOURS_AUTHORIZED > 900) THEN DATA.HOURS_AUTHORIZED END, 0) HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,
			NVL(CASE WHEN DATA.TYPE='Hourly' AND NOT (NVL(DATA.HOURS_AUTHORIZED_NON_ADJUSTED, 0) = 0 OR DATA.HOURS_AUTHORIZED_NON_ADJUSTED > 900) THEN DATA.HOURS_AUTHORIZED_NON_ADJUSTED END, 0) HOURS_AUTHORIZED_NON_ADJUSTED_WHERE_AUTH_EXISTS,
			DATA.ETL_LAST_UPDATED_DATE,
--			DATA.VISITS_ALL,
			nvl(mc.mervisits,DATA.VISITS_ALL) as VISITS_ALL,
--			DATA.VISITS_CLEAN_SHIFTS,
			nvl(mc.mer_cleanshiftflg,DATA.VISITS_CLEAN_SHIFTS) as VISITS_CLEAN_SHIFTS,
--			DATA.VISITS_NEED_MAINTENANCE,
			nvl(mc.mer_visitneedmaintainance,DATA.VISITS_NEED_MAINTENANCE) as VISITS_NEED_MAINTENANCE,
			IFF(COALESCE(CCSI_BRANCH.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY,MATRIXCARE_CLIENT.CLIENT_KEY ,ALAYACARE_CLIENT.CLIENT_KEY,PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY, PREFERRED_CLIENT.CLIENT_KEY,EDISON_CLIENT.CLIENT_KEY,MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY,LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY,ASR_CLIENT.CLIENT_KEY,CLEARCARE_CLIENT.CLIENT_KEY,DEVERO_CLIENT.CLIENT_KEY,ALLIANCE_CLIENT.CLIENT_KEY,OPENSYSTEMS_CLIENT.CLIENT_KEY,AXXESS_CLIENT.CLIENT_KEY, ALL_GEN_CLIENT.CLIENT_KEY) IS NULL, FALSE, TRUE) AS CLIENT_ACQUIRED_FLAG,
       CASE WHEN COALESCE(CCSI_BRANCH.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY) IS NOT NULL THEN 'CCSI' 
            WHEN MATRIXCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ADAPTIVE' 
            WHEN ALAYACARE_CLIENT.CLIENT_KEY IS NOT NULL THEN UPPER(ALAYACARE_CLIENT.AQUISITION_NAME)
			WHEN PREFERRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'PREFERRED'
            WHEN PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'PRAETORIAN' 
            WHEN EDISON_CLIENT.CLIENT_KEY IS NOT NULL THEN 'EDISON'
            WHEN MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'MERIDIUS'
            WHEN LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'LONGEVITY'
		    WHEN ASR_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ASR'
			WHEN CLEARCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'CLEARCARE'
			WHEN DEVERO_CLIENT.CLIENT_KEY IS NOT NULL THEN 'DEVERO'
			WHEN ALLIANCE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ALLIANCE'
			WHEN OPENSYSTEMS_CLIENT.CLIENT_KEY IS NOT NULL THEN 'OPENSYSTEMS'
			WHEN AXXESS_CLIENT.CLIENT_KEY IS NOT NULL THEN 'AXXESS'
			WHEN ALL_GEN_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ALL GENERATIONS'
            ELSE NULL END AS CLIENT_ACQUISITION_NAME,
      		DATA.NPS,
		    DATA.HOURS_SCHEDULED,
			DATA.HOURS_CANCELLED, 
			DATA.HOURS_IN_REVIEW,
			DATA.HOURS_MISSED, 
			DATA.HOURS_RESCHEDULED,
			DATA.FUTURE_HOURS,
			DATA.FUTURE_HOURS_NO_CAREGIVER,
			DATA.FUTURE_CANCELLED_HOURS, 
			DATA.FUTURE_HOLD_HOURS,
			DATA.VISITS_SCHEDULED, 
			DATA.VISITS_COMPLETED,
			DATA.VISITS_CANCELLED,
			DATA.VISITS_IN_REVIEW,
			DATA.VISITS_MISSED,
			DATA.VISITS_RESCHEDULED,
			DATA.FUTURE_VISITS,
			DATA.FUTURE_CANCELLED_VISITS,
			DATA.FUTURE_HOLD_VISITS,
			DATA.CLIENT_SERVED_FLAG
		FROM REPORT.UTILIZATION_2_0 AS DATA
		LEFT JOIN HAH.FACT_PARTNER_CONTRACT_SERVICE PCS ON PCS.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY
		left join DW_${var.SF_ENVIRONMENT}.REPORT.MS_OSHAH_CONTRACT_MAP mc on mc.client_key =data.client_key and data.partner_contract_service_key = mc.hha_con and data.period_begin_date='2023-08-01'
		LEFT JOIN HAH.DIM_SERVICES  B ON B.SERVICE_KEY = PCS.SERVICE_KEY 
		JOIN DATES DATES 
			ON DATES.FIRST_DAY_OF_MONTH = DATA.PERIOD_BEGIN_DATE 
--LEFT OUTER JOIN (SELECT DISTINCT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 8) CCSI_BRANCH
--                        ON CCSI_BRANCH.BRANCH_KEY = DATA.ORIGINAL_BRANCH_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 CCSI_BRANCH ON 
	      CCSI_BRANCH.CLIENT_KEY = DATA.CLIENT_KEY AND
	      CCSI_BRANCH.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      CCSI_BRANCH.BRANCH_KEY = DATA.BRANCH_KEY AND
	      CCSI_BRANCH.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      CCSI_BRANCH.AQUISITION_NAME ='CCSI' 
LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_2_0 WHERE AQUISITION_NAME = 'CCSI') CCSI_ACQUIRED_CLIENT
                        ON CCSI_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND PERIOD_BEGIN_DATE >= '2021-07-01'      
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Altamaha') ALTAMAHA_CLIENT
--                        ON ALTAMAHA_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY  
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 ALAYACARE_CLIENT ON 
	      ALAYACARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      ALAYACARE_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      ALAYACARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      ALAYACARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      ALAYACARE_CLIENT.SOURCE_SYSTEM_ID = 9  
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Praetorian') PRAETORIAN_ACQUIRED_CLIENT
--                        ON PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND DATA.PERIOD_BEGIN_DATE >= '2022-01-01'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 PRAETORIAN_ACQUIRED_CLIENT ON 
	      PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      PRAETORIAN_ACQUIRED_CLIENT.AQUISITION_NAME ='Praetorian' AND 
	      DATA.PERIOD_BEGIN_DATE >= '2022-01-01'	      
--LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE branch_name like 'A__%' and system_code = 'MATRIXCARE') MATRIXCARE_BRANCH
--      ON MATRIXCARE_BRANCH.BRANCH_KEY = DATA.ORIGINAL_BRANCH_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 MATRIXCARE_CLIENT
      ON MATRIXCARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      MATRIXCARE_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      MATRIXCARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      MATRIXCARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      MATRIXCARE_CLIENT.AQUISITION_NAME ='ADAPTIVE'
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Preferred') PREFERRED_CLIENT
--         ON PREFERRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 PREFERRED_CLIENT
      ON PREFERRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      PREFERRED_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      PREFERRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      PREFERRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      PREFERRED_CLIENT.AQUISITION_NAME ='PREFERRED'
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Edison') EDISON_CLIENT
--         ON EDISON_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 EDISON_CLIENT
      ON EDISON_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      EDISON_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      EDISON_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      EDISON_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      EDISON_CLIENT.AQUISITION_NAME ='EDISON'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 MERIDIUS_ACQUIRED_CLIENT ON 
	      MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      MERIDIUS_ACQUIRED_CLIENT.AQUISITION_NAME ='Meridius'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 LONGEVITY_ACQUIRED_CLIENT ON 
	      LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
	      LONGEVITY_ACQUIRED_CLIENT.AQUISITION_NAME ='Longevity'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 ASR_CLIENT
      ON ASR_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      ASR_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      ASR_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      ASR_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      ASR_CLIENT.AQUISITION_NAME ='ASR'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 CLEARCARE_CLIENT
      ON CLEARCARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      CLEARCARE_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      CLEARCARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      CLEARCARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      CLEARCARE_CLIENT.AQUISITION_NAME ='CLEARCARE'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 DEVERO_CLIENT
      ON DEVERO_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      DEVERO_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      DEVERO_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      DEVERO_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      DEVERO_CLIENT.AQUISITION_NAME ='DEVERO'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 ALLIANCE_CLIENT
      ON ALLIANCE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      ALLIANCE_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      ALLIANCE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      ALLIANCE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      ALLIANCE_CLIENT.AQUISITION_NAME ='ALLIANCE'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 OPENSYSTEMS_CLIENT
      ON OPENSYSTEMS_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      OPENSYSTEMS_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      OPENSYSTEMS_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      OPENSYSTEMS_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      OPENSYSTEMS_CLIENT.AQUISITION_NAME ='OPENSYSTEMS'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 AXXESS_CLIENT
      ON AXXESS_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      AXXESS_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      AXXESS_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      AXXESS_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      AXXESS_CLIENT.AQUISITION_NAME ='AXXESS'
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_2_0 ALL_GEN_CLIENT
      ON ALL_GEN_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
      ALL_GEN_CLIENT.PARTNER_CONTRACT_SERVICE_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
      ALL_GEN_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
      ALL_GEN_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',DATA.PERIOD_BEGIN_DATE) AND 
      ALL_GEN_CLIENT.AQUISITION_NAME ='All Generations'
WHERE PERIOD_BEGIN_DATE <= DATEADD( 'MONTH', 2, CURRENT_DATE)
AND IFF(DATA.CLIENT_SERVED_FLAG = TRUE,coalesce(mc.merhrs,DATA.HOURS_SERVED, 0), 1) > 0 
--AND TYPE='Hourly' 
AND REV_CATEGORY NOT IN ('CLS','NA','CC') AND PCS.BILLABLE_FLAG = TRUE
--AND DATA.SOURCE_SYSTEM_ID IN (17,7,4)-- AND DATA.STATE='DE'
	)
    ,
	FINAL_UTILIZATION_2 AS (
	SELECT DISTINCT PERIOD_BEGIN_DATE, PERIOD_NAME,--	TYPE,
	STATE, BRANCH_KEY, OFFICE_NUMBER, OFFICE_NAME, SUPERVISOR_KEY, SUPERVISOR_CODE, 
ABSOLUTE_FIRST_SERVICE_DATE, ABSOLUTE_LAST_SERVICE_DATE,	
NULL AS CLIENT_KEY_DATA, CLIENT_NUMBER,	ORIGINAL_SOURCE_SYSTEM_ID, SOURCE_SYSTEM_ID--,SYSTEM_CODE
, CONTRACT_KEY, PARTNER_CONTRACT_SERVICE_KEY, CONTRACT_CODE, 
--SERVICE_CODE, PARTNER_CODE, 
CLIENT_KEY, 
HOURS_SCHEDULED, HOURS_CANCELLED, HOURS_IN_REVIEW, HOURS_MISSED, HOURS_RESCHEDULED,	FUTURE_HOURS,FUTURE_HOURS_NO_CAREGIVER, FUTURE_CANCELLED_HOURS, FUTURE_HOLD_HOURS,
HOURS_SERVED_WHERE_AUTH_EXISTS,	HOURS_BILLED_WHERE_AUTH_EXISTS,	HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,	HOURS_AUTHORIZED_NON_ADJUSTED_WHERE_AUTH_EXISTS,
HOURS_SERVED_ALL, HOURS_BILLED_ALL,	HOURS_AUTHORIZED_ALL,	HOURS_AUTHORIZED_NON_ADJUSTED_ALL,
NULL AS INCLUDE_FOR_CLIENTS,NULL AS INCLUDE_FOR_HOURS, REV_CATEGORY,	
VISITS_ALL,	VISITS_CLEAN_SHIFTS,	VISITS_NEED_MAINTENANCE,	
VISITS_SCHEDULED,	VISITS_COMPLETED,	VISITS_CANCELLED,	VISITS_IN_REVIEW,	VISITS_MISSED,	VISITS_RESCHEDULED,	FUTURE_VISITS,	FUTURE_CANCELLED_VISITS,	FUTURE_HOLD_VISITS,	
CLIENT_ACQUIRED_FLAG,	CLIENT_ACQUISITION_NAME, CLIENT_SERVED_FLAG, NPS, ETL_LAST_UPDATED_DATE
	FROM UTILIZATION_DATA_2
	)
,FINAL_UTILIZATION AS (
SELECT * FROM FINAL_UTILIZATION_1
UNION
SELECT * FROM FINAL_UTILIZATION_2
)
, ABSOLUTE_SERVICE_DATES AS (				-- Different date would come IF 2 systems OF same state ARE IN separate Utilization structures (1_0 & 2_0)
SELECT CLIENT_KEY AS CLIENTKEY, 			-- so calculating dates AFTER the UNION OF BOTH utilizations
MIN(Absolute_First_Service_Date) AS Absolute_First_Service_Date,
MAX(Absolute_Last_Service_Date) AS Absolute_Last_Service_Date 
FROM FINAL_UTILIZATION
GROUP BY 1
)
SELECT PERIOD_BEGIN_DATE, 	PERIOD_NAME,	STATE,	BRANCH_KEY,	OFFICE_NUMBER,	OFFICE_NAME,	SUPERVISOR_KEY,	SUPERVISOR_CODE
,	SERVICEDATES.ABSOLUTE_FIRST_SERVICE_DATE
,	SERVICEDATES.ABSOLUTE_LAST_SERVICE_DATE
	,	CLIENT_KEY_DATA,	CLIENT_NUMBER,	ORIGINAL_SOURCE_SYSTEM_ID,	SOURCE_SYSTEM_ID,	CONTRACT_KEY,	PARTNER_CONTRACT_SERVICE_KEY,
	CONTRACT_CODE,	CLIENT_KEY,	HOURS_SCHEDULED,	HOURS_CANCELLED,	HOURS_IN_REVIEW,	HOURS_MISSED,	HOURS_RESCHEDULED,	FUTURE_HOURS,	FUTURE_HOURS_NO_CAREGIVER,
	FUTURE_CANCELLED_HOURS,	FUTURE_HOLD_HOURS,	HOURS_SERVED_WHERE_AUTH_EXISTS,	HOURS_BILLED_WHERE_AUTH_EXISTS,	HOURS_AUTHORIZED_WHERE_AUTH_EXISTS,
	HOURS_AUTHORIZED_NON_ADJUSTED_WHERE_AUTH_EXISTS,	HOURS_SERVED_ALL,	HOURS_BILLED_ALL,	HOURS_AUTHORIZED_ALL,	HOURS_AUTHORIZED_NON_ADJUSTED_ALL,
	INCLUDE_FOR_CLIENTS,	INCLUDE_FOR_HOURS,	REVENUE_CATEGORY,	VISITS_ALL,	VISITS_CLEAN_SHIFTS,	VISITS_NEED_MAINTENANCE,	VISITS_SCHEDULED,
	VISITS_COMPLETED,	VISITS_CANCELLED,	VISITS_IN_REVIEW,	VISITS_MISSED,	VISITS_RESCHEDULED,	FUTURE_VISITS,	FUTURE_CANCELLED_VISITS,	FUTURE_HOLD_VISITS,
	CLIENT_ACQUIRED_FLAG,	CLIENT_ACQUISITION_NAME,	CLIENT_SERVED_FLAG,	NPS,	ETL_LAST_UPDATED_DATE
	FROM FINAL_UTILIZATION
	JOIN 
	ABSOLUTE_SERVICE_DATES SERVICEDATES 
	ON FINAL_UTILIZATION.CLIENT_KEY = SERVICEDATES.CLIENTKEY;
SQL
	or_replace = true 
	is_secure = false 
}

