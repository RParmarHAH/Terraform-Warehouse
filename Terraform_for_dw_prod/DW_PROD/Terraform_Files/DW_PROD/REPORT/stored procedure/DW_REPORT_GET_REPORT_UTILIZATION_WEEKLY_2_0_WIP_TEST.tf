resource "snowflake_procedure" "DW_REPORT_GET_REPORT_UTILIZATION_WEEKLY_2_0_WIP_TEST" {
	name ="GET_REPORT_UTILIZATION_WEEKLY_2_0_WIP_TEST"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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
    return_result VARCHAR;
BEGIN
    -- *****************************************************************************************************************************
 -- NAME: UTILIZATION_WEEKLY_2_0_TEST

 -- 08/16/22			DEEPEN GAJJAR 		CONVERTED DAILY HOURS AND SENSUS STRUCTURE INTO WEEKLY ADDING VISITS_CLEAN_SHIFTS AND VISITS_NEED_MAINTENANCE FIELDS 
 -- 08/25/22			DEEPEN GAJJAR 		ADDED PROSPERCARE ACQUISITION FLAG
 -- 10/05/22			SAM HUFF     		ADDED CLEARCARE ACQUISITION FLAG
 -- 11/10/22			RAJAT SAPKAL		UPDATED CONTRACT LOGIC AND REPLACED STATUS CODE WITH CONFIRMED FLAG IN FACT VISIT FILTER LOGIC
 -- 12/01/22         	DEEPEN GAJJAR       MODIFIED ACQUISITION FLAG LOGIC 
 -- 12/20/22			RAJAT SAPKAL		REWORKED LOGIC TO INCLUDE NON-CONFIRMED VISITS AS WELL AND ADDED FIELDS FOR NEW SCHEDULED METRICS
 -- 02/10/22            DEEPEN GAJJAR       ADDED ACQUISITION FLAGS FROM OPENSYSTEMS AND OSHAH
 -- 02/28/22            DEEPEN GAJJAR       MODIFIED ACQUISITION FLAGS FROM OPENSYSTEMS AND OSHAH
 -- 03/17/23            DEEPEN GAJJAR       ADDED ACQUISITION FLAGS for AXXESS AND ALLAINCE
--  04/28/23            Deepen Gajjar       Added Acquisition flag for All generations
--  06/07/23            Nutan Jagnade       Added weekly authorization cte And included 4,17,7 source system in visit based cte
--  06/15/23            Sagar Gulghane      Added Type,Startdate,Enddate,NUMBER_OF_DAYS
--  08/31/23            Divesh Aneja        Added mycare code
--  09/05/23            Sagar Gulghane      Remove Hourly filter
--  09/29/23			Jashvant Patel 		Added acquisition code for BERKSHIRE
--  10/03/23			Shikhar Saxena 		Added Acquisition code for ROMEO
--  10/10/23			Sanket Jain 		Modified authorization to take data from CLIENT_SERVICE_WEEKLY_AUTHORIZATION
--  10/11/23			Shikhar Saxena		Updated Romeo acquisition code logic
--*****************************************************************************************************************************
--NOTE:			If Manual Refresh is required then SCHEDULE_METRICS_WEEKLY should be refreshed first before running this object
-- *****************************************************************************************************************************

INSERT OVERWRITE INTO REPORT.UTILIZATION_WEEKLY_2_0_WIP_TEST
WITH NOD AS(
	SELECT count(DISTINCT SERVICE_DATE) NO_OF_DAYS ,DD.HAH_CURRENT_WEEK_FIRST_DAY,CLIENT_KEY ,PARTNER_CONTRACT_SERVICE_KEY,SOURCE_SYSTEM_ID,ORIGINAL_SOURCE_SYSTEM_ID  
	FROM INTEGRATION.FACT_VISIT_MERGED visit
	JOIN hah.DIM_DATE dd ON DD.CALENDAR_DATE = VISIT.SERVICE_DATE 
	WHERE VISIT.ORIGINAL_SOURCE_SYSTEM_ID IN (4,7,17,13,9,3) --AND NVL(VISIT.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''
	GROUP BY DD.HAH_CURRENT_WEEK_FIRST_DAY,CLIENT_KEY ,PARTNER_CONTRACT_SERVICE_KEY,SOURCE_SYSTEM_ID,ORIGINAL_SOURCE_SYSTEM_ID)
	--SELECT count(*) FROM nod 
, VISIT_DATA AS
    (
        SELECT DISTINCT
        DD.HAH_CURRENT_WEEK_FIRST_DAY AS SERVICE_WEEK,
        VISIT.CLIENT_KEY,
        VISIT.CLIENT_NUMBER,
        NOD.NO_OF_DAYS,
        VISIT.PARTNER_CONTRACT_SERVICE_KEY ,
        --VISIT.ORIGINAL_SOURCE_SYSTEM_ID,
        FIRST_VALUE(VISIT.ORIGINAL_SOURCE_SYSTEM_ID) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 1 ELSE 0 END) AS ORIGINAL_SOURCE_SYSTEM_ID,
        FIRST_VALUE(VISIT.ORIGINAL_CLIENT_KEY) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 1 ELSE 0 END) AS ORIGINAL_CLIENT_KEY,
        VISIT.SOURCE_SYSTEM_ID,
		--VISIT.BRANCH_KEY,
        FIRST_VALUE(VISIT.BRANCH_KEY) OVER(PARTITION BY SERVICE_WEEK, VISIT.PARTNER_CONTRACT_SERVICE_KEY,VISIT.CONTRACT_KEY,VISIT.CLIENT_KEY ORDER BY IFF(MAX(VISIT.CONFIRMED_FLAG) = ''YES'', 0, 1), MAX(SERVICE_WEEK) DESC,  NVL(SUM(VISIT.HOURS_SERVED), 0) DESC) BRANCH_KEY,
		VISIT.CONTRACT_KEY,
--		VISIT.CONFIRMED_FLAG,
--		VISIT.VISIT_KEY,
		--VISIT.SUPERVISOR_KEY,
       	FIRST_VALUE(VISIT.SUPERVISOR_KEY) OVER(PARTITION BY SERVICE_WEEK, VISIT.PARTNER_CONTRACT_SERVICE_KEY,VISIT.CONTRACT_KEY,VISIT.CLIENT_KEY ORDER BY IFF(MAX(VISIT.CONFIRMED_FLAG) = ''YES'', 0, 1), MAX(SERVICE_WEEK) DESC,  NVL(SUM(VISIT.HOURS_SERVED), 0) DESC) SUPERVISOR_KEY,
        SUM(NVL(SUM(IFF(VISIT.CONFIRMED_FLAG = ''YES'', VISIT.HOURS_SERVED,0)), 0)) OVER(PARTITION BY SERVICE_WEEK, VISIT.PARTNER_CONTRACT_SERVICE_KEY,VISIT.CONTRACT_KEY,VISIT.CLIENT_KEY) HOURS_SERVED, 
		--SUM(iff(CONFIRMED_FLAG = ''YES'',VISIT.HOURS_SERVED,0)) AS HOURS_SERVED,
      	SUM(COUNT(IFF(VISIT.CLEAN_SHIFT_FLAG = 1 AND CONFIRMED_FLAG = ''YES'', VISIT.VISIT_KEY, NULL))) OVER(PARTITION BY DD.HAH_CURRENT_WEEK_FIRST_DAY, VISIT.CLIENT_KEY, VISIT.PARTNER_CONTRACT_SERVICE_KEY) 
      		AS VISITS_CLEAN_SHIFTS,
		SUM(COUNT(IFF(VISIT.CLEAN_SHIFT_FLAG = 0 AND CONFIRMED_FLAG = ''YES'', VISIT.VISIT_KEY, NULL))) OVER(PARTITION BY DD.HAH_CURRENT_WEEK_FIRST_DAY, VISIT.CLIENT_KEY, VISIT.PARTNER_CONTRACT_SERVICE_KEY) 
			AS VISITS_NEED_MAINTENANCE	,	
		SUM(COUNT(IFF(VISIT.CONFIRMED_FLAG = ''YES'',VISIT.VISIT_KEY,NULL))) OVER(PARTITION BY DD.HAH_CURRENT_WEEK_FIRST_DAY,VISIT.PARTNER_CONTRACT_SERVICE_KEY, VISIT.CONTRACT_KEY,VISIT.CLIENT_KEY) AS VISITS_ALL
		,LISTAGG(DISTINCT 
		IFF(max(cc.BILLABLE )=''TRUE'' and max(visit.CONFIRMED_FLAG)=''YES'' and ((DATE_TRUNC(''WEEK'',SERVICE_WEEK) BETWEEN ''2023-05-01'' AND ''2023-07-02'') OR
		(DATE_TRUNC(''WEEK'',SERVICE_WEEK) BETWEEN ''2023-07-30'' AND ''2023-09-02'')) AND VISIT.ORIGINAL_SOURCE_SYSTEM_ID IN (4,17,3) 
		,VISIT.PARTNER_CONTRACT_SERVICE_KEY,null)) 
		OVER (PARTITION BY VISIT.CLIENT_KEY, DATE_TRUNC(''WEEK'',SERVICE_WEEK) ) AS ID
   FROM INTEGRATION.FACT_VISIT_MERGED VISIT
   LEFT JOIN DW_${var.SF_ENVIRONMENT}.REPORT.VW_DASHBOARD_CONTRACTS cc ON visit.CONTRACT_KEY = cc.CONTRACT_KEY AND cc.BILLABLE =''TRUE''
   JOIN HAH.DIM_DATE DD ON DD.CALENDAR_DATE = VISIT.SERVICE_DATE
 JOIN NOD ON VISIT.CLIENT_KEY = NOD.CLIENT_KEY AND VISIT.PARTNER_CONTRACT_SERVICE_KEY = NOD.PARTNER_CONTRACT_SERVICE_KEY AND DD.HAH_CURRENT_WEEK_FIRST_DAY= NOD.HAH_CURRENT_WEEK_FIRST_DAY 
-- JOIN INTEGRATION.DIM_BRANCH_MERGED BRANCH
--		ON BRANCH.ORIGINAL_BRANCH_KEY = VISIT.BRANCH_KEY 
   --Left JOIN INTEGRATION.FACT_BRANCH_PAYROLL_PERIODS_MERGED  P ON VISIT.PAYROLL_DATE = P.CHECK_DATE
        --AND P.ORIGINAL_BRANCH_KEY =VISIT.ORIGINAL_BRANCH_KEY 
   /*LEFT JOIN (SELECT BRANCH_KEY,PERIOD_START_DATE,PERIOD_END_DATE,CHECK_DATE,ORIGINAL_BRANCH_KEY,
        lag(check_date) over (partition by BRANCH_KEY ORDER BY CHECK_DATE ASC) AS PreviousCheckDate
        FROM INTEGRATION.FACT_BRANCH_PAYROLL_PERIODS_MERGED) PAYROLL_NEXTCHECKDATE ON VISIT.PAYROLL_DATE < PAYROLL_NEXTCHECKDATE.CHECK_DATE
        AND VISIT.PAYROLL_DATE >= PAYROLL_NEXTCHECKDATE.PreviousCheckDate AND PAYROLL_NEXTCHECKDATE.ORIGINAL_BRANCH_KEY =VISIT.ORIGINAL_BRANCH_KEY */
   --WHERE NVL(VISIT.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly'' 
   WHERE VISIT.ORIGINAL_SOURCE_SYSTEM_ID IN (4,7,17,13,9,3)-- VISIT.CONFIRMED_FLAG = ''YES'' 	-- Only confirmed visits	-- Need all visits now									  
   GROUP BY
        DD.HAH_CURRENT_WEEK_FIRST_DAY ,
		VISIT.CLIENT_KEY,
		VISIT.CLIENT_NUMBER,
        NOD.NO_OF_DAYS,
		VISIT.PARTNER_CONTRACT_SERVICE_KEY,
		VISIT.ORIGINAL_SOURCE_SYSTEM_ID,
		VISIT.ORIGINAL_CLIENT_KEY,
		VISIT.SOURCE_SYSTEM_ID,
		VISIT.BRANCH_KEY,
		VISIT.CONTRACT_KEY,
		VISIT.SUPERVISOR_KEY
        /*COALESCE(P.CHECK_DATE,PAYROLL_NEXTCHECKDATE.CHECK_DATE),
        COALESCE(P.PERIOD_START_DATE,PAYROLL_NEXTCHECKDATE.PERIOD_START_DATE),
        COALESCE(P.PERIOD_END_DATE,PAYROLL_NEXTCHECKDATE.PERIOD_END_DATE)*/
	)--SELECT count(*) ,SOURCE_SYSTEM_ID FROM visit_data GROUP BY SOURCE_SYSTEM_ID ,   --37142269
,VISIT AS (
SELECT 
a.SERVICE_WEEK,
a.PARTNER_CONTRACT_SERVICE_KEY,
a.CONTRACT_KEY,
a.CLIENT_KEY,
a.SOURCE_SYSTEM_ID,
a.ORIGINAL_SOURCE_SYSTEM_ID,
a.ORIGINAL_CLIENT_KEY,
a.CLIENT_NUMBER, 
a.BRANCH_KEY,
a.SUPERVISOR_KEY,
A.NO_OF_DAYS,
--a.HOURS_SERVED,
--a.HOURS_BILLED,
--a.VISITS_ALL,
--a.VISITS_CLEAN_SHIFTS,
--a.VISITS_NEED_MAINTENANCE,
iff(cc.CONTRACT_KEY IS NOT NULL , b.PARTNER_CONTRACT_SERVICE_KEY,a.PARTNER_CONTRACT_SERVICE_KEY ) AS merged_contract
,IFF(b.PARTNER_CONTRACT_SERVICE_KEY IS NULL , A.HOURS_SERVED, sum(A.HOURS_SERVED) OVER (PARTITION BY CLIENT_KEY, SERVICE_WEEK, merged_contract)) AS HOURS_SERVED
--,IFF(b.PARTNER_CONTRACT_SERVICE_KEY IS NULL , A.HOURS_BILLED, sum(A.HOURS_BILLED) OVER (PARTITION BY CLIENT_KEY, SERVICE_WEEK, merged_contract) ) AS HOURS_BILLED
,IFF(b.PARTNER_CONTRACT_SERVICE_KEY IS NULL , A.VISITS_ALL , sum(A.VISITS_ALL) OVER (PARTITION BY CLIENT_KEY, SERVICE_WEEK, merged_contract) ) AS VISITS_ALL 
,IFF(b.PARTNER_CONTRACT_SERVICE_KEY IS NULL , A.VISITS_CLEAN_SHIFTS, sum(A.VISITS_CLEAN_SHIFTS) OVER (PARTITION BY CLIENT_KEY, SERVICE_WEEK, merged_contract) ) AS VISITS_CLEAN_SHIFTS
,IFF(b.PARTNER_CONTRACT_SERVICE_KEY IS NULL , A.VISITS_NEED_MAINTENANCE, sum(A.VISITS_NEED_MAINTENANCE) OVER (PARTITION BY CLIENT_KEY, SERVICE_WEEK, merged_contract) ) AS VISITS_NEED_MAINTENANCE
FROM VISIT_DATA a
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.CONTRACT_MAPPING b ON a.id= b.KEY2 OR a.id =b.KEY1 
LEFT JOIN DW_${var.SF_ENVIRONMENT}.REPORT.VW_DASHBOARD_CONTRACTS cc ON a.CONTRACT_KEY = cc.CONTRACT_KEY AND cc.BILLABLE =''TRUE'' 
QUALIFY(iff(cc.CONTRACT_KEY IS NOT NULL , b.PARTNER_CONTRACT_SERVICE_KEY,NULL )) IS NULL  OR (merged_contract IS NOT NULL  AND b.PARTNER_CONTRACT_SERVICE_KEY =a.PARTNER_CONTRACT_SERVICE_KEY)
),
NEW_METRICS AS
	(	
		SELECT 
			/*PAYROLL_DATE,
			PAY_PERIOD_START_DATE, 
			PAY_PERIOD_END_DATE,*/
			SERVICE_WEEK,
			CLIENT_KEY,
			BRANCH_KEY,
			PARTNER_CONTRACT_SERVICE_KEY,
			SUPERVISOR_KEY,
			sum(HOURS_IN_REVIEW) AS HOURS_IN_REVIEW,
			sum(FUTURE_HOURS) AS FUTURE_HOURS,
			SUM(FUTURE_HOURS_NO_CAREGIVER) AS FUTURE_HOURS_NO_CAREGIVER,
			sum(FUTURE_CANCELLED_HOURS) AS FUTURE_CANCELLED_HOURS,
			sum(FUTURE_HOLD_HOURS) AS FUTURE_HOLD_HOURS,
			sum(HOURS_MISSED) AS HOURS_MISSED,
			sum(HOURS_CANCELLED) AS HOURS_CANCELLED,
			sum(HOURS_RESCHEDULED) AS HOURS_RESCHEDULED,
			sum(HOURS_SCHEDULED) AS HOURS_SCHEDULED,
			sum(VISITS_IN_REVIEW) AS VISITS_IN_REVIEW,
			sum(FUTURE_VISITS) AS FUTURE_VISITS,
			sum(FUTURE_CANCELLED_VISITS) AS FUTURE_CANCELLED_VISITS,
			sum(FUTURE_HOLD_VISITS) AS FUTURE_HOLD_VISITS,
			sum(VISITS_MISSED) AS VISITS_MISSED,
			sum(VISITS_COMPLETED) AS VISITS_COMPLETED,
			sum(VISITS_CANCELLED) AS VISITS_CANCELLED,
			sum(VISITS_RESCHEDULED) AS VISITS_RESCHEDULED,
			sum(VISITS_SCHEDULED) AS VISITS_SCHEDULED
		FROM REPORT.SCHEDULE_METRICS_WEEKLY
		GROUP BY 
			/*PAYROLL_DATE,
			PAY_PERIOD_START_DATE, 
			PAY_PERIOD_END_DATE,*/
			SERVICE_WEEK,
			CLIENT_KEY,
			BRANCH_KEY,
			PARTNER_CONTRACT_SERVICE_KEY,
			SUPERVISOR_KEY   	 
    ), 
AUTHORIZATION AS (
	SELECT SOURCE_SYSTEM_ID,HAH_CURRENT_WEEK_FIRST_DAY AS  WEEK, PARTNER_CONTRACT_SERVICE_KEY, CLIENT_KEY,ATYPE,
	sum(PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED) AS HOURS_AUTHORIZED_NON_ADJUSTED,
	sum(PERIOD_HOURS_AUTHORIZED) AS HOURS_AUTHORIZED,
    min(AUTH_START_DATE) AS amindate,
	max(AUTH_END_DATE) AS amaxdate
	FROM DW_${var.SF_ENVIRONMENT}.REPORT.CLIENT_SERVICE_WEEKLY_AUTHORIZATION GROUP BY 1,2,3,4,5
	)
      SELECT DISTINCT 
            /*DATA.PAYROLL_DATE,
            DATA.PAY_PERIOD_START_DATE,
            DATA.PAY_PERIOD_END_DATE,*/
            DATA.SERVICE_WEEK,
             IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') AS BILL_UNIT,
--            LAST_DAY(DATA.SERVICE_WEEK,"WEEK") AS SERVICE_END_OF_WEEK,
             COALESCE(BRANCH.OFFICE_STATE_CODE, CLIENT.CLIENT_STATE_CODE) STATE,
            DD.HAH_CURRENT_WEEK_LAST_DAY  AS SERVICE_END_OF_WEEK ,
			DATA.BRANCH_KEY,
			BRANCH.OFFICE_NUMBER,
		    BRANCH.DETAILED_OFFICE_NAME AS OFFICE_NAME,
			DATA.CONTRACT_KEY,
			DATA.SUPERVISOR_KEY,
			SUPERVISOR.SUPERVISOR_CODE,
			--DATA.CLIENT_KEY AS CLIENT_KEY_DATA,
			DATA.CLIENT_NUMBER,
            PCS.CONTRACT_CODE,
		    PCS.PARTNER_CODE,
		    PCS.SERVICE_CODE,
			DATA.PARTNER_CONTRACT_SERVICE_KEY ,
			DATA.ORIGINAL_SOURCE_SYSTEM_ID,
        	DATA.SOURCE_SYSTEM_ID,
			DATA.CLIENT_KEY CLIENT_KEY,
			IFF(DATA.SOURCE_SYSTEM_ID=3 AND B.REVENUE_SUBCATEGORY_CODE IN (''DDM'',''NSH'') ,DATA.HOURS_SERVED,0) AS NON_STANDARD_UNITS,
			B.REVENUE_CATEGORY AS REVENUE_CATEGORY,
			--SUM(COUNT(IFF(DATA.CONFIRMED_FLAG = ''YES'',DATA.VISIT_KEY,NULL))) OVER(PARTITION BY DATE_TRUNC(MONTH, DATA.REPORT_DATE),DATA.PARTNER_CONTRACT_SERVICE_KEY, DATA.CONTRACT_KEY,DATA.CLIENT_KEY) AS VISITS_ALL,
			DATA.VISITS_ALL,
--			SUM(COUNT(IFF(VISIT.CONFIRMED_FLAG = ''YES'',VISIT.VISIT_KEY,NULL))) 
--OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE),VISIT.PARTNER_CONTRACT_SERVICE_KEY, VISIT.CONTRACT_KEY,VISIT.CLIENT_KEY) AS VISITS_ALL ,
--			nvl(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN NM.HOURS_SCHEDULED END , 0) HOURS_SCHEDULED,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN DATA.HOURS_SERVED END, 0) HOURS_SERVED_ALL,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN NM.HOURS_CANCELLED END, 0) HOURS_CANCELLED,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN  NM.HOURS_IN_REVIEW END, 0) HOURS_IN_REVIEW,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN  NM.HOURS_MISSED END, 0) HOURS_MISSED,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN NM.FUTURE_HOURS END, 0) FUTURE_HOURS,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN  NM.FUTURE_CANCELLED_HOURS END, 0) FUTURE_CANCELLED_HOURS,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN  NM.FUTURE_HOLD_HOURS END, 0) FUTURE_HOLD_HOURS,
--			NVL(CASE WHEN IFNULL(IFF(PCS.SCHEDULE_TYPE=''UNKNOWN'',''Hourly'',PCS.SCHEDULE_TYPE),''Hourly'') = ''Hourly'' THEN  NM.HOURS_RESCHEDULED END, 0) HOURS_RESCHEDULED,	
			NVL( NM.HOURS_SCHEDULED  , 0) HOURS_SCHEDULED,
			NVL( DATA.HOURS_SERVED , 0) HOURS_SERVED_ALL,
			NVL( NM.HOURS_CANCELLED , 0) HOURS_CANCELLED,
			NVL( NM.HOURS_IN_REVIEW , 0) HOURS_IN_REVIEW,
			NVL( NM.HOURS_MISSED , 0) HOURS_MISSED,
			NVL( NM.FUTURE_HOURS , 0) FUTURE_HOURS,
			NVL( NM.FUTURE_HOURS_NO_CAREGIVER,0) FUTURE_HOURS_NO_CAREGIVER,
			NVL( NM.FUTURE_CANCELLED_HOURS , 0) FUTURE_CANCELLED_HOURS,
			NVL( NM.FUTURE_HOLD_HOURS , 0) FUTURE_HOLD_HOURS,
			NVL( NM.HOURS_RESCHEDULED , 0) HOURS_RESCHEDULED,	
            NVL(NM.VISITS_SCHEDULED, 0) VISITS_SCHEDULED,
			NVL(NM.VISITS_COMPLETED, 0) VISITS_COMPLETED,
			NVL(NM.VISITS_CANCELLED, 0) VISITS_CANCELLED,
			NVL(NM.VISITS_IN_REVIEW, 0) VISITS_IN_REVIEW,
			NVL(NM.VISITS_MISSED, 0) VISITS_MISSED,
			NVL(NM.FUTURE_VISITS, 0) FUTURE_VISITS,
			NVL(NM.FUTURE_CANCELLED_VISITS, 0) FUTURE_CANCELLED_VISITS,
			NVL(NM.FUTURE_HOLD_VISITS, 0) FUTURE_HOLD_VISITS,
			NVL(NM.VISITS_RESCHEDULED, 0) VISITS_RESCHEDULED,
			auth.HOURS_AUTHORIZED,
			auth.HOURS_AUTHORIZED_NON_ADJUSTED,
            IFF(NVL(AUTH.HOURS_AUTHORIZED, 0) <= 0, NULL, NVL(DATA.HOURS_SERVED, 0) / AUTH.HOURS_AUTHORIZED) AS UTILIZATION,
		IFF(IFF(NVL(AUTH.HOURS_AUTHORIZED_NON_ADJUSTED , 0) <= 0, NULL, NVL(DATA.HOURS_SERVED, 0) / AUTH.HOURS_AUTHORIZED_NON_ADJUSTED)>1, 1, 0) AS OVER_AUTHED,
		IFF(IFF(NVL(AUTH.HOURS_AUTHORIZED , 0) <= 0, NULL, NVL(DATA.HOURS_SERVED, 0) / AUTH.HOURS_AUTHORIZED)>1, 1, 0) AS OVER_AUTHED_ADJUSTED,
	    IFF(AUTH.HOURS_AUTHORIZED_NON_ADJUSTED <DATA.HOURS_SERVED, NVL(DATA.HOURS_SERVED, 0) - AUTH.HOURS_AUTHORIZED_NON_ADJUSTED , NULL) AS OVER_AUTHED_HOURS,
		IFF(AUTH.HOURS_AUTHORIZED<DATA.HOURS_SERVED, NVL(DATA.HOURS_SERVED, 0) - AUTH.HOURS_AUTHORIZED, NULL) AS OVER_AUTHED_HOURS_ADJUSTED,
		IFF(NVL(DATA.HOURS_SERVED, 0) > 0 AND NVL(AUTH.HOURS_AUTHORIZED, 0) <= 0, 1, 0) AS SERVED_WITHOUT_AUTH,
            DATA.VISITS_CLEAN_SHIFTS,
            DATA.VISITS_NEED_MAINTENANCE,
			NVL(CASE WHEN NOT (NVL(AUTH.HOURS_AUTHORIZED, 0) = 0 OR AUTH.HOURS_AUTHORIZED > 900 ) 
			THEN IFF(DATA.SOURCE_SYSTEM_ID=3 AND B.REVENUE_SUBCATEGORY_CODE IN (''DDM'',''NSH'') ,0,nvl(mc.merhrs, DATA.HOURS_SERVED))END, 0) HOURS_SERVED_WHERE_AUTH_EXISTS,
			IFF(VISITS_COMPLETED = 0, FALSE, TRUE) AS CLIENT_SERVED_FLAG,
			-1 AS ETL_TASK_KEY,
	        -1 AS ETL_INSERTED_TASK_KEY,
        	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
			CURRENT_USER as ETL_INSERTED_BY ,
			convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
			CURRENT_USER as ETL_LAST_UPDATED_BY,
			0 as ETL_DELETED_FLAG,
			0 AS ETL_INFERRED_MEMBER_FLAG,
				 IFF(COALESCE(CCSI_BRANCH.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY,MATRIXCARE_CLIENT.CLIENT_KEY,ALAYACARE_CLIENT.CLIENT_KEY,PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY,PREFERRED_CLIENT.CLIENT_KEY,EDISON_CLIENT.CLIENT_KEY,MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY,LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY,ASR_CLIENT.CLIENT_KEY,CLEARCARE_CLIENT.CLIENT_KEY,BERKSHIRE_CLIENT.CLIENT_KEY,OPENSYSTEMS_CLIENT.CLIENT_KEY,AXXESS_CLIENT.CLIENT_KEY,ALLIANCE_CLIENT.CLIENT_KEY,MYCARE_CLIENT.CLIENT_KEY,ALL_GEN_CLIENT.CLIENT_KEY,RECCO_CLIENT.CLIENT_KEY) IS NULL, FALSE, TRUE) AS CLIENT_ACQUIRED_FLAG,
      --IFF(COALESCE(CCSI_BRANCH.BRANCH_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY) IS NULL, FALSE, TRUE) AS CLIENT_ACQUIRED_FLAG,
        CASE WHEN COALESCE(CCSI_BRANCH.CLIENT_KEY,CCSI_ACQUIRED_CLIENT.CLIENT_KEY) IS NOT NULL THEN ''CCSI'' 
        WHEN MATRIXCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN ''ADAPTIVE'' 
        WHEN ALAYACARE_CLIENT.CLIENT_KEY IS NOT NULL THEN UPPER(ALAYACARE_CLIENT.AQUISITION_NAME)
        WHEN PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN ''PRAETORIAN''
        WHEN PREFERRED_CLIENT.CLIENT_KEY IS NOT NULL THEN ''PREFERRED''
        WHEN EDISON_CLIENT.CLIENT_KEY IS NOT NULL THEN ''EDISON''
        WHEN MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN ''MERIDIUS''
        WHEN LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY IS NOT NULL THEN ''LONGEVITY''
        WHEN ASR_CLIENT.CLIENT_KEY IS NOT NULL THEN ''ASR''
		WHEN BERKSHIRE_CLIENT.CLIENT_KEY IS NOT NULL THEN ''BERKSHIRE''
		WHEN OPENSYSTEMS_CLIENT.CLIENT_KEY IS NOT NULL THEN ''OPENSYSTEMS''
		WHEN AXXESS_CLIENT.CLIENT_KEY IS NOT NULL THEN ''AXXESS''
		WHEN ALLIANCE_CLIENT.CLIENT_KEY IS NOT NULL THEN ''ALLIANCE''
        WHEN MYCARE_CLIENT.CLIENT_KEY IS NOT NULL THEN ''MYCARE''
        WHEN ALL_GEN_CLIENT.CLIENT_KEY IS NOT NULL THEN ''ALL GENERATIONS''
		WHEN RECCO_CLIENT.CLIENT_KEY IS NOT NULL THEN ''RECCO''
        ELSE NULL END AS CLIENT_ACQUISITION_NAME,
		CASE WHEN UPPER(BILL_UNIT)=''VISIT'' THEN NM.VISITS_COMPLETED ELSE NULL END AS VISITS_COMPLETED_VISIT_BASED, --24
		CASE WHEN UPPER(BILL_UNIT)=''HOURLY'' THEN NM.VISITS_COMPLETED ELSE NULL END AS VISITS_COMPLETED_TIME_BASED,  --25
		CASE WHEN UPPER(BILL_UNIT)=''VISIT'' THEN DATA.HOURS_SERVED ELSE NULL END AS HOURS_SERVED_VISIT, 	--35
		CASE WHEN UPPER(BILL_UNIT)=''HOURLY'' THEN DATA.HOURS_SERVED ELSE NULL END AS HOURS_SERVED_TIME_BASED,	--36
		AUTH.ATYPE AS AUTH_UNIT_TYPE, 	--48 BRING THE AUTHORIZATION_TYPE FROM FACT_CLIENT_SERVICE
		--VISITS_AUTHORIZED_ALL	--49 ON HOLD
		--VISITS_AUTHORIZED_ADJUSTED,	--50 ON HOLD
		PCS.CONTRACT_NAME,	--63
		PCS.SERVICE_NAME,	--64
		PCS.PARTNER_NAME,	--65
		AUTH.AMINDATE AS AUTH_START_DATE,	--66
		AUTH.AMAXDATE AS AUTH_END_DATE,	--67
	    DATA.NO_OF_DAYS AS NUMBER_OF_DAYS --NNUMBER OF DAYS A CLIENT GET IN A MONTH UNDER DIFFERENT SERVICE  --23
            FROM VISIT AS DATA
            JOIN HAH.DIM_DATE DD ON DD.HAH_CURRENT_WEEK_FIRST_DAY = DATA.SERVICE_WEEK   
            LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED CLIENT
		ON CLIENT.ORIGINAL_CLIENT_KEY = data.CLIENT_KEY
            LEFT JOIN INTEGRATION.DIM_BRANCH_MERGED BRANCH
		ON BRANCH.ORIGINAL_BRANCH_KEY = DATA.BRANCH_KEY 
		LEFT JOIN INTEGRATION.DIM_SUPERVISOR_MERGED SUPERVISOR
  ON SUPERVISOR.ORIGINAL_SUPERVISOR_KEY = DATA.SUPERVISOR_KEY
left join HAH.FACT_PARTNER_CONTRACT_SERVICE PCS on 
		DATA.PARTNER_CONTRACT_SERVICE_KEY = PCS.PARTNER_CONTRACT_SERVICE_KEY
left join DW_${var.SF_ENVIRONMENT}.REPORT.MS_OSHAH_CONTRACT_MAP mc on mc.client_key =data.client_key and data.partner_contract_service_key = mc.hha_con and data.SERVICE_WEEK=''2023-08-01''
LEFT JOIN AUTHORIZATION AUTH ON DATA.SERVICE_WEEK = AUTH.WEEK AND DATA.PARTNER_CONTRACT_SERVICE_KEY= AUTH.PARTNER_CONTRACT_SERVICE_KEY 
	AND DATA.CLIENT_KEY = AUTH.CLIENT_KEY AND DATA.SOURCE_SYSTEM_ID = AUTH.SOURCE_SYSTEM_ID 		
--LEFT JOIN HAH.DIM_BILLING B ON B.BILLING_KEY = PCS.BILLING_KEY 
  LEFT JOIN HAH.DIM_SERVICES B ON B.SERVICE_KEY = PCS.SERVICE_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 CCSI_BRANCH ON
    	  CCSI_BRANCH.BRANCH_KEY = DATA.BRANCH_KEY 
		  AND CCSI_BRANCH.CLIENT_KEY = DATA.CLIENT_KEY 
		  AND CCSI_BRANCH.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY 
		  AND CCSI_BRANCH.AQUISITION_NAME =''CCSI''
          AND CCSI_BRANCH.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN (SELECT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 WHERE AQUISITION_NAME = ''CCSI'' ) CCSI_ACQUIRED_CLIENT
          ON CCSI_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND DATA.SERVICE_WEEK >= ''2021-07-01''
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0_MERGED WHERE NOTES = ''Altamaha'') ALAYACARE_CLIENT
--          ON ALAYACARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0  ALAYACARE_CLIENT
ON ALAYACARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY
	AND ALAYACARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
	AND ALAYACARE_CLIENT.SOURCE_SYSTEM_ID  = 9
    AND ALAYACARE_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY
    AND ALAYACARE_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0_MERGED WHERE NOTES = ''Praetorian'') PRAETORIAN_ACQUIRED_CLIENT
--          ON PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND DATA.SERVICE_WEEK >= ''2022-01-01''
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 PRAETORIAN_ACQUIRED_CLIENT ON 
	      PRAETORIAN_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      PRAETORIAN_ACQUIRED_CLIENT.AQUISITION_NAME =''Praetorian'' AND
		  PRAETORIAN_ACQUIRED_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK AND		  
	      DATA.SERVICE_WEEK >= ''2022-01-01''
--LEFT OUTER JOIN (SELECT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE BRANCH_NAME like ''A__%'' and SYSTEM_CODE = ''MATRIXCARE'') MATRIXCARE_BRANCH
--                      ON MATRIXCARE_BRANCH.BRANCH_KEY = DATA.BRANCH_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 MATRIXCARE_CLIENT
		  ON MATRIXCARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY 
		  AND MATRIXCARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY 
		  AND MATRIXCARE_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY 
		  AND MATRIXCARE_CLIENT.AQUISITION_NAME =''ADAPTIVE''
		  AND MATRIXCARE_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK		  
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0_MERGED WHERE NOTES = ''Preferred'') PREFERRED_CLIENT
--         ON PREFERRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 PREFERRED_CLIENT
		  ON PREFERRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY 
		  AND PREFERRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY 
		  AND PREFERRED_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY 
		  AND PREFERRED_CLIENT.AQUISITION_NAME =''PREFERRED''
		  AND PREFERRED_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK		  
--LEFT OUTER JOIN (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0_MERGED WHERE NOTES = ''Edison'') EDISON_CLIENT
--         ON EDISON_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY   
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 EDISON_CLIENT
		  ON EDISON_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY 
		  AND EDISON_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY 
		  AND EDISON_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY 
		  AND EDISON_CLIENT.AQUISITION_NAME =''EDISON''
		  AND EDISON_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK		  
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 MERIDIUS_ACQUIRED_CLIENT ON 
	      MERIDIUS_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      MERIDIUS_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
          MERIDIUS_ACQUIRED_CLIENT.AQUISITION_NAME =''Meridius'' AND
		  MERIDIUS_ACQUIRED_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK		  
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 LONGEVITY_ACQUIRED_CLIENT ON 
	      LONGEVITY_ACQUIRED_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      LONGEVITY_ACQUIRED_CLIENT.AQUISITION_NAME =''Longevity'' AND
		  LONGEVITY_ACQUIRED_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK		  
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 ASR_CLIENT ON 
	      ASR_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      ASR_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      ASR_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      ASR_CLIENT.AQUISITION_NAME =''ASR'' AND
		  ASR_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK		  
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 CLEARCARE_CLIENT ON 
	      CLEARCARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      CLEARCARE_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      CLEARCARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      CLEARCARE_CLIENT.AQUISITION_NAME =''CLEARCARE'' AND
		  CLEARCARE_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 BERKSHIRE_CLIENT ON 
	      BERKSHIRE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      BERKSHIRE_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      BERKSHIRE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      BERKSHIRE_CLIENT.AQUISITION_NAME =''BERKSHIRE'' AND
		  BERKSHIRE_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK	
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 OPENSYSTEMS_CLIENT ON 
	      OPENSYSTEMS_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      OPENSYSTEMS_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      OPENSYSTEMS_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      OPENSYSTEMS_CLIENT.AQUISITION_NAME =''OPENSYSTEMS'' AND
		  OPENSYSTEMS_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 AXXESS_CLIENT ON 
	      AXXESS_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      AXXESS_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      AXXESS_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      AXXESS_CLIENT.AQUISITION_NAME =''AXXESS'' AND
		  AXXESS_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 ALLIANCE_CLIENT ON 
	      ALLIANCE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      ALLIANCE_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      ALLIANCE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      ALLIANCE_CLIENT.AQUISITION_NAME =''ALLIANCE'' AND
		  ALLIANCE_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 MYCARE_CLIENT ON 
	      MYCARE_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      MYCARE_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      MYCARE_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      MYCARE_CLIENT.AQUISITION_NAME =''MYCARE'' AND
		  MYCARE_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 ALL_GEN_CLIENT ON 
	      ALL_GEN_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      ALL_GEN_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      ALL_GEN_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      ALL_GEN_CLIENT.AQUISITION_NAME =''All Generations'' AND
		  ALL_GEN_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN HAH.FACT_CLIENT_ACQUIRED_WEEKLY_2_0 RECCO_CLIENT ON 
	      RECCO_CLIENT.CLIENT_KEY = DATA.CLIENT_KEY AND
	      RECCO_CLIENT.CONTRACT_KEY = DATA.PARTNER_CONTRACT_SERVICE_KEY AND
	      RECCO_CLIENT.BRANCH_KEY = DATA.BRANCH_KEY AND
	      RECCO_CLIENT.AQUISITION_NAME =''RECCO'' AND
		  RECCO_CLIENT.SERVICE_WEEK =	DATA.SERVICE_WEEK
LEFT OUTER JOIN NEW_METRICS AS NM ON DATA.SERVICE_WEEK=NM.SERVICE_WEEK 
			AND DATA.CLIENT_KEY = NM.CLIENT_KEY AND DATA.BRANCH_KEY = NM.BRANCH_KEY 
			AND DATA.PARTNER_CONTRACT_SERVICE_KEY=NM.PARTNER_CONTRACT_SERVICE_KEY AND DATA.SUPERVISOR_KEY=NM.SUPERVISOR_KEY
			/*AND NVL(DATA.PAYROLL_DATE,''0'')= NVL(NM.PAYROLL_DATE,''0'')
			AND NVL(DATA.PAY_PERIOD_START_DATE,''0'')= NVL(NM.PAY_PERIOD_START_DATE,''0'')
			AND NVL(DATA.PAY_PERIOD_END_DATE,''0'')= NVL(NM.PAY_PERIOD_END_DATE,''0'')*/
WHERE IFF(CLIENT_SERVED_FLAG = TRUE, NVL(DATA.HOURS_SERVED, 0), 1) > 0
--AND IFNULL(B.REVENUE_CATEGORY,CASE WHEN PCS.SOURCE_SYSTEM_ID =4 AND PCS.SYSTEM_CODE =''CC_8485'' THEN ''CC''
--WHEN PCS.SOURCE_SYSTEM_ID =4 AND PCS.SYSTEM_CODE =''8485'' THEN ''HC'' END)
AND B.REVENUE_CATEGORY NOT IN (''CLS'',''NA'',''CC'') AND PCS.BILLABLE_FLAG = TRUE
	--AND NVL(DATA.HOURS_SERVED, 0) > 0
    --AND DATA.SERVICE_WEEK <= LAST_DAY(CURRENT_DATE,"WEEK")			-- Need all data in structure and upto 4 weeks into the future - in views
;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

 EOT
}

