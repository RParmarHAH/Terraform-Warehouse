CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_RPT_AUTH_METRICS_BKP("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

    --*****************************************************************************************************************************
-- NAME:  AUTH METRICS 
--
-- PURPOSE: FOR RCM
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 06/08/2022  POOJA SHAH            DEVELOPMENT FOR AUTH METRICS REQUIRED IN RCM
--*****************************************************************************************************************************
/*
SELECT * FROM DW_PROD.REPORT.RPT_UNBILLED_METRICS 
SELECT count(1) FROM DW_PROD.REPORT.RPT_UNBILLED_METRICS; --70863250, 13573438
SELECT 70863250 - 13573438
SELECT * FROM DW_PROD.INTEGRATION.FACT_INTAKE_MERGED LIMIT 5
SQL Error [100040] [22007]: Date ''''OP2591683762'''' is not recognized
 -- Date ''''OP2591683762'''' is not recognized
--  Date ''''OP2591683762'''' is not recognized
SELECT * FROM DW_PROD.INTEGRATION.FACT_INTAKE_MERGED WHERE REPORT_DATE LIKE ''''%OP2591683762%''''

SELECT * FROM DW_PROD.REPORT.RPT_AUTH_METRICS  LIMIT 5

grant ownership on all procedures in schema DW_PROD.INTEGRATION TO ETL_MANAGEMENT_dEV COPY CURRENT GRANTS;
grant ownership on all procedures in schema DW_PROD.report TO ETL_MANAGEMENT_dEV COPY CURRENT GRANTS;
grant ownership on all tables in schema DW_PROD.report TO ETL_MANAGEMENT_dEV COPY CURRENT GRANTS;
CALL DW_PROD.REPORT.GET_REPORT_AUTH_METRICS()
--CALL DW_PROD.REPORT.GET_REPORT_UNBILLED_METRICS()

*/

INSERT OVERWRITE INTO REPORT.RPT_AUTH_METRICS 
SELECT 
--SERVICE_DATE,
REPORT_DATE,
ORIGINAL_BRANCH_KEY , -- ADDED BY PJSHAH ON 8/22
BRANCH_NAME, 
OFFICE_CITY, 
OFFICE_STATE_CODE, 
STATE_BRANCH,
REGION_NAME, 
ORIGINAL_CLIENT_KEY, -- ADDED BY PJSHAH ON 08/22 
CLIENT_NUMBER,
CONTRACT_KEY,  -- ADDED BY PJSHAH ON 08/22
CONTRACT_CODE, 
SYSTEM_CODE ,
SUM(HOURS_SERVED) AS HOURS_SERVED,
SUM(SCHEDULE_HOURS) AS SCHEDULE_HOURS,
SUM(HOURS_AUTHORIZED) AS HOURS_AUTHORIZED,
OVER_AUTHED_CONTRACT,
SUM(REMAINING_HOURS) AS REMAINING_HOURS
,REVENUE_CATEGORY  -- Added ON 19042022	              
,PRE_AUTH_NUMBER AS PRE_AUTH_NUMBER		
,BEGIN_SERVICE_DATE AS BEGIN_SERVICE_DATE  
,END_SERVICE_DATE AS END_SERVICE_DATE			
,LATEST_AUTH_BEGIN_DATE AS LATEST_AUTH_BEGIN_DATE		           
,LATEST_AUTH_END_DATE AS LATEST_AUTH_END_DATE		
,SOURCE_SYSTEM_ID
,ORIGINAL_SOURCE_SYSTEM_ID 
,SUM(EXP_AUTHS_DAYS) AS EXP_AUTHS_DAYS
,EXP_AUTHS
FROM
(
SELECT 
NULL AS SERVICE_DATE,
date_trunc(''MONTH'', INTAKE.REPORT_DATE) as REPORT_DATE,
BRANCH_MERGED.ORIGINAL_BRANCH_KEY, -- ADDED BY PJSHAH ON 08/22
BRANCH_MERGED.BRANCH_NAME, 
BRANCH_MERGED.OFFICE_CITY , -- Added BY PJShah ON 240320222
BRANCH_MERGED.OFFICE_STATE_CODE, -- Added BY PJShah ON 240320222
CONCAT( nvl(BRANCH_MERGED.OFFICE_STATE_CODE,''''), '' - '', nvl(BRANCH_MERGED.BRANCH_NAME,'''')) AS STATE_BRANCH,
BRANCH_MERGED.REGION_NAME,  -- Added BY PJShah ON 240320222
CLIENT_MERGED.ORIGINAL_CLIENT_KEY, -- ADDED BY PJSHAH ON 08/22
CLIENT_MERGED.CLIENT_NUMBER  , 
INTAKE.CONTRACT_KEY,  -- ADDED BY PJSHAH ON 08/22
CT.CONTRACT_CODE ,
NULL AS EMPLOYEE_ID ,
NULL AS EMPLOYEENAME , 
INTAKE.SYSTEM_CODE ,
NULL AS SUPERVISOR_CODE ,
NULL AS SUPERVISOR_NAME , -- Added BY PJShah ON 240320222
NULL AS STATUS_CODE ,
NULL AS STATUS_DESCRIPTION
,0 AS No_Of_Visits,
SUM(HOURS_SERVED) HOURS_SERVED,
SUM(VISIT.SCHEDULE_HOURS) SCHEDULE_HOURS,
--SUM(CASE WHEN INTAKE.HOURS_AUTHORIZED<=748 THEN INTAKE.HOURS_AUTHORIZED ELSE NULL END) HOURS_AUTHORIZED, -- As per discussion with Eric on 06/08
--SUM(CASE WHEN INTAKE.BEGIN_SERVICE_DATE>=''2016-01-01'' THEN INTAKE.HOURS_AUTHORIZED ELSE NULL END) HOURS_AUTHORIZED, 
SUM(CASE WHEN INTAKE.BEGIN_SERVICE_DATE>=''2016-01-01'' AND INTAKE.HOURS_AUTHORIZED NOT LIKE ''%999%'' THEN INTAKE.HOURS_AUTHORIZED
ELSE NULL END) HOURS_AUTHORIZED,	--Added by Pinkal on 1/12/2022
0 AS Unbilled_Hrs,
0 AS BILLED_HRS,
IFF(IFF(NVL(SUM(INTAKE.HOURS_AUTHORIZED) , 0) <= 0, NULL, NVL(SUM(VISIT.HOURS_SERVED), 0) / SUM(INTAKE.HOURS_AUTHORIZED))>1, 1, 0) AS OVER_AUTHED_CONTRACT,
IFF(SUM(INTAKE.HOURS_AUTHORIZED)>SUM(VISIT.HOURS_SERVED), SUM(INTAKE.HOURS_AUTHORIZED) - SUM(NVL(VISIT.HOURS_SERVED, 0)) , NULL) REMAINING_HOURS
,CT.REVENUE_CATEGORY  -- Added ON 19042022
,INTAKE.PRE_AUTH_NUMBER				-- Added by PJShah on 12052022
,INTAKE.BEGIN_SERVICE_DATE      	-- Added by PJShah on 12052022                 
,INTAKE.END_SERVICE_DATE			-- Added by PJShah on 12052022
,INTAKE.LATEST_AUTH_BEGIN_DATE		-- Added by PJShah on 12052022            
,INTAKE.LATEST_AUTH_END_DATE		-- Added by PJShah on 12052022
--,DS.SOURCE_SYSTEM_NAME  -- Added BY PJShah ON 12052022
,VISIT.SOURCE_SYSTEM_ID
,VISIT.ORIGINAL_SOURCE_SYSTEM_ID 
,DATEDIFF(DAY,CURRENT_DATE(),INTAKE.LATEST_AUTH_END_DATE) AS EXP_AUTHS_DAYS
,IFF(INTAKE.LATEST_AUTH_END_DATE IS NOT NULL, -- NVL(INTAKE.LATEST_AUTH_END_DATE)<>'''',
CASE  WHEN (DATEDIFF(DAY,CURRENT_DATE(),INTAKE.LATEST_AUTH_END_DATE)<=15 AND DATEDIFF(DAY,CURRENT_DATE(),INTAKE.LATEST_AUTH_END_DATE) >=0 ) 
THEN ''EXPIRING''
WHEN DATEDIFF(DAY,CURRENT_DATE(),INTAKE.LATEST_AUTH_END_DATE)<0 THEN ''EXPIRED''
ELSE ''INFORCE'' END 
, ''NA'')
AS EXP_AUTHS
--SELECT COUNT(1)
FROM --HAH.VW_FACT_VISIT_MERGED
(
SELECT date_trunc(''MONTH'', REPORT_DATE) as REPORT_DATE,CLIENT_KEY,CONTRACT_KEY,ORIGINAL_SOURCE_SYSTEM_ID,SOURCE_SYSTEM_ID
,SUM(HOURS_SERVED) HOURS_SERVED,SUM(SCHEDULE_DURATION) AS SCHEDULE_HOURS
FROM 	INTEGRATION.FACT_VISIT_MERGED
GROUP BY 	date_trunc(''MONTH'', REPORT_DATE),CLIENT_KEY,CONTRACT_KEY,ORIGINAL_SOURCE_SYSTEM_ID,SOURCE_SYSTEM_ID
)AS VISIT
LEFT JOIN (SELECT REPORT_DATE, CONTRACT_KEY,CONTRACT_CODE,CLIENT_KEY,ORIGINAL_SOURCE_SYSTEM_ID, SYSTEM_CODE,SUM(HOURS_AUTHORIZED) AS HOURS_AUTHORIZED,
	BEGIN_SERVICE_DATE, END_SERVICE_DATE,PRE_AUTH_NUMBER, LATEST_AUTH_BEGIN_DATE, LATEST_AUTH_END_DATE, ORIGINAL_BRANCH_KEY,ORIGINAL_CLIENT_KEY
FROM DW_PROD.INTEGRATION.FACT_INTAKE_MERGED
GROUP BY REPORT_DATE, CONTRACT_KEY,CONTRACT_CODE,CLIENT_KEY,ORIGINAL_SOURCE_SYSTEM_ID, SYSTEM_CODE,
	BEGIN_SERVICE_DATE, END_SERVICE_DATE,PRE_AUTH_NUMBER, LATEST_AUTH_BEGIN_DATE, LATEST_AUTH_END_DATE, ORIGINAL_BRANCH_KEY,ORIGINAL_CLIENT_KEY
) AS INTAKE
ON INTAKE.REPORT_DATE = VISIT.REPORT_DATE 
AND INTAKE.CLIENT_KEY = VISIT.CLIENT_KEY 
AND INTAKE.CONTRACT_KEY = VISIT.CONTRACT_KEY
AND INTAKE.ORIGINAL_SOURCE_SYSTEM_ID =VISIT.ORIGINAL_SOURCE_SYSTEM_ID
--LEFT JOIN HAH.DIM_SOURCE_SYSTEM AS DS ON DS.SOURCE_SYSTEM_ID =INTAKE.ORIGINAL_SOURCE_SYSTEM_ID    ---SOURCE_SYSTEM_ID     
LEFT JOIN INTEGRATION.DIM_BRANCH_MERGED AS BRANCH_MERGED ON BRANCH_MERGED.ORIGINAL_BRANCH_KEY = INTAKE.ORIGINAL_BRANCH_KEY 
LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED AS CLIENT_MERGED ON CLIENT_MERGED.ORIGINAL_CLIENT_KEY = INTAKE.ORIGINAL_CLIENT_KEY 
LEFT JOIN HAH.DIM_CONTRACT CT ON CT.CONTRACT_KEY = INTAKE.CONTRACT_KEY  
GROUP BY 
date_trunc(''MONTH'', INTAKE.REPORT_DATE),
BRANCH_MERGED.ORIGINAL_BRANCH_KEY, 
BRANCH_MERGED.BRANCH_NAME, 
BRANCH_MERGED.OFFICE_CITY, 
BRANCH_MERGED.OFFICE_STATE_CODE,
BRANCH_MERGED.REGION_NAME,
CLIENT_MERGED.ORIGINAL_CLIENT_KEY,
CLIENT_MERGED.CLIENT_NUMBER,
INTAKE.CONTRACT_KEY,
INTAKE.CONTRACT_CODE ,
--VISIT.EMPLOYEE_ID ,EMPLOYEE_MERGED.EMPLOYEE_FIRST_NAME , EMPLOYEE_MERGED.EMPLOYEE_MIDDLE_NAME ,  EMPLOYEE_MERGED.EMPLOYEE_LAST_NAME,  -- Added BY PJShah ON 240320222
INTAKE.SYSTEM_CODE ,
--VISIT.SUPERVISOR_CODE ,SUPERVISOR_MERGED.SUPERVISOR_NAME , VISIT.STATUS_CODE ,VISIT.STATUS_DESCRIPTION,
REVENUE_CATEGORY
,CT.CONTRACT_CODE
,INTAKE.PRE_AUTH_NUMBER				-- Added by PJShah on 12052022
,INTAKE.BEGIN_SERVICE_DATE      	-- Added by PJShah on 12052022                 
,INTAKE.END_SERVICE_DATE			-- Added by PJShah on 12052022
,INTAKE.LATEST_AUTH_BEGIN_DATE		-- Added by PJShah on 12052022            
,INTAKE.LATEST_AUTH_END_DATE		-- Added by PJShah on 12052022;
,VISIT.SOURCE_SYSTEM_ID
,VISIT.ORIGINAL_SOURCE_SYSTEM_ID 
)T 
GROUP BY 
SERVICE_DATE,
REPORT_DATE  ,
BRANCH_NAME, 
OFFICE_CITY , 
OFFICE_STATE_CODE, 
STATE_BRANCH,
REGION_NAME,  
CLIENT_NUMBER ,
CONTRACT_CODE ,
EMPLOYEE_ID ,
EMPLOYEENAME ,  
SYSTEM_CODE ,
SUPERVISOR_CODE ,
SUPERVISOR_NAME , 
STATUS_CODE ,
STATUS_DESCRIPTION,
OVER_AUTHED_CONTRACT,
REVENUE_CATEGORY, 
SOURCE_SYSTEM_ID,
ORIGINAL_SOURCE_SYSTEM_ID,
EXP_AUTHS
,PRE_AUTH_NUMBER				-- Added by PJShah on 12052022
,BEGIN_SERVICE_DATE      	-- Added by PJShah on 12052022                 
,END_SERVICE_DATE			-- Added by PJShah on 12052022
,LATEST_AUTH_BEGIN_DATE		-- Added by PJShah on 12052022            
,LATEST_AUTH_END_DATE		-- Added by PJShah on 12052022
,ORIGINAL_BRANCH_KEY -- ADDED BY PJSHAH ON 08/22
,ORIGINAL_CLIENT_KEY -- ADDED BY PJSHAH ON 08/22
,CONTRACT_KEY -- ADDED BY PJSHAH ON 08/22
;
	
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

';