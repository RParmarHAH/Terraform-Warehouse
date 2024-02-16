resource "snowflake_view" "DW_REPORT_VW_ROSTER_CARE_PROGRAM_MONTHLY_STATUS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_ROSTER_CARE_PROGRAM_MONTHLY_STATUS"
	statement = <<-SQL
	 ------------------------------------------------------------------------------------------------------------------------------
/*
Object Type : 	View
Object Name	: 	VW_PARTNER_ROSTER_MONTHLY_METRICS
Author		:	Mohit Vaghadiya
Description :
	- Provides Monthly Summary of Partner Roster
*/
--*****************************************************************************************************************************
-- CHANGE LOG :
-- Version	Date(MM/DD/YYYY)	Author				Change Description
-- --------	----------------   	------------------	---------------------------------------------------------------------------
-- 1.0		10/16/2023   		Mohit Vaghadiya		Initial development
-- 1.1		11/03/2023   		Ankit Shah			Added BRANCH_KEY,AUTH_HRS,HOURS_SERVED,FIRST_ON_MONTH
-- 1.2		11/06/2023   		Ankit Shah			Used View for LCM instead of table from report layer
-- 1.3		11/08/2023   		Ankit Shah			Added code to handle Disenrolled and Pending Disenrollment Status Dates
-- 1.4		12/06/2023   		Ankit Shah			Added code to derive IN_MONTHLY_ROSTER
-- 1.5		12/12/2023   		Ankit Shah			Added code to backfill program membership details uptill BACKFILL_DATE
-- 1.6		01/02/2024   		Ankit Shah			Added code to backfill on basis of hrs and inroster flag. Also included 'NY' program
-- 1.7		01/05/2024   		Ashish Sharma		Added code to add program status as 'PROGRAM NOT STARTED', Program code to derive from Partner
-- 1.8      01/09/2024			ASHISH SHARMA		Added code to check AUTH_HOURS for CENTENE backfill data
-- 1.9   	01/16/2024			ASHISH SHARMA		Updated the logic for FIRST_ON_MONTH, CARE_PROGRAM_STATUS_AT_START_OF_MONTH (PARTNER ROSTER), 
--													CARE_PROGRAM_AT_END_OF_MONTH (PARTNER ROSTER) and added the logic to not capture NON PARTNER ROSTER client with NULL status		
---------------------------------------------------------------------------------------------------------------------------------
WITH CLIENT_CARE_PROGRAM_STATUS_HISTORY AS
(
	SELECT DISTINCT ROSTER_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, CLIENT_KEY AS AMS_CLIENT_KEY
			, REPORT_DATE 
			, PROGRAM_CODE
			, STATUS_AT_START_OF_MONTH AS CARE_PROGRAM_STATUS_AT_START_OF_MONTH
			, STATUS_AT_END_OF_MONTH AS CARE_PROGRAM_STATUS_AT_END_OF_MONTH
			, STATUS_CHANGE_REASON 
			, FIRST_VALUE(PROGRAM_CODE) IGNORE NULLS OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE ORDER BY REPORT_DATE) AS FIRST_PROGRAM_CODE
			, FIRST_VALUE(STATUS_AT_START_OF_MONTH) IGNORE NULLS OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE ORDER BY REPORT_DATE) AS FIRST_STATUS_AT_START_OF_MONTH
			, FIRST_VALUE(STATUS_AT_END_OF_MONTH) IGNORE NULLS OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE ORDER BY REPORT_DATE) AS FIRST_STATUS_AT_END_OF_MONTH
			, FIRST_VALUE(STATUS_CHANGE_REASON) IGNORE NULLS OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE ORDER BY REPORT_DATE) AS FIRST_STATUS_CHANGE_REASON
			, LAST_VALUE(CARE_PROGRAM_STATUS_AT_END_OF_MONTH) OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE ORDER BY REPORT_DATE) AS LATEST_STATUS			  
			, LAST_VALUE(REPORT_DATE) OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE ORDER BY REPORT_DATE) AS LATEST_REPORT_DATE
			, LAST_VALUE(CASE WHEN CARE_PROGRAM_STATUS_AT_END_OF_MONTH = 'Pending Disenrollment' 
								THEN DATE_TRUNC('MONTH',CURRENT_DATE)::DATE END) IGNORE NULLS
			  OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE --= 'Pending Disenrollment'
			  		ORDER BY REPORT_DATE  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS PEN_REPORT_DATE
			, LAST_VALUE(CASE WHEN CARE_PROGRAM_STATUS_AT_END_OF_MONTH = 'Disenrolled' THEN REPORT_DATE END) IGNORE NULLS
			  OVER (PARTITION BY CLIENT_KEY,ROSTER_CLIENT_KEY,PROGRAM_CODE 
			  		ORDER BY REPORT_DATE  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS DIS_REPORT_DATE
			, TILL_DATE
	FROM DW_${var.SF_ENVIRONMENT}.REPORT.VW_CARE_PROGRAM_MEMBERSHIP_STATUS_HISTORY
)
,CLIENT_CARE_PROGRAM_DETAILS AS(
	SELECT PARTNER.PARTNER_CODE
			, CARE_PROGRAM.SL_EXTERNAL_ID__C  AS PROGRAM_CODE
			, CARE_PROGRAM.STARTDATE 
			, DATE_TRUNC('MONTH',CARE_PROGRAM.STARTDATE)::DATE AS REPORT_DATE
			, UPPER(PARTNER.PARTNER_NAME) AS PARTNER
			, CPC.ROSTER_NAME 
			, (PARTNER.PARTNER_CODE <>  'HAH') AS PARTNER_ROSTER_FLAG
	FROM DISC_${var.SF_ENVIRONMENT}.HEALTH_NAVIGATOR.CAREPROGRAM CARE_PROGRAM
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER_CONTRACT PARTNER_CONTRACT
		ON PARTNER_CONTRACT.CONTRACT_CODE = CARE_PROGRAM.SL_EXTERNAL_ID__C
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER PARTNER
		ON PARTNER.PARTNER_CODE = PARTNER_CONTRACT.PARTNER_CODE 
	INNER JOIN APP_DB_${var.SF_ENVIRONMENT}.CARE_COORDINATION.CARE_PROGRAM_CRITERIA CPC
		ON CARE_PROGRAM.SL_EXTERNAL_ID__C = CPC.PROGRAM_CODE 
		WHERE PARTNER.SYSTEM_CODE = 'GATOR'
	GROUP BY ALL
)
,CLIENT_DATA_DATES AS
(
	SELECT DISTINCT 
		CLIENT_KEY AS PARTNER_CLIENT_KEY
		,UPPER(ROSTER_CLIENT_HISTORY.SYSTEM_CODE) AS SYSTEM_CODE		
		,MIN(ROSTER_CLIENT_HISTORY.START_DATE) 
			OVER (	PARTITION BY CLIENT_KEY,UPPER(ROSTER_CLIENT_HISTORY.SYSTEM_CODE)) AS MIN_START
		,MAX(ROSTER_CLIENT_HISTORY.START_DATE)  
			OVER (	PARTITION BY CLIENT_KEY,UPPER(ROSTER_CLIENT_HISTORY.SYSTEM_CODE)) AS MAX_START
		,MAX(NVl(ROSTER_CLIENT_HISTORY.END_DATE,CURRENT_DATE))  
			OVER (	PARTITION BY CLIENT_KEY,UPPER(ROSTER_CLIENT_HISTORY.SYSTEM_CODE)) AS MAX_END
		,NVL(PROGRAM_STATUS_HISTORY.TILL_DATE,MAX_END) AS MAX_TILL_DATE
		,GREATEST(MAX_TILL_DATE,MAX_START,MAX_END) AS FINAL_MAX_END
	FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_CLIENT_STATUS_HISTORY ROSTER_CLIENT_HISTORY
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY AS PROGRAM_STATUS_HISTORY
		ON PROGRAM_STATUS_HISTORY.PARTNER_CLIENT_KEY = ROSTER_CLIENT_HISTORY.CLIENT_KEY
	WHERE UPPER(ROSTER_CLIENT_HISTORY.STATUS_SOURCE) = 'ROSTER'
)
,NON_PARTNER_CLIENT_DATA_DATES AS
(
	SELECT DISTINCT 
		ROSTER_CLIENT_HISTORY.PARTNER_CLIENT_KEY AS PARTNER_CLIENT_KEY
		,UPPER(ROSTER_CLIENT_HISTORY.ROSTER_NAME) AS SYSTEM_CODE		
		,MIN(ROSTER_CLIENT_HISTORY.MATCHED_DATE) 
			OVER (	PARTITION BY ROSTER_CLIENT_HISTORY.PARTNER_CLIENT_KEY,UPPER(ROSTER_CLIENT_HISTORY.ROSTER_NAME)) AS MIN_START
		,MAX(ROSTER_CLIENT_HISTORY.UNMATCHED_DATE)  
			OVER (	PARTITION BY ROSTER_CLIENT_HISTORY.PARTNER_CLIENT_KEY,UPPER(ROSTER_CLIENT_HISTORY.ROSTER_NAME)) AS MAX_START
		,MAX(NVl(ROSTER_CLIENT_HISTORY.UNMATCHED_DATE,CURRENT_DATE))  
			OVER (	PARTITION BY ROSTER_CLIENT_HISTORY.PARTNER_CLIENT_KEY,UPPER(ROSTER_CLIENT_HISTORY.ROSTER_NAME)) AS MAX_END
		,NVL(PROGRAM_STATUS_HISTORY.TILL_DATE,MAX_END) AS MAX_TILL_DATE
		,LAST_DAY(LEAST(MAX_TILL_DATE,NVL(MAX_START,CURRENT_DATE),MAX_END)) AS FINAL_MAX_END
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY  ROSTER_CLIENT_HISTORY
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY AS PROGRAM_STATUS_HISTORY
		ON PROGRAM_STATUS_HISTORY.PARTNER_CLIENT_KEY = ROSTER_CLIENT_HISTORY.PARTNER_CLIENT_KEY
	WHERE ROSTER_CLIENT_HISTORY.ROSTER_NAME NOT IN('MOLINA_ROSTER','CENTENE_ROSTER','AHC_ROSTER','PAHW_ROSTER')
)
,ROSTER_CLIENT_DATA AS
(
	SELECT	DISTINCT CDATA.PARTNER_CLIENT_KEY
			, UPPER(CDATA.SYSTEM_CODE) AS SYSTEM_CODE
			, DATES.FIRST_DAY_OF_MONTH AS REPORT_DATE
			, CDATA.MIN_START
			, CDATA.MAX_END			
	FROM CLIENT_DATA_DATES CDATA
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DATES
		ON DATES.CALENDAR_DATE 
			BETWEEN CDATA.MIN_START::DATE  
			AND CDATA.FINAL_MAX_END ::DATE 
)
,NON_PARTNER_ROSTER_CLIENT_DATA AS
(
	SELECT	DISTINCT CDATA.PARTNER_CLIENT_KEY
			, UPPER(CDATA.SYSTEM_CODE) AS SYSTEM_CODE
			, DATES.FIRST_DAY_OF_MONTH AS REPORT_DATE
			, CDATA.MIN_START
			, CDATA.MAX_END	
			, CDATA.FINAL_MAX_END
	FROM NON_PARTNER_CLIENT_DATA_DATES CDATA
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DATES
		ON DATES.CALENDAR_DATE 
			BETWEEN CDATA.MIN_START::DATE  
			AND CDATA.FINAL_MAX_END ::DATE 
)
,ROSTER_CLIENT_HISTORY_DETAILS AS
(
	SELECT DISTINCT ROSTER_DETAILS.PARTNER_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, UPPER(ROSTER_DETAILS.SYSTEM_CODE) AS PARTNER
			, ROSTER_DETAILS.REPORT_DATE
			, ROSTER_CLIENT_HISTORY.END_DATE
			, DATE_TRUNC(MONTH,ROSTER_CLIENT_HISTORY.START_DATE)::DATE AS DATE_OF_START
			, LAST_DAY(DATE_TRUNC(MONTH,ROSTER_CLIENT_HISTORY.END_DATE)::DATE) AS DATE_OF_END
			, NVL(DATEADD(DAY, -1, DATE_TRUNC(MONTH, ROSTER_CLIENT_HISTORY.END_DATE+1)), CURRENT_DATE)  
				AS USE_END_DATE
			, NVL((ROSTER_DETAILS.REPORT_DATE BETWEEN DATE_OF_START::DATE 
								AND NVL(USE_END_DATE, CURRENT_DATE) ),FALSE) AS IN_MONTHLY_ROSTER
			, ROSTER_DETAILS.MIN_START
			, ROSTER_DETAILS.MAX_END
	FROM ROSTER_CLIENT_DATA ROSTER_DETAILS  
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DATES
		ON DATES.FIRST_DAY_OF_MONTH  = ROSTER_DETAILS.REPORT_DATE
	LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.FACT_CLIENT_STATUS_HISTORY ROSTER_CLIENT_HISTORY
		ON ROSTER_DETAILS.PARTNER_CLIENT_KEY = ROSTER_CLIENT_HISTORY.CLIENT_KEY 
		AND (ROSTER_DETAILS.REPORT_DATE 
				BETWEEN DATE_OF_START AND USE_END_DATE)
)
,NON_PARTNER_ROSTER_CLIENT_HISTORY_DETAILS AS
(
	SELECT DISTINCT ROSTER_DETAILS.PARTNER_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, UPPER(ROSTER_DETAILS.SYSTEM_CODE) AS PARTNER
			, ROSTER_DETAILS.REPORT_DATE
			, ROSTER_CLIENT_HISTORY.MATCHED_DATE
			, ROSTER_CLIENT_HISTORY.UNMATCHED_DATE
			, DATE_TRUNC(MONTH,ROSTER_CLIENT_HISTORY.MATCHED_DATE)::DATE AS DATE_OF_START
			, LAST_DAY(DATE_TRUNC(MONTH,ROSTER_CLIENT_HISTORY.UNMATCHED_DATE)::DATE) AS DATE_OF_END
			, NVL(DATEADD(DAY, -1, DATE_TRUNC(MONTH, ROSTER_CLIENT_HISTORY.UNMATCHED_DATE+1)), CURRENT_DATE)  
				AS USE_END_DATE
			, NVL((ROSTER_DETAILS.REPORT_DATE BETWEEN DATE_OF_START::DATE 
								AND NVL(USE_END_DATE, CURRENT_DATE) ),FALSE) AS IN_MONTHLY_ROSTER
			, ROSTER_DETAILS.MIN_START
			, ROSTER_DETAILS.MAX_END
	FROM NON_PARTNER_ROSTER_CLIENT_DATA ROSTER_DETAILS  
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DATES
		ON DATES.FIRST_DAY_OF_MONTH  = ROSTER_DETAILS.REPORT_DATE
	LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY ROSTER_CLIENT_HISTORY
		ON ROSTER_DETAILS.PARTNER_CLIENT_KEY = ROSTER_CLIENT_HISTORY.PARTNER_CLIENT_KEY 
		AND (ROSTER_DETAILS.REPORT_DATE 
				BETWEEN DATE_OF_START AND USE_END_DATE)
)
,PARTNER_ROSTER_HISTORY AS
(
	SELECT DISTINCT RCDATES.PARTNER_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, RCDATES.PARTNER AS PARTNER
			, RCDATES.REPORT_DATE AS REPORT_DATE
			, RCDATES.IN_MONTHLY_ROSTER
			, PROGRAM_STATUS_HISTORY.TILL_DATE
			, PROGRAM_DETAILS.REPORT_DATE AS BACKFILL_DATE
	FROM ROSTER_CLIENT_HISTORY_DETAILS RCDATES
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY AS PROGRAM_STATUS_HISTORY
		ON RCDATES.PARTNER_CLIENT_KEY = PROGRAM_STATUS_HISTORY.PARTNER_CLIENT_KEY
		AND RCDATES.REPORT_DATE = PROGRAM_STATUS_HISTORY.REPORT_DATE
	LEFT JOIN CLIENT_CARE_PROGRAM_DETAILS PROGRAM_DETAILS
		ON PROGRAM_DETAILS.PARTNER = RCDATES.PARTNER
			AND (RCDATES.REPORT_DATE BETWEEN PROGRAM_DETAILS.REPORT_DATE 
					AND PROGRAM_STATUS_HISTORY.REPORT_DATE)
)
,NON_PARTNER_ROSTER_HISTORY AS
(
	SELECT DISTINCT RCDATES.PARTNER_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, RCDATES.PARTNER AS PARTNER
			, RCDATES.REPORT_DATE AS REPORT_DATE
			, RCDATES.IN_MONTHLY_ROSTER
			, PROGRAM_STATUS_HISTORY.TILL_DATE
			, PROGRAM_DETAILS.REPORT_DATE AS BACKFILL_DATE
			, RCDATES.MATCHED_DATE
			, RCDATES.UNMATCHED_DATE
	FROM NON_PARTNER_ROSTER_CLIENT_HISTORY_DETAILS RCDATES
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY AS PROGRAM_STATUS_HISTORY
		ON RCDATES.PARTNER_CLIENT_KEY = PROGRAM_STATUS_HISTORY.PARTNER_CLIENT_KEY
		AND RCDATES.REPORT_DATE = PROGRAM_STATUS_HISTORY.REPORT_DATE
	LEFT JOIN CLIENT_CARE_PROGRAM_DETAILS PROGRAM_DETAILS
		ON PROGRAM_DETAILS.PARTNER = RCDATES.PARTNER
			AND (RCDATES.REPORT_DATE BETWEEN PROGRAM_DETAILS.REPORT_DATE 
					AND PROGRAM_STATUS_HISTORY.REPORT_DATE)
)
, PARTNER_ROSTER_MATCHING_HISTORY AS
(
	SELECT ROSTER_MATCHING_HISTORY.PARTNER_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, ROSTER_MATCHING_HISTORY.AMS_CLIENT_KEY AS AMS_CLIENT_KEY
			, CURRENT_ROSTER_MATCHED_CLIENT.AMS_CLIENT_KEY AS CURRENT_AMS_CLIENT_KEY
			, UPPER(ROSTER_MATCHING_HISTORY.ROSTER_NAME) AS PARTNER
			, DATES.FIRST_DAY_OF_MONTH AS REPORT_DATE
			,CLIENT.PRIMARY_BRANCH_KEY  AS BRANCH_KEY
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY ROSTER_MATCHING_HISTORY
	INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED CLIENT
		ON CLIENT.ORIGINAL_CLIENT_KEY = ROSTER_MATCHING_HISTORY.AMS_CLIENT_KEY 
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SOURCE_SYSTEM SOURCE_SYSTEM
		ON SOURCE_SYSTEM.SOURCE_SYSTEM_ID = CLIENT.SOURCE_SYSTEM_ID 
			AND SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE  = 'AMS'
	INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY CURRENT_ROSTER_MATCHED_CLIENT
		INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED CURRENT_CLIENT
			ON CURRENT_CLIENT.ORIGINAL_CLIENT_KEY = CURRENT_ROSTER_MATCHED_CLIENT.AMS_CLIENT_KEY 
		INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SOURCE_SYSTEM CURRENT_SOURCE_SYSTEM
			ON CURRENT_SOURCE_SYSTEM.SOURCE_SYSTEM_ID = CURRENT_CLIENT.SOURCE_SYSTEM_ID
				AND CURRENT_SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE  = 'AMS'
		ON CURRENT_ROSTER_MATCHED_CLIENT.PARTNER_CLIENT_KEY = ROSTER_MATCHING_HISTORY.PARTNER_CLIENT_KEY 
			AND CURRENT_ROSTER_MATCHED_CLIENT.IS_LATEST 
			AND CURRENT_ROSTER_MATCHED_CLIENT.UNMATCHED_DATE IS NULL
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DATES
		ON DATES.CALENDAR_DATE 
			BETWEEN ROSTER_MATCHING_HISTORY.MATCHED_DATE::DATE AND NVL(ROSTER_MATCHING_HISTORY.UNMATCHED_DATE, CURRENT_DATE)::DATE
	WHERE UPPER(ROSTER_MATCHING_HISTORY.ROSTER_NAME) IN ('MOLINA', 'CENTENE', 'AMERIHEALTH')
	GROUP BY ALL
)
, NON_PARTNER_ROSTER_MATCHING_HISTORY AS
(
	SELECT ROSTER_MATCHING_HISTORY.PARTNER_CLIENT_KEY AS PARTNER_CLIENT_KEY
			, ROSTER_MATCHING_HISTORY.AMS_CLIENT_KEY AS AMS_CLIENT_KEY
			, CURRENT_ROSTER_MATCHED_CLIENT.AMS_CLIENT_KEY AS CURRENT_AMS_CLIENT_KEY
			, UPPER(ROSTER_MATCHING_HISTORY.ROSTER_NAME) AS PARTNER
			, DATES.FIRST_DAY_OF_MONTH AS REPORT_DATE
			,CLIENT.PRIMARY_BRANCH_KEY  AS BRANCH_KEY
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY ROSTER_MATCHING_HISTORY
	INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED CLIENT
		ON CLIENT.ORIGINAL_CLIENT_KEY = ROSTER_MATCHING_HISTORY.AMS_CLIENT_KEY 
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SOURCE_SYSTEM SOURCE_SYSTEM
		ON SOURCE_SYSTEM.SOURCE_SYSTEM_ID = CLIENT.SOURCE_SYSTEM_ID 
			AND SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE  = 'AMS'
	INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.ROSTER_AMS_MAPPING_HISTORY CURRENT_ROSTER_MATCHED_CLIENT
		INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED CURRENT_CLIENT
			ON CURRENT_CLIENT.ORIGINAL_CLIENT_KEY = CURRENT_ROSTER_MATCHED_CLIENT.AMS_CLIENT_KEY 
		INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SOURCE_SYSTEM CURRENT_SOURCE_SYSTEM
			ON CURRENT_SOURCE_SYSTEM.SOURCE_SYSTEM_ID = CURRENT_CLIENT.SOURCE_SYSTEM_ID
				AND CURRENT_SOURCE_SYSTEM.SOURCE_SYSTEM_TYPE  = 'AMS'
		ON CURRENT_ROSTER_MATCHED_CLIENT.PARTNER_CLIENT_KEY = ROSTER_MATCHING_HISTORY.PARTNER_CLIENT_KEY 
			AND CURRENT_ROSTER_MATCHED_CLIENT.IS_LATEST 
			AND CURRENT_ROSTER_MATCHED_CLIENT.UNMATCHED_DATE IS NULL
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DATES
		ON DATES.CALENDAR_DATE 
			BETWEEN ROSTER_MATCHING_HISTORY.MATCHED_DATE::DATE AND NVL(ROSTER_MATCHING_HISTORY.UNMATCHED_DATE, CURRENT_DATE)::DATE
	WHERE UPPER(ROSTER_MATCHING_HISTORY.ROSTER_NAME) NOT IN ('MOLINA', 'CENTENE', 'AMERIHEALTH')
	GROUP BY ALL
)
,BRANCH_DETAILS AS(
	SELECT LCM.AMS_CLIENT_KEY , DCM.ORIGINAL_CLIENT_KEY,LCM.PARTNER_CLIENT_KEY  , NVL(DCM.PRIMARY_BRANCH_KEY,CL.BRANCH_KEY ) AS BRANCH_KEY 
	FROM CLIENT_CARE_PROGRAM_STATUS_HISTORY LCM
	LEFT JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED DCM ON DCM.ORIGINAL_CLIENT_KEY = LCM.AMS_CLIENT_KEY
	LEFT JOIN APP_DB_${var.SF_ENVIRONMENT}.CARE_COORDINATION.CLIENT CL ON CL.CLIENT_KEY = LCM.AMS_CLIENT_KEY
)
,AUTH_HRS_DETAILS AS (
	SELECT CLIENT_KEY,PERIOD_BEGIN_DATE AS REPORT_DATE,
		SUM(HOURS_AUTHORIZED_NON_ADJUSTED_ALL) AS AUTH_HRS,--HOURS_AUTHORIZED_NON_ADJUSTED_ALL
		SUM(HOURS_SERVED_ALL)AS HOURS_SERVED
	FROM DW_${var.SF_ENVIRONMENT}.REPORT.VW_HOURS_AND_CLIENT_CENSUS_MONTHLY 
	GROUP BY 1,2
)
,PARTNER_STATUS AS ( 
SELECT DISTINCT  
			 PARTNER_ROSTER.REPORT_DATE
			, PARTNER_ROSTER.PARTNER_CLIENT_KEY
			, FIRST_VALUE( PARTNER_ROSTER.BACKFILL_DATE ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_BACKFILL_DATE
			, FIRST_VALUE( CARE_PROGRAM_HISTORY.FIRST_STATUS_AT_START_OF_MONTH ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS CPH_STATUS_AT_START_OF_MONTH
			, (CASE 	WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NULL 
							AND PARTNER_ROSTER.REPORT_DATE::DATE >= FIRST_BACKFILL_DATE::DATE
							AND MATCHED_ROSTER.AMS_CLIENT_KEY IS NOT NULL
						THEN (CASE 	WHEN 	PARTNER_ROSTER.PARTNER = 'CENTENE' 
											AND PARTNER_ROSTER.IN_MONTHLY_ROSTER 
											AND AUTH.HOURS_SERVED >= 10 
									THEN 'Enrolled'
									WHEN 	PARTNER_ROSTER.PARTNER = 'MOLINA' 
											AND PARTNER_ROSTER.IN_MONTHLY_ROSTER 
									THEN 'Enrolled'
									ELSE 'Disenrolled'
								END)
								--CPH_STATUS_AT_START_OF_MONTH 
					ELSE (CASE 	--WHEN MATCHED_ROSTER.AMS_CLIENT_KEY IS NULL
								--THEN NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_START_OF_MONTH,'AMS NOT MATCH')
								WHEN FIRST_BACKFILL_DATE IS NOT NULL
								THEN NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_START_OF_MONTH,'PROGRAM NOT STARTED')
								ELSE NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_START_OF_MONTH, 'PROGRAM CRITERIA NOT MET') END) 
				END) AS CARE_PROGRAM_STATUS_AT_START_OF_MONTH
		  	, (CASE 	WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NULL 
							AND PARTNER_ROSTER.REPORT_DATE::DATE >= FIRST_BACKFILL_DATE::DATE
							AND MATCHED_ROSTER.AMS_CLIENT_KEY IS NOT NULL
						THEN (CASE 	WHEN 	PARTNER_ROSTER.PARTNER = 'CENTENE' 
											AND PARTNER_ROSTER.IN_MONTHLY_ROSTER 											
											AND AUTH.HOURS_SERVED >= 10 
									THEN 'Enrolled'
									WHEN 	PARTNER_ROSTER.PARTNER = 'MOLINA' 
											AND PARTNER_ROSTER.IN_MONTHLY_ROSTER
									THEN 'Enrolled'
									ELSE 'Disenrolled'
								END)
						--CPH_STATUS_AT_START_OF_MONTH 
					ELSE (CASE 	--WHEN MATCHED_ROSTER.AMS_CLIENT_KEY IS NULL
								--THEN NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_END_OF_MONTH,'AMS NOT MATCH')
								WHEN FIRST_BACKFILL_DATE IS NOT NULL
								THEN NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_END_OF_MONTH,'PROGRAM NOT STARTED')
								ELSE NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_END_OF_MONTH,'PROGRAM CRITERIA NOT MET') END)
				END) AS CARE_PROGRAM_STATUS_AT_END_OF_MONTH				
	FROM PARTNER_ROSTER_HISTORY PARTNER_ROSTER
	INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED CLIENT
		ON CLIENT.CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
	LEFT JOIN PARTNER_ROSTER_MATCHING_HISTORY MATCHED_ROSTER
		ON MATCHED_ROSTER.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND MATCHED_ROSTER.PARTNER = PARTNER_ROSTER.PARTNER
			AND MATCHED_ROSTER.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY CARE_PROGRAM_HISTORY
		ON CARE_PROGRAM_HISTORY.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND CARE_PROGRAM_HISTORY.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN AUTH_HRS_DETAILS AUTH
		ON AUTH.CLIENT_KEY = MATCHED_ROSTER.AMS_CLIENT_KEY
		AND AUTH.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
)
,NON_PARTNER_STATUS AS ( 
SELECT DISTINCT  
			 PARTNER_ROSTER.REPORT_DATE
			, PARTNER_ROSTER.PARTNER_CLIENT_KEY
			, FIRST_VALUE( PARTNER_ROSTER.BACKFILL_DATE ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_BACKFILL_DATE
			, FIRST_VALUE( CARE_PROGRAM_HISTORY.FIRST_STATUS_AT_START_OF_MONTH ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS CPH_STATUS_AT_START_OF_MONTH
			, CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_START_OF_MONTH 
			, CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_END_OF_MONTH 
--			, (CASE 	WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NULL 
--							AND PARTNER_ROSTER.REPORT_DATE::DATE >= FIRST_BACKFILL_DATE::DATE
--						THEN (CASE 	WHEN PARTNER_ROSTER.IN_MONTHLY_ROSTER 
--											AND AUTH.HOURS_SERVED >= 10 
--									THEN 'Enrolled'
--									ELSE 'Disenrolled'
--								END)
--								--CPH_STATUS_AT_START_OF_MONTH 
--					ELSE (CASE WHEN FIRST_BACKFILL_DATE IS NOT NULL
--							THEN NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_START_OF_MONTH,'PROGRAM NOT STARTED')
--							ELSE CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_START_OF_MONTH END) 
--				END) AS CARE_PROGRAM_STATUS_AT_START_OF_MONTH
--		  	, (CASE 	WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NULL 
--							AND PARTNER_ROSTER.REPORT_DATE::DATE >= FIRST_BACKFILL_DATE::DATE
--						THEN (CASE 	WHEN PARTNER_ROSTER.IN_MONTHLY_ROSTER 
--											AND AUTH.HOURS_SERVED >= 10 
--									THEN 'Enrolled'
--									ELSE 'Disenrolled'
--								END)
--						--CPH_STATUS_AT_START_OF_MONTH 
--					ELSE (CASE WHEN FIRST_BACKFILL_DATE IS NOT NULL
--							THEN NVL(CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_END_OF_MONTH,'PROGRAM NOT STARTED')
--							ELSE CARE_PROGRAM_HISTORY.CARE_PROGRAM_STATUS_AT_END_OF_MONTH END)
--				END) AS CARE_PROGRAM_STATUS_AT_END_OF_MONTH	
	FROM NON_PARTNER_ROSTER_HISTORY PARTNER_ROSTER
	LEFT JOIN NON_PARTNER_ROSTER_MATCHING_HISTORY MATCHED_ROSTER
		ON MATCHED_ROSTER.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND MATCHED_ROSTER.PARTNER = PARTNER_ROSTER.PARTNER
			AND MATCHED_ROSTER.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY CARE_PROGRAM_HISTORY
		ON CARE_PROGRAM_HISTORY.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND CARE_PROGRAM_HISTORY.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN AUTH_HRS_DETAILS AUTH
		ON AUTH.CLIENT_KEY = MATCHED_ROSTER.AMS_CLIENT_KEY
		AND AUTH.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
)
,PARTNER_ROSTER_MONTHLY_DETAILS AS (
	SELECT DISTINCT CPC.PARTNER_CODE AS PARTNER 
			, PARTNER_ROSTER.REPORT_DATE
			, PARTNER_ROSTER.PARTNER_CLIENT_KEY
			, CLIENT.CLIENT_FIRST_NAME AS CLIENT_FIRST_NAME
			, CLIENT.CLIENT_LAST_NAME AS CLIENT_LAST_NAME
			, CLIENT.CLIENT_DOB 
			, PARTNER_ROSTER.IN_MONTHLY_ROSTER
			, (MATCHED_ROSTER.AMS_CLIENT_KEY IS NOT NULL) AS AMS_MATCHED
			, MATCHED_ROSTER.AMS_CLIENT_KEY
			, FIRST_VALUE( PARTNER_ROSTER.BACKFILL_DATE ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_BACKFILL_DATE
			, FIRST_VALUE( CARE_PROGRAM_HISTORY.PROGRAM_CODE ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS CPH_FIRST_PROGRAM_CODE
			, (CASE 	WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NULL 
							AND PARTNER_ROSTER.REPORT_DATE::DATE >= FIRST_BACKFILL_DATE::DATE
						THEN CPH_FIRST_PROGRAM_CODE 
					ELSE NVL(CARE_PROGRAM_HISTORY.PROGRAM_CODE,CPC.PROGRAM_CODE)
				END) AS PROGRAM_CODE
			, FIRST_VALUE( CASE WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NOT NULL 
								THEN PARTNER_ROSTER.REPORT_DATE END ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_ON_MONTH_OLD
			, PSTAT.CPH_STATUS_AT_START_OF_MONTH
			, (CASE WHEN FIRST_ON_MONTH_OLD::DATE <= '2023-07-01'::DATE
					THEN PSTAT.CARE_PROGRAM_STATUS_AT_START_OF_MONTH
					ELSE (CASE 	WHEN PARTNER_ROSTER.REPORT_DATE::DATE < FIRST_ON_MONTH_OLD 
								THEN 'PROGRAM CRITERIA NOT MET'
								ELSE PSTAT.CARE_PROGRAM_STATUS_AT_START_OF_MONTH
							END)
				END) AS DERIVED_CARE_PROGRAM_STATUS_AT_START_OF_MONTH
			, (CASE WHEN FIRST_ON_MONTH_OLD::DATE <= '2023-07-01'::DATE
					THEN PSTAT.CARE_PROGRAM_STATUS_AT_END_OF_MONTH
					ELSE (CASE 	WHEN PARTNER_ROSTER.REPORT_DATE::DATE < FIRST_ON_MONTH_OLD 
								THEN 'PROGRAM CRITERIA NOT MET'
								ELSE PSTAT.CARE_PROGRAM_STATUS_AT_END_OF_MONTH
							END)
				END) AS DERIVED_CARE_PROGRAM_STATUS_AT_END_OF_MONTH
			, CARE_PROGRAM_HISTORY.STATUS_CHANGE_REASON
			, NULL AS MEDICAID_NBR
			, NULL AS DUAL_IND
			, NULL AS WELLCARE_IND
			, NULL AS INPAT_COUNT
			, NULL AS ROLLING_6M_ER_VIS
			, NULL AS ROLLING_2MORE_ER
			, AUTH.AUTH_HRS AS AUTH_HRS
			, AUTH.HOURS_SERVED AS HOURS_SERVED
			, BD.BRANCH_KEY AS BRANCH_KEY
			, FIRST_VALUE( CASE WHEN (PSTAT.CARE_PROGRAM_STATUS_AT_START_OF_MONTH = 'Enrolled' OR PSTAT.CARE_PROGRAM_STATUS_AT_END_OF_MONTH = 'Enrolled')
								THEN PARTNER_ROSTER.REPORT_DATE END ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_ON_MONTH
	FROM PARTNER_ROSTER_HISTORY PARTNER_ROSTER
	INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED CLIENT
		ON CLIENT.CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
	LEFT JOIN PARTNER_ROSTER_MATCHING_HISTORY MATCHED_ROSTER
		ON MATCHED_ROSTER.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND MATCHED_ROSTER.PARTNER = PARTNER_ROSTER.PARTNER
			AND MATCHED_ROSTER.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY CARE_PROGRAM_HISTORY
		ON CARE_PROGRAM_HISTORY.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND CARE_PROGRAM_HISTORY.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN AUTH_HRS_DETAILS AUTH
		ON AUTH.CLIENT_KEY = MATCHED_ROSTER.AMS_CLIENT_KEY
		AND AUTH.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN BRANCH_DETAILS BD ON BD.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
	LEFT JOIN CLIENT_CARE_PROGRAM_DETAILS CPC ON PARTNER_ROSTER.PARTNER = CPC.ROSTER_NAME 
	INNER JOIN PARTNER_STATUS PSTAT 
		ON PSTAT.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
		AND PSTAT.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	WHERE PARTNER_ROSTER.PARTNER IN ('MOLINA', 'CENTENE', 'AMERIHEALTH') 
) 
,NON_PARTNER_ROSTER_MONTHLY_DETAILS AS (
	SELECT DISTINCT CPC.PARTNER_CODE AS PARTNER
			, PARTNER_ROSTER.REPORT_DATE
			, PARTNER_ROSTER.PARTNER_CLIENT_KEY
			, CLIENT.CLIENT_FIRST_NAME AS CLIENT_FIRST_NAME
			, CLIENT.CLIENT_LAST_NAME AS CLIENT_LAST_NAME
			, CLIENT.CLIENT_DOB 
			, PARTNER_ROSTER.IN_MONTHLY_ROSTER
			, (MATCHED_ROSTER.AMS_CLIENT_KEY IS NOT NULL) AS AMS_MATCHED
			, MATCHED_ROSTER.AMS_CLIENT_KEY
			, FIRST_VALUE( PARTNER_ROSTER.BACKFILL_DATE ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_BACKFILL_DATE
			, FIRST_VALUE( CARE_PROGRAM_HISTORY.PROGRAM_CODE ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS CPH_FIRST_PROGRAM_CODE
			, (CASE 	WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NULL 
							AND PARTNER_ROSTER.REPORT_DATE::DATE >= FIRST_BACKFILL_DATE::DATE
						THEN CPH_FIRST_PROGRAM_CODE 
					ELSE NVL(CARE_PROGRAM_HISTORY.PROGRAM_CODE,CPC.PROGRAM_CODE)
				END) AS PROGRAM_CODE
			, FIRST_VALUE( CASE WHEN CARE_PROGRAM_HISTORY.REPORT_DATE IS NOT NULL 
								THEN PARTNER_ROSTER.REPORT_DATE END ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_ON_MONTH_OLD
			, NPSTAT.CPH_STATUS_AT_START_OF_MONTH
--			, (CASE WHEN FIRST_ON_MONTH_OLD::DATE <= '2023-07-01'::DATE
--					THEN NPSTAT.CARE_PROGRAM_STATUS_AT_START_OF_MONTH
--					ELSE (CASE 	WHEN PARTNER_ROSTER.REPORT_DATE::DATE < FIRST_ON_MONTH_OLD 
--								THEN 'PROGRAM CRITERIA NOT MET'
--								ELSE NPSTAT.CARE_PROGRAM_STATUS_AT_START_OF_MONTH
--							END)
--				END) 
			, NPSTAT.CARE_PROGRAM_STATUS_AT_START_OF_MONTH AS DERIVED_CARE_PROGRAM_STATUS_AT_START_OF_MONTH
--			, (CASE WHEN FIRST_ON_MONTH_OLD::DATE <= '2023-07-01'::DATE
--					THEN NPSTAT.CARE_PROGRAM_STATUS_AT_END_OF_MONTH
--					ELSE (CASE 	WHEN PARTNER_ROSTER.REPORT_DATE::DATE < FIRST_ON_MONTH_OLD 
--								THEN 'PROGRAM CRITERIA NOT MET'
--								ELSE NPSTAT.CARE_PROGRAM_STATUS_AT_END_OF_MONTH
--							END)
--				END) 
			, NPSTAT.CARE_PROGRAM_STATUS_AT_END_OF_MONTH AS DERIVED_CARE_PROGRAM_STATUS_AT_END_OF_MONTH				
			, CARE_PROGRAM_HISTORY.STATUS_CHANGE_REASON
			, NULL AS MEDICAID_NBR
			, NULL AS DUAL_IND
			, NULL AS WELLCARE_IND
			, NULL AS INPAT_COUNT
			, NULL AS ROLLING_6M_ER_VIS
			, NULL AS ROLLING_2MORE_ER
			, AUTH.AUTH_HRS AS AUTH_HRS
			, AUTH.HOURS_SERVED AS HOURS_SERVED
			, BD.BRANCH_KEY AS BRANCH_KEY
			, FIRST_VALUE( CASE WHEN (NPSTAT.CARE_PROGRAM_STATUS_AT_START_OF_MONTH = 'Enrolled' OR NPSTAT.CARE_PROGRAM_STATUS_AT_END_OF_MONTH = 'Enrolled')
								THEN PARTNER_ROSTER.REPORT_DATE END ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_ROSTER.PARTNER_CLIENT_KEY ORDER BY PARTNER_ROSTER.REPORT_DATE  ) 
				AS FIRST_ON_MONTH
	FROM NON_PARTNER_ROSTER_HISTORY PARTNER_ROSTER
	INNER JOIN DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_CLIENT_MERGED CLIENT
		ON CLIENT.CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
	LEFT JOIN NON_PARTNER_ROSTER_MATCHING_HISTORY MATCHED_ROSTER
		ON MATCHED_ROSTER.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND MATCHED_ROSTER.PARTNER = PARTNER_ROSTER.PARTNER
			AND MATCHED_ROSTER.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN CLIENT_CARE_PROGRAM_STATUS_HISTORY CARE_PROGRAM_HISTORY
		ON CARE_PROGRAM_HISTORY.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
			AND CARE_PROGRAM_HISTORY.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN AUTH_HRS_DETAILS AUTH
		ON AUTH.CLIENT_KEY = MATCHED_ROSTER.AMS_CLIENT_KEY
		AND AUTH.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	LEFT JOIN BRANCH_DETAILS BD ON BD.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
	LEFT JOIN CLIENT_CARE_PROGRAM_DETAILS CPC ON PARTNER_ROSTER.PARTNER = CPC.ROSTER_NAME 
	INNER JOIN NON_PARTNER_STATUS NPSTAT 
		ON NPSTAT.PARTNER_CLIENT_KEY = PARTNER_ROSTER.PARTNER_CLIENT_KEY
		AND NPSTAT.REPORT_DATE = PARTNER_ROSTER.REPORT_DATE
	WHERE PARTNER_ROSTER.PARTNER NOT IN ('MOLINA', 'CENTENE', 'AMERIHEALTH')
)
,FINAL_COMBINE_RESULT AS(
	SELECT 	PARTNER
			, REPORT_DATE
			, PARTNER_CLIENT_KEY
			, CLIENT_FIRST_NAME
			, CLIENT_LAST_NAME
			, CLIENT_DOB
			, IN_MONTHLY_ROSTER
			, AMS_MATCHED
			, AMS_CLIENT_KEY
			, PROGRAM_CODE
			, DERIVED_CARE_PROGRAM_STATUS_AT_START_OF_MONTH AS CARE_PROGRAM_STATUS_AT_START_OF_MONTH
			, DERIVED_CARE_PROGRAM_STATUS_AT_END_OF_MONTH AS CARE_PROGRAM_STATUS_AT_END_OF_MONTH
			, STATUS_CHANGE_REASON
			, MEDICAID_NBR
			, DUAL_IND
			, WELLCARE_IND
			, INPAT_COUNT
			, ROLLING_6M_ER_VIS
			, ROLLING_2MORE_ER
			, AUTH_HRS
			, HOURS_SERVED
			, BRANCH_KEY
			, FIRST_VALUE( CASE WHEN (DERIVED_CARE_PROGRAM_STATUS_AT_START_OF_MONTH = 'Enrolled' OR DERIVED_CARE_PROGRAM_STATUS_AT_END_OF_MONTH = 'Enrolled')
								THEN REPORT_DATE END ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_CLIENT_KEY ORDER BY REPORT_DATE  ) 
			  AS FIRST_ON_MONTH
	FROM PARTNER_ROSTER_MONTHLY_DETAILS
	--ORDER BY PARTNER_CLIENT_KEY,REPORT_DATE--,PROGRAM_CODE,
	UNION ALL 
	SELECT 	REPLACE(PARTNER,'_ROSTER','') AS PARTNER
			, REPORT_DATE
			, PARTNER_CLIENT_KEY
			, CLIENT_FIRST_NAME
			, CLIENT_LAST_NAME
			, CLIENT_DOB
			, IN_MONTHLY_ROSTER
			, AMS_MATCHED
			, AMS_CLIENT_KEY
			, PROGRAM_CODE
			, DERIVED_CARE_PROGRAM_STATUS_AT_START_OF_MONTH AS CARE_PROGRAM_STATUS_AT_START_OF_MONTH
			, DERIVED_CARE_PROGRAM_STATUS_AT_END_OF_MONTH AS CARE_PROGRAM_STATUS_AT_END_OF_MONTH
			, STATUS_CHANGE_REASON
			, MEDICAID_NBR
			, DUAL_IND
			, WELLCARE_IND
			, INPAT_COUNT
			, ROLLING_6M_ER_VIS
			, ROLLING_2MORE_ER
			, AUTH_HRS
			, HOURS_SERVED
			, BRANCH_KEY
			, FIRST_VALUE( CASE WHEN (DERIVED_CARE_PROGRAM_STATUS_AT_START_OF_MONTH = 'Enrolled' OR DERIVED_CARE_PROGRAM_STATUS_AT_END_OF_MONTH = 'Enrolled')
								THEN REPORT_DATE END ) IGNORE NULLS
							OVER (PARTITION BY  PARTNER_CLIENT_KEY ORDER BY REPORT_DATE  ) 
			  AS FIRST_ON_MONTH
	FROM NON_PARTNER_ROSTER_MONTHLY_DETAILS 
	WHERE CARE_PROGRAM_STATUS_AT_START_OF_MONTH  IS NOT NULL OR CARE_PROGRAM_STATUS_AT_END_OF_MONTH IS NOT NULL
)
SELECT *
FROM FINAL_COMBINE_RESULT
ORDER BY PARTNER_CLIENT_KEY,PROGRAM_CODE,REPORT_DATE
--GROUP BY ALL;
;
SQL
	or_replace = true 
	is_secure = false 
}

