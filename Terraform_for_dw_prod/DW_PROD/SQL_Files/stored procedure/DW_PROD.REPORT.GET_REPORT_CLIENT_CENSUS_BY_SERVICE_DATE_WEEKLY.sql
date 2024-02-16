CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_CLIENT_CENSUS_BY_SERVICE_DATE_WEEKLY("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

    INSERT OVERWRITE INTO REPORT.CLIENT_CENSUS_BY_SERVICE_DATE_WEEKLY
WITH PAYROLLPERIODS
AS
(
	SELECT OFFICE_STATE_CODE AS STATE,CAST(MAX(PERIOD_END_DATE) AS DATE) as PERIODEND
	FROM INTEGRATION.FACT_BRANCH_PAYROLL_PERIODS_MERGED o       
	WHERE CHECK_DATE < Current_Date() -- This should be CheckDate NOT PeriodEnd, it takes a while for all the timesheets to be entered
	group by OFFICE_STATE_CODE
),
VISIT_DATA AS
(
	SELECT 
	DISTINCT 
	V.CLIENT_KEY  AS CLIENT_KEY,
	V.BRANCH_KEY AS BRANCH_KEY
	,v.SUPERVISOR_KEY AS SUPERVISOR_KEY,
	C.REVENUE_CATEGORY,C.REVENUE_SUBCATEGORY_CODE
	,CASE WHEN V.SYSTEM_CODE = ''8485'' THEN ''PA'' ELSE V.SYSTEM_CODE END AS STATE_CODE
	,V.SERVICE_DATE AS VISIT_SERVICE_DATE
	,last_day(V.SERVICE_DATE ,"WEEK") AS SERVICE_DATE,
	last_day(DATEADD(''DAYS'',-7,V.SERVICE_DATE ),"WEEK") AS PREV_SERVICE_DATE,
	last_day(DATEADD(''DAYS'',7,V.SERVICE_DATE ),"WEEK") AS NEXT_SERVICE_DATE
	,C.INCLUDE_FOR_EXEC_OPS_CLIENTS,C.INCLUDE_FOR_OPS_PERF_CLIENTS
	FROM INTEGRATION.FACT_VISIT_MERGED  V
	JOIN REPORT.VW_DASHBOARD_CONTRACTS C  ON V.CONTRACT_KEY=C.CONTRACT_KEY
	JOIN PAYROLLPERIODS PP
	  ON PP.STATE = CASE WHEN V.SYSTEM_CODE = ''8485'' THEN ''PA'' ELSE V.SYSTEM_CODE END
	WHERE COALESCE(V.CONFIRMED_FLAG,''YES'')=''YES'' --COALESCE(V.STATUS_CODE,''02'') IN (''02'', ''03'', ''04'', ''05'') 
	  AND last_day(V.SERVICE_DATE ,"WEEK") BETWEEN DATEADD(''YEAR'',-2,CURRENT_DATE)   AND PERIODEND
	  AND (INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE OR INCLUDE_FOR_OPS_PERF_CLIENTS = TRUE)
)
--SELECT COUNT (*) FROM VISIT_DATA;  --COUNTS = 15368351 (expected)
,visit_data_NEWCLIENT as
(
	     select V.CLIENT_KEY AS CLIENT_KEY,V.SYSTEM_CODE
		     , branch_key,SUPERVISOR_KEY
	     ,C.REVENUE_CATEGORY,	C.REVENUE_SUBCATEGORY_CODE,INCLUDE_FOR_EXEC_OPS_CLIENTS,INCLUDE_FOR_OPS_PERF_CLIENTS
	,min(service_date) as service_date
	     from 
	      INTEGRATION.FACT_VISIT_MERGED v
	     JOIN (select * from REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE OR INCLUDE_FOR_OPS_PERF_CLIENTS = TRUE)C ON V.CONTRACT_KEY=C.CONTRACT_KEY 
	        WHERE COALESCE(V.CONFIRMED_FLAG,''YES'')=''YES'' --COALESCE(V.STATUS_CODE,''02'') IN (''02'', ''03'', ''04'', ''05'') 
	  group by V.SYSTEM_CODE,V.CLIENT_KEY,branch_key,SUPERVISOR_KEY,C.REVENUE_SUBCATEGORY_CODE,INCLUDE_FOR_OPS_PERF_CLIENTS,INCLUDE_FOR_EXEC_OPS_CLIENTS,C.REVENUE_CATEGORY
)
--SELECT count (*) FROM VISIT_DATA_NEWCLIENT;
,FINAL AS (
SELECT 
			COALESCE(VISIT.CLIENT_KEY,A.CLIENT_KEY) AS CLIENT_KEY,
			COALESCE(VISIT.BRANCH_KEY,A.BRANCH_KEY) AS BRANCH_KEY,
			COALESCE(VISIT.SUPERVISOR_KEY,A.SUPERVISOR_KEY) AS SUPERVISOR_KEY,
			COALESCE(VISIT.REVENUE_CATEGORY,A.REVENUE_CATEGORY) AS REVENUE_CATEGORY
	,COALESCE(VISIT.REVENUE_SUBCATEGORY_CODE,A.REVENUE_SUBCATEGORY_CODE) AS REVENUE_SUBCATEGORY_CODE
		,	CASE WHEN VISIT.CLIENT_KEY IS NULL AND A.CLIENT_KEY IS NOT NULL THEN 1 ELSE 0 END AS TERMINATED_FLAG,
			CASE WHEN A.CLIENT_KEY IS NULL AND VISIT.CLIENT_KEY IS NOT NULL THEN 1 ELSE 0 END AS REACTIVATED_FLAG
			,0 as NEWCLIENT_FLAG,			0 AS REFERRAL_FLAG,
			COALESCE(VISIT.INCLUDE_FOR_EXEC_OPS_CLIENTS,A.INCLUDE_FOR_EXEC_OPS_CLIENTS) AS INCLUDE_FOR_EXEC_OPS_CLIENTS,
			COALESCE(VISIT.INCLUDE_FOR_OPS_PERF_CLIENTS,A.INCLUDE_FOR_OPS_PERF_CLIENTS) AS INCLUDE_FOR_OPS_PERF_CLIENTS,
			COALESCE(VISIT.SERVICE_DATE,A.NEXT_SERVICE_DATE) AS SERVICE_DATE,
			:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
			:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
			convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
					CURRENT_USER as ETL_INSERTED_BY ,
					convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
					CURRENT_USER as ETL_LAST_UPDATED_BY,
				0 as ETL_DELETED_FLAG
		FROM VISIT_DATA VISIT
			FULL OUTER JOIN 
			(SELECT V.* FROM VISIT_DATA V 
			 JOIN PAYROLLPERIODS PP ON PP.STATE = STATE_CODE
			 WHERE SERVICE_DATE <= DATEADD(''WEEK'',-1,PERIODEND)) A ON 
			      visit.branch_key = A.branch_key and VISIT.CLIENT_KEY=A.CLIENT_KEY AND VISIT.REVENUE_CATEGORY=A.REVENUE_CATEGORY 
			    AND VISIT.REVENUE_SUBCATEGORY_CODE=A.REVENUE_SUBCATEGORY_CODE 
			               AND VISIT.SERVICE_DATE=A.NEXT_SERVICE_DATE
			 WHERE TERMINATED_FLAG = 1 OR REACTIVATED_FLAG = 1 
-- ) SELECT count (*) FROM FINAL
UNION ALL   
			select 
			DISTINCT V.CLIENT_KEY,
		 	V.BRANCH_KEY,V.SUPERVISOR_KEY,V.REVENUE_CATEGORY,V.REVENUE_SUBCATEGORY_CODE
			,0 AS TERMINATED_FLAG,0 AS REACTIVATED_FLAG
, 1 as NEWCLIENT_FLAG,0 AS REFERRAL_FLAG,
			INCLUDE_FOR_EXEC_OPS_CLIENTS,INCLUDE_FOR_OPS_PERF_CLIENTS,last_day(SERVICE_DATE,"WEEK") AS SERVICE_DATE,
        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
 convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
					CURRENT_USER as ETL_INSERTED_BY ,
					convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
				CURRENT_USER as ETL_LAST_UPDATED_BY,
				0 as ETL_DELETED_FLAG
		from visit_data_NEWCLIENT v
			JOIN PAYROLLPERIODS PP  ON PP.STATE = CASE WHEN V.SYSTEM_CODE = ''8485'' THEN ''PA'' ELSE V.SYSTEM_CODE END 
			WHERE SERVICE_DATE BETWEEN DATEADD(''YEAR'',-2,CURRENT_DATE) AND PERIODEND
-- )SELECT count (DISTINCT client_key) FROM FINAL;
UNION ALL
Select DISTINCT cl.CLIENT_KEY,
 V.branch_key,SUPERVISOR_KEY,C.REVENUE_CATEGORY,C.REVENUE_SUBCATEGORY_CODE
,0 AS TERMINATED_FLAG,0 AS REACTIVATED_FLAG
,0 as NEWCLIENT_FLAG,1 AS REFERRAL_FLAG,INCLUDE_FOR_EXEC_OPS_CLIENTS,
INCLUDE_FOR_OPS_PERF_CLIENTS,
last_day(REFERRAL_DATE,"WEEK") AS SERVICE_DATE,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
CURRENT_USER as ETL_INSERTED_BY ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
CURRENT_USER as ETL_LAST_UPDATED_BY,		0 as ETL_DELETED_FLAG
     from INTEGRATION.FACT_VISIT_MERGED v
     JOIN (select * from REPORT.VW_DASHBOARD_CONTRACTS WHERE 
      INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE OR INCLUDE_FOR_OPS_PERF_CLIENTS = TRUE)C
        ON V.CONTRACT_KEY=C.CONTRACT_KEY
      JOIN PAYROLLPERIODS PP   ON PP.STATE = CASE WHEN V.SYSTEM_CODE = ''8485'' THEN ''PA'' ELSE V.SYSTEM_CODE END 
        INNER JOIN INTEGRATION.DIM_CLIENT_MERGED CL  ON CL.CLIENT_KEY = V.ORIGINAL_CLIENT_KEY
         WHERE COALESCE(V.CONFIRMED_FLAG,''YES'')=''YES'' --COALESCE(V.STATUS_CODE,''02'') IN (''02'', ''03'', ''04'', ''05'')
         AND REFERRAL_DATE BETWEEN DATEADD(''YEAR'',-2,CURRENT_DATE) AND PERIODEND
 )
SELECT F.CLIENT_KEY, F.BRANCH_KEY,C.SOURCE_SYSTEM_ID,C.ORIGINAL_SOURCE_SYSTEM_ID,F.SUPERVISOR_KEY ,
 F.REVENUE_CATEGORY,F.REVENUE_SUBCATEGORY_CODE,F.TERMINATED_FLAG,F.REACTIVATED_FLAG,F.NEWCLIENT_FLAG,F.REFERRAL_FLAG,F.INCLUDE_FOR_EXEC_OPS_CLIENTS,
 F.INCLUDE_FOR_OPS_PERF_CLIENTS,SERVICE_DATE,F.ETL_TASK_KEY, F.ETL_INSERTED_TASK_KEY,F.ETL_INSERTED_DATE,F.ETL_INSERTED_BY,F.ETL_UPDATED_DATE,F.ETL_LAST_UPDATED_BY,F.ETL_DELETED_FLAG
 FROM FINAL f
INNER JOIN INTEGRATION.DIM_CLIENT_MERGED C ON F.CLIENT_KEY = C.ORIGINAL_CLIENT_KEY;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';