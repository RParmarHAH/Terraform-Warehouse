create or replace view DW_PROD.REPORT.CLIENT_DERIVED_MONTHLY_VISIT_METRICS_SEC_WITH_MASTER_CLIENT_KEY(
	SERVICE_MONTH,
	ORIGINAL_CLIENT_KEY,
	CLIENT_KEY,
	SOURCE_SYSTEM_ID,
	ORIGINAL_SOURCE_SYSTEM_ID,
	BRANCH_KEY,
	OFFICE_NAME,
	OFFICE_STATE_CODE,
	REFERRAL_DATE,
	CLIENT_STATE_CODE,
	LIFETIME_FIRST_SERVICE_MONTH,
	LIFETIME_LAST_SERVICE_MONTH,
	LIFETIME_TENURE_IN_MONTHS,
	LIFETIME_NUMBER_MONTHS_WITH_SERVICE,
	LIFETIME_NUMBER_MONTHS_WO_SERVICE,
	LIFETIME_NUMBER_OF_GAPS_IN_SERVICE,
	LIFETIME_SMALLEST_GAP_IN_SERVICE,
	LIFETIME_LARGEST_GAP_IN_SERVICE,
	NEW_CLIENT_FLAG,
	FIRST_MONTH_INACTIVE_FLAG,
	ACTIVE_FLAG,
	REACTIVATED_FLAG,
	CLIENT_ACQUIRED_FLAG,
	CLIENT_ACQUISITION_NAME,
	NUMBER_OF_SERVICE_LINES_PROVIDED,
	HC_SERVICE_LINE_PROVIDED,
	HH_SERVICE_LINE_PROVIDED,
	CLS_SERVICE_LINE_PROVIDED,
	NA_SERVICE_LINE_PROVIDED,
	IS_SERVICE_LINE_PROVIDED,
	NS_SERVICE_LINE_PROVIDED,
	OTHER_SERVICE_LINE_PROVIDED,
	NUMBER_OF_VISITS,
	PREVIOUS_MONTH_NUMBER_OF_VISITS,
	PREVIOUS_2_MONTH_NUMBER_OF_VISITS,
	NEXT_MONTH_NUMBER_OF_VISITS,
	NEXT_2_MONTH_NUMBER_OF_VISITS,
	SUM_OF_HOURS_RECEIVED,
	PREVIOUS_MONTH_SUM_OF_HOURS_RECEIVED,
	PREVIOUS_2_MONTH_SUM_OF_HOURS_RECEIVED,
	NEXT_MONTH_SUM_OF_HOURS_RECEIVED,
	NEXT_2_MONTH_SUM_OF_HOURS_RECEIVED,
	NUMBER_OF_HC_VISIT_DAYS,
	NUMBER_OF_HC_VISITS,
	SUM_OF_HC_HOURS_SERVED,
	NUMBER_OF_HH_VISIT_DAYS,
	NUMBER_OF_HH_VISITS,
	SUM_OF_HH_HOURS_SERVED,
	NUMBER_OF_CLS_VISITS,
	SUM_OF_CLS_HOURS_SERVED,
	NUMBER_OF_NA_VISITS,
	SUM_OF_NA_HOURS_SERVED,
	NUMBER_OF_IS_VISITS,
	SUM_OF_IS_HOURS_SERVED,
	NUMBER_OF_NS_VISITS,
	SUM_OF_NS_HOURS_SERVED,
	NUMBER_OF_OTHER_VISIT_DAYS,
	NUMBER_OF_OTHER_VISITS,
	SUM_OF_OTHER_HOURS_SERVED
) as
SELECT
    SERVICE_MONTH
	  ,ORIGINAL_CLIENT_KEY
	  ,CLIENT_KEY
	  ,SOURCE_SYSTEM_ID
	  ,ORIGINAL_SOURCE_SYSTEM_ID
	  ,BRANCH_KEY
	  ,OFFICE_NAME
	  ,OFFICE_STATE_CODE
	  ,REFERRAL_DATE
	  ,CLIENT_STATE_CODE
	  , LIFETIME_FIRST_SERVICE_MONTH
	  , LIFETIME_LAST_SERVICE_MONTH
	  , LIFETIME_TENURE_IN_MONTHS
	  , LIFETIME_NUMBER_MONTHS_WITH_SERVICE
	  , LIFETIME_NUMBER_MONTHS_WO_SERVICE
	  , LIFETIME_NUMBER_OF_GAPS_IN_SERVICE
	  , LIFETIME_SMALLEST_GAP_IN_SERVICE
	  , LIFETIME_LARGEST_GAP_IN_SERVICE
	  , NEW_CLIENT_FLAG, FIRST_MONTH_INACTIVE_FLAG
	  , ACTIVE_FLAG, REACTIVATED_FLAG
     ,CASE WHEN ACTIVE_FLAG = FALSE THEN LAG(ACQUiRED_FLAG) ignore nulls OVER (PARTITION BY CLIENT_KEY ORDER BY SERVICE_MONTH ASC) ELSE
      ACQUiRED_FLAG END AS CLIENT_ACQUiRED_FLAG,
      ACQUISITION_NAME AS CLIENT_ACQUISITION_NAME
	  , NUMBER_OF_SERVICE_LINES_PROVIDED
	  , HC_SERVICE_LINE_PROVIDED
	  , HH_SERVICE_LINE_PROVIDED
	  , CLS_SERVICE_LINE_PROVIDED
	  , NA_SERVICE_LINE_PROVIDED
	  , IS_SERVICE_LINE_PROVIDED
	  , NS_SERVICE_LINE_PROVIDED
	  , OTHER_SERVICE_LINE_PROVIDED
	  , NUMBER_OF_VISITS, PREVIOUS_MONTH_NUMBER_OF_VISITS
	  , PREVIOUS_2_MONTH_NUMBER_OF_VISITS
	  , NEXT_MONTH_NUMBER_OF_VISITS
	  , NEXT_2_MONTH_NUMBER_OF_VISITS
	  , SUM_OF_HOURS_RECEIVED
	  , PREVIOUS_MONTH_SUM_OF_HOURS_RECEIVED
	  , PREVIOUS_2_MONTH_SUM_OF_HOURS_RECEIVED
	  , NEXT_MONTH_SUM_OF_HOURS_RECEIVED, NEXT_2_MONTH_SUM_OF_HOURS_RECEIVED, NUMBER_OF_HC_VISIT_DAYS, NUMBER_OF_HC_VISITS, SUM_OF_HC_HOURS_SERVED, NUMBER_OF_HH_VISIT_DAYS, NUMBER_OF_HH_VISITS, SUM_OF_HH_HOURS_SERVED, NUMBER_OF_CLS_VISITS, SUM_OF_CLS_HOURS_SERVED, NUMBER_OF_NA_VISITS, SUM_OF_NA_HOURS_SERVED, NUMBER_OF_IS_VISITS, SUM_OF_IS_HOURS_SERVED, NUMBER_OF_NS_VISITS, SUM_OF_NS_HOURS_SERVED
	  , NUMBER_OF_OTHER_VISIT_DAYS, NUMBER_OF_OTHER_VISITS, SUM_OF_OTHER_HOURS_SERVED
FROM
(
SELECT 
	  CDM.SERVICE_MONTH
	  ,CDM.CLIENT_KEY AS ORIGINAL_CLIENT_KEY
	  ,CDM.CLIENT_KEY CLIENT_KEY
	  ,CDM.SOURCE_SYSTEM_ID AS SOURCE_SYSTEM_ID
	  ,ORIGINAL_SOURCE_SYSTEM_ID  AS ORIGINAL_SOURCE_SYSTEM_ID
	  ,CDM.BRANCH_KEY
	  ,OFFICE_NAME
	  ,OFFICE_STATE_CODE
	  ,REFERRAL_DATE
	  ,CLIENT_STATE_CODE
	  , LIFETIME_FIRST_SERVICE_MONTH
	  , LIFETIME_LAST_SERVICE_MONTH
	  , LIFETIME_TENURE_IN_MONTHS
	  , LIFETIME_NUMBER_MONTHS_WITH_SERVICE
	  , LIFETIME_NUMBER_MONTHS_WO_SERVICE
	  , LIFETIME_NUMBER_OF_GAPS_IN_SERVICE
	  , LIFETIME_SMALLEST_GAP_IN_SERVICE
	  , LIFETIME_LARGEST_GAP_IN_SERVICE
	  , NEW_CLIENT_FLAG, FIRST_MONTH_INACTIVE_FLAG
	  , ACTIVE_FLAG, REACTIVATED_FLAG,
  CCSI_CLIENT.CLIENT_KEY as ccsi_key
      ,CASE WHEN ACTIVE_FLAG =FALSE THEN NULL ELSE 
        IFF(COALESCE(CCSI_CLIENT.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY,MATRIXCARE_CLIENT.CLIENT_KEY,PRAETORIAN_CLIENT.CLIENT_KEY,PREFERRED_CLIENT.CLIENT_KEY,EDISON_CLIENT.CLIENT_KEY,LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY,MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY,ALAYACARE_CLIENT.CLIENT_KEY,ASR_CLIENT.CLIENT_KEY,CLEARCARE_CLIENT.CLIENT_KEY,BERKSHIRE_CLIENT.CLIENT_KEY,OPENSYSTEMS_CLIENT.CLIENT_KEY,AXXESS_CLIENT.CLIENT_KEY,ALLIANCE_CLIENT.CLIENT_KEY,MYCARE_CLIENT.CLIENT_KEY, ALL_GEN_CLIENT.CLIENT_KEY, RECCO_CLIENT.CLIENT_KEY) IS NULL, FALSE, TRUE)
        END AS ACQUIRED_FLAG,
      CASE WHEN COALESCE(CCSI_CLIENT.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY) IS NOT NULL THEN 'CCSI' 
      WHEN MATRIXCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ADAPTIVE' 
      WHEN PRAETORIAN_CLIENT.CLIENT_KEY IS NOT NULL THEN 'PRAETORIAN' 
      WHEN PREFERRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'PREFERRED'
      WHEN EDISON_CLIENT.CLIENT_KEY IS NOT NULL THEN 'EDISON'
      WHEN MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'MERIDIUS'
      WHEN LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN 'LONGEVITY'
      WHEN ALAYACARE_CLIENT.CLIENT_KEY IS NOT NULL THEN UPPER(ALAYACARE_CLIENT.AQUISITION_NAME)
      WHEN ASR_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ASR'
      WHEN CLEARCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'CLEARCARE'
      WHEN BERKSHIRE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'BERKSHIRE'
	  WHEN OPENSYSTEMS_CLIENT.CLIENT_KEY IS NOT NULL THEN 'OPENSYSTEMS'
	  WHEN AXXESS_CLIENT.CLIENT_KEY IS NOT NULL THEN 'AXXESS'
	  WHEN ALLIANCE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ALLIANCE'
	  WHEN MYCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN 'MYCARE'
	  WHEN ALL_GEN_CLIENT.CLIENT_KEY IS NOT NULL THEN 'ALL GENERATIONS'
	  WHEN RECCO_CLIENT.CLIENT_KEY IS NOT NULL THEN 'RECCO'
	ELSE NULL END AS ACQUISITION_NAME
	  , NUMBER_OF_SERVICE_LINES_PROVIDED
	  , HC_SERVICE_LINE_PROVIDED
	  , HH_SERVICE_LINE_PROVIDED
	  , CLS_SERVICE_LINE_PROVIDED
	  , NA_SERVICE_LINE_PROVIDED
	  , IS_SERVICE_LINE_PROVIDED
	  , NS_SERVICE_LINE_PROVIDED
	  , OTHER_SERVICE_LINE_PROVIDED
	  , NUMBER_OF_VISITS, PREVIOUS_MONTH_NUMBER_OF_VISITS
	  , PREVIOUS_2_MONTH_NUMBER_OF_VISITS
	  , NEXT_MONTH_NUMBER_OF_VISITS
	  , NEXT_2_MONTH_NUMBER_OF_VISITS
	  , SUM_OF_HOURS_RECEIVED
	  , PREVIOUS_MONTH_SUM_OF_HOURS_RECEIVED
	  , PREVIOUS_2_MONTH_SUM_OF_HOURS_RECEIVED
	  , NEXT_MONTH_SUM_OF_HOURS_RECEIVED, NEXT_2_MONTH_SUM_OF_HOURS_RECEIVED, NUMBER_OF_HC_VISIT_DAYS, NUMBER_OF_HC_VISITS, SUM_OF_HC_HOURS_SERVED, NUMBER_OF_HH_VISIT_DAYS, NUMBER_OF_HH_VISITS, SUM_OF_HH_HOURS_SERVED, NUMBER_OF_CLS_VISITS, SUM_OF_CLS_HOURS_SERVED, NUMBER_OF_NA_VISITS, SUM_OF_NA_HOURS_SERVED, NUMBER_OF_IS_VISITS, SUM_OF_IS_HOURS_SERVED, NUMBER_OF_NS_VISITS, SUM_OF_NS_HOURS_SERVED
	  , NUMBER_OF_OTHER_VISIT_DAYS, NUMBER_OF_OTHER_VISITS, SUM_OF_OTHER_HOURS_SERVED
FROM REPORT.CLIENT_DERIVED_MONTHLY_VISIT_METRICS_SEC CDM
--LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 8) CCSI_BRANCH
--ON CCSI_BRANCH.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) CCSI_CLIENT
ON CCSI_CLIENT.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
	AND CCSI_CLIENT.CLIENT_KEY = CDM.CLIENT_Key
	AND CCSI_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND CCSI_CLIENT.AQUISITION_NAME = 'CCSI'
LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED WHERE AQUISITION_NAME = 'CCSI') CCSI_ACQUIRED_CLIENT
ON CCSI_ACQUIRED_CLIENT.CLIENT_KEY = CDM.CLIENT_KEY AND CDM.SERVICE_MONTH >= '2021-07-01'
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Praetorian') PRAETORIAN_ACQUIRED_CLIENT
--ON PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY = CDM.CLIENT_KEY AND CDM.SERVICE_MONTH >= '2022-01-01'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) PRAETORIAN_CLIENT
ON PRAETORIAN_CLIENT.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
	AND PRAETORIAN_CLIENT.CLIENT_KEY = CDM.CLIENT_Key AND CDM.SERVICE_MONTH >= '2022-01-01'
	AND PRAETORIAN_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND PRAETORIAN_CLIENT.AQUISITION_NAME = 'Praetorian'
--LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 7 AND BRANCH_NAME LIKE 'A_%') MATRIXCARE_BRANCH
--ON MATRIXCARE_BRANCH.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) MATRIXCARE_CLIENT
ON MATRIXCARE_CLIENT.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
	AND MATRIXCARE_CLIENT.CLIENT_KEY = CDM.CLIENT_Key
	AND MATRIXCARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND MATRIXCARE_CLIENT.AQUISITION_NAME = 'ADAPTIVE'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) ALAYACARE_CLIENT
ON ALAYACARE_CLIENT.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
	AND ALAYACARE_CLIENT.CLIENT_KEY = CDM.CLIENT_Key
	AND ALAYACARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND ALAYACARE_CLIENT.SOURCE_SYSTEM_ID = 9
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) MERIDIUS_ACQUIRED_CLIENT
ON MERIDIUS_ACQUIRED_CLIENT.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
	AND MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY = CDM.CLIENT_Key
	AND MERIDIUS_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND MERIDIUS_ACQUIRED_CLIENT.AQUISITION_NAME = 'Meridius'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) LONGEVITY_ACQUIRED_CLIENT
ON LONGEVITY_ACQUIRED_CLIENT.BRANCH_KEY = CDM.ORIGINAL_BRANCH_KEY
	AND LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY = CDM.CLIENT_Key
	AND LONGEVITY_ACQUIRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND LONGEVITY_ACQUIRED_CLIENT.AQUISITION_NAME = 'Longevity'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) PREFERRED_CLIENT
ON PREFERRED_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (PREFERRED_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR PREFERRED_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND PREFERRED_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND PREFERRED_CLIENT.AQUISITION_NAME = 'PREFERRED'
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_MERGED WHERE NOTES = 'Edison') EDISON_CLIENT
--ON EDISON_CLIENT.CLIENT_KEY = CDM.CLIENT_KEY
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) EDISON_CLIENT
ON EDISON_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (EDISON_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR EDISON_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND EDISON_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND EDISON_CLIENT.AQUISITION_NAME = 'EDISON'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) ASR_CLIENT
ON ASR_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (ASR_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR ASR_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND ASR_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND ASR_CLIENT.AQUISITION_NAME = 'ASR'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) CLEARCARE_CLIENT
ON CLEARCARE_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (CLEARCARE_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR CLEARCARE_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND CLEARCARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND CLEARCARE_CLIENT.AQUISITION_NAME = 'CLEARCARE'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) BERKSHIRE_CLIENT
ON BERKSHIRE_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (BERKSHIRE_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR BERKSHIRE_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND BERKSHIRE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND BERKSHIRE_CLIENT.AQUISITION_NAME = 'BERKSHIRE'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) OPENSYSTEMS_CLIENT
ON OPENSYSTEMS_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (OPENSYSTEMS_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR OPENSYSTEMS_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND OPENSYSTEMS_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND OPENSYSTEMS_CLIENT.AQUISITION_NAME = 'OPENSYSTEMS'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) AXXESS_CLIENT
ON AXXESS_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (AXXESS_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR AXXESS_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND AXXESS_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND AXXESS_CLIENT.AQUISITION_NAME = 'AXXESS'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) ALLIANCE_CLIENT
ON ALLIANCE_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (ALLIANCE_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR ALLIANCE_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND ALLIANCE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND ALLIANCE_CLIENT.AQUISITION_NAME = 'ALLIANCE'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) MYCARE_CLIENT
ON MYCARE_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (MYCARE_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR MYCARE_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND MYCARE_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND MYCARE_CLIENT.AQUISITION_NAME = 'MYCARE'	
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) ALL_GEN_CLIENT
ON ALL_GEN_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (ALL_GEN_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR ALL_GEN_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND ALL_GEN_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND ALL_GEN_CLIENT.AQUISITION_NAME = 'All Generations'
LEFT OUTER JOIN (SELECT DISTINCT SERVICE_MONTH,CLIENT_KEY,original_CLIENT_KEY,
								SOURCE_SYSTEM_ID,BRANCH_KEY,
								AQUISITION_NAME FROM HAH.FACT_CLIENT_ACQUIRED) RECCO_CLIENT
ON RECCO_CLIENT.BRANCH_KEY = COALESCE(CDM.ORIGINAL_BRANCH_KEY,cdm.BRANCH_KEY)
	AND (RECCO_CLIENT.CLIENT_KEY  = CDM.CLIENT_Key OR RECCO_CLIENT.ORIGINAL_CLIENT_KEY= CDM.CLIENT_Key)
	AND RECCO_CLIENT.SERVICE_MONTH = DATE_TRUNC('MONTH',CDM.SERVICE_MONTH) 
	AND RECCO_CLIENT.AQUISITION_NAME = 'RECCO'
)MAIN;