resource "snowflake_procedure" "DW_REPORT_GET_REPORT_OVERTIME_2" {
	name ="GET_REPORT_OVERTIME_2"
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

    INSERT OVERWRITE INTO REPORT.OVERTIME_2
WITH master_emp AS (
    SELECT coalesce(M.employee_key,otr.EMPLOYEE_KEY) AS otr_employee_key,M.original_SOURCE_SYSTEM_ID,M.SYSTEM_CODE,gp.*
    FROM INTEGRATION.DIM_EMPLOYEE_MERGED gp
    LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED otr ON gp.original_EMPLOYEE_PID = otr.original_EMPLOYEE_PID AND otr.SOURCE_SYSTEM_ID <> 5
    LEFT join INTEGRATION.DIM_EMPLOYEE_MERGED M on otr.EMPLOYEE_KEY=M.original_EMPLOYEE_KEY
    WHERE gp.SOURCE_SYSTEM_ID = 5 AND UPPER(gp.EMPLOYEE_CATEGORY) = ''FIELD''
    )
SELECT DISTINCT
      emp.EMPLOYEE_KEY
     , emp.EMPLOYEE_ID
     , emp.PRIMARY_BRANCH_KEY
     , pay.PAYROLL_DATE
     , pay.PAY_HOURS as payroll_hours
     , div0(pay.SERVICE_HOURS , (SUM(vis.HOURS_SERVED) OVER (PARTITION BY emp.EMPLOYEE_KEY,CHECK_NUMBER,pay.PAYROLL_DATE,pay.PAY_PERIOD_START_DATE,pay.PAY_PERIOD_END_DATE)))* (SUM(vis.HOURS_SERVED)  
       OVER (PARTITION BY vis.SUPERVISOR_KEY, vis.CLIENT_KEY, vis.BRANCH_KEY, vis.CONTRACT_KEY,CHECK_NUMBER,date_trunc(''month'', vis.SERVICE_DATE))) as payroll_service_hours
     , pay.OVERTIME_HOURS as payroll_overtime_hours
     , pay.NON_SERVICE_UNITS as payroll_non_service_units
     , pay.PAY_RATE
     , pay.PAY_PERIOD_START_DATE
     , pay.PAY_PERIOD_END_DATE
     , pay.CHECK_NUMBER
     , vis.SUPERVISOR_KEY
     , vis.CLIENT_KEY
     , vis.CONTRACT_KEY
     , date_trunc(''month'', vis.SERVICE_DATE) as service_month
     , SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY, vis.CLIENT_KEY
         , vis.BRANCH_KEY, vis.CONTRACT_KEY, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)) AS hours_served
     , IFF(pay.SERVICE_HOURS > 0, (SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY
            , vis.CLIENT_KEY, vis.BRANCH_KEY, vis.CONTRACT_KEY, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)
         )) / pay.SERVICE_HOURS , 0) as overtime_ratio
     , IFF(pay.SERVICE_HOURS > 0, (SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY
            , vis.CLIENT_KEY, vis.BRANCH_KEY, vis.CONTRACT_KEY, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)
         )) / pay.SERVICE_HOURS * pay.OVERTIME_HOURS, 0) as overtime_hours
    , pay.OVERTIME_PAY_AMOUNT AS PAYROLL_OVERTIME_PAY_AMOUNT
    , IFF(pay.SERVICE_HOURS > 0, (SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY
           , vis.CLIENT_KEY, vis.BRANCH_KEY, vis.CONTRACT_KEY, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)
         )) / pay.SERVICE_HOURS * pay.OVERTIME_PAY_AMOUNT, 0) as overtime_pay_amount
    , emp.otr_employee_key
    ,vis.BRANCH_KEY
	,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	   CURRENT_USER as ETL_INSERTED_BY ,
	   convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	   CURRENT_USER as ETL_LAST_UPDATED_BY,
	   0 as ETL_DELETED_FLAG
FROM master_emp emp
 JOIN INTEGRATION.FACT_PAYROLL_MERGED pay ON emp.EMPLOYEE_KEY = pay.EMPLOYEE_KEY
 JOIN INTEGRATION.FACT_VISIT_MERGED vis ON emp.otr_employee_key = vis.EMPLOYEE_KEY
    AND vis.SERVICE_DATE >= pay.PAY_PERIOD_START_DATE
    AND vis.SERVICE_DATE <= pay.PAY_PERIOD_END_DATE
 JOIN HAH.DIM_CONTRACT ctrct ON ctrct.Contract_Key = vis.Contract_Key
UNION ALL --OPENSYSTEMS AND OSHAH EMPLOYEE
(
	WITH OPAL_EMPLOYEE AS (
	    SELECT DISTINCT COALESCE(MAIN.EMPLOYEE_KEY,AMS.EMPLOYEE_KEY) AS AMS_EMPLOYEE_KEY
	          ,MAIN.ORIGINAL_SOURCE_SYSTEM_ID
	          ,MAIN.SYSTEM_CODE,PAYROLL.*
	    FROM INTEGRATION.DIM_EMPLOYEE_MERGED PAYROLL
	    LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AMS ON PAYROLL.ORIGINAL_EMPLOYEE_PID = AMS.ORIGINAL_EMPLOYEE_PID AND AMS.SYSTEM_CODE ILIKE ANY(''OPEN%'',''OSHAH%'')
	    LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED MAIN on AMS.EMPLOYEE_KEY = MAIN.ORIGINAL_EMPLOYEE_KEY
	    WHERE PAYROLL.SOURCE_SYSTEM_ID = 18 AND UPPER(PAYROLL.EMPLOYEE_CATEGORY) = ''FIELD''
	)
	SELECT DISTINCT
	       EMP.EMPLOYEE_KEY
	     , EMP.EMPLOYEE_ID
	     , EMP.PRIMARY_BRANCH_KEY
	     , PAY.PAYROLL_DATE
	     , PAY.PAY_HOURS AS PAYROLL_HOURS
	     , DIV0(PAY.SERVICE_HOURS , (SUM(VIS.HOURS_SERVED) OVER (PARTITION BY EMP.EMPLOYEE_KEY,CHECK_NUMBER,PAY.PAYROLL_DATE,PAY.PAY_PERIOD_START_DATE,PAY.PAY_PERIOD_END_DATE)))* (SUM(VIS.HOURS_SERVED)  
	       OVER (PARTITION BY VIS.SUPERVISOR_KEY, VIS.CLIENT_KEY, VIS.BRANCH_KEY, VIS.CONTRACT_KEY,CHECK_NUMBER,DATE_TRUNC(''MONTH'', VIS.SERVICE_DATE))) AS PAYROLL_SERVICE_HOURS
	     , PAY.OVERTIME_HOURS AS PAYROLL_OVERTIME_HOURS
	     , PAY.NON_SERVICE_UNITS AS PAYROLL_NON_SERVICE_UNITS
	     , PAY.PAY_RATE
	     , PAY.PAY_PERIOD_START_DATE
	     , PAY.PAY_PERIOD_END_DATE
	     , PAY.CHECK_NUMBER
	     , VIS.SUPERVISOR_KEY
	     , VIS.CLIENT_KEY
	     , VIS.CONTRACT_KEY
	     , DATE_TRUNC(''MONTH'', VIS.SERVICE_DATE) AS SERVICE_MONTH
	     , SUM(VIS.HOURS_SERVED) OVER (PARTITION BY VIS.SUPERVISOR_KEY, VIS.CLIENT_KEY
	         , VIS.BRANCH_KEY, VIS.CONTRACT_KEY, CHECK_NUMBER, DATE_TRUNC(''MONTH'', VIS.SERVICE_DATE)) AS HOURS_SERVED
	     , IFF(PAY.SERVICE_HOURS > 0, (SUM(VIS.HOURS_SERVED) OVER (PARTITION BY VIS.SUPERVISOR_KEY
	            , VIS.CLIENT_KEY, VIS.BRANCH_KEY, VIS.CONTRACT_KEY, CHECK_NUMBER, DATE_TRUNC(''MONTH'', VIS.SERVICE_DATE)
	         )) / PAY.SERVICE_HOURS , 0) AS OVERTIME_RATIO
	     , IFF(PAY.SERVICE_HOURS > 0, (SUM(VIS.HOURS_SERVED) OVER (PARTITION BY VIS.SUPERVISOR_KEY
	            , VIS.CLIENT_KEY, VIS.BRANCH_KEY, VIS.CONTRACT_KEY, CHECK_NUMBER, DATE_TRUNC(''MONTH'', VIS.SERVICE_DATE)
	         )) / PAY.SERVICE_HOURS * PAY.OVERTIME_HOURS, 0) AS OVERTIME_HOURS
	    , PAY.OVERTIME_PAY_AMOUNT AS PAYROLL_OVERTIME_PAY_AMOUNT
	    , IFF(PAY.SERVICE_HOURS > 0, (SUM(VIS.HOURS_SERVED) OVER (PARTITION BY VIS.SUPERVISOR_KEY
	           , VIS.CLIENT_KEY, VIS.BRANCH_KEY, VIS.CONTRACT_KEY, CHECK_NUMBER, DATE_TRUNC(''MONTH'', VIS.SERVICE_DATE)
	         )) / PAY.SERVICE_HOURS * PAY.OVERTIME_PAY_AMOUNT, 0) AS OVERTIME_PAY_AMOUNT
	    , EMP.AMS_EMPLOYEE_KEY AS OTR_EMPLOYEE_KEY
	    , VIS.BRANCH_KEY,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	    , CURRENT_USER AS ETL_INSERTED_BY 
	    , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE
	    , CURRENT_USER AS ETL_LAST_UPDATED_BY
	    , 0 AS ETL_DELETED_FLAG
	FROM OPAL_EMPLOYEE EMP
	JOIN INTEGRATION.FACT_PAYROLL_MERGED PAY ON EMP.EMPLOYEE_KEY = PAY.EMPLOYEE_KEY
	JOIN INTEGRATION.FACT_VISIT_MERGED VIS ON EMP.AMS_EMPLOYEE_KEY = VIS.EMPLOYEE_KEY
	     AND VIS.SERVICE_DATE >= PAY.PAY_PERIOD_START_DATE
	     AND VIS.SERVICE_DATE <= PAY.PAY_PERIOD_END_DATE
	JOIN HAH.DIM_CONTRACT CTRCT ON CTRCT.CONTRACT_KEY = VIS.CONTRACT_KEY
)
UNION ALL
 (
 WITH EMPLOYEE AS (
 SELECT
   EMPLOYEE_KEY,
   EMPLOYEE_ID,
   PRIMARY_BRANCH_KEY
   FROM INTEGRATION.DIM_EMPLOYEE_MERGED WHERE SOURCE_SYSTEM_ID=6
   AND SYSTEM_CODE = ''EXCEL''
 )
,VISITS AS (
      SELECT DISTINCT
      V.CLIENT_KEY,
      E.EMPLOYEE_KEY,
      E.EMPLOYEE_ID,
      SERVICE_DATE,
      PAYROLL_DATE,
      SUM(HOURS_SERVED) AS HOURS_SERVED,
      BRANCH_KEY,
      CONTRACT_KEY,
      SUPERVISOR_KEY
      FROM INTEGRATION.FACT_VISIT_MERGED V
      JOIN HAH.DIM_EMPLOYEE E
      	ON E.SYSTEM_CODE = CASE V.SYSTEM_CODE WHEN ''8485'' THEN ''EXCEL'' END
      		AND COALESCE(TRY_CAST(E.EMPLOYEE_ID AS INT)::STRING, TRIM(E.EMPLOYEE_ID)) = COALESCE(TRY_CAST(V.EMPLOYEE_ID AS INT)::STRING, TRIM(V.EMPLOYEE_ID))
      WHERE V.CONFIRMED_FLAG = ''YES'' --V.STATUS_CODE IN (''02'',''03'',''04'',''05'')
      	AND V.SOURCE_SYSTEM_ID = 4
      GROUP BY CLIENT_KEY,E.EMPLOYEE_ID,E.EMPLOYEE_KEY,SERVICE_DATE,PAYROLL_DATE,BRANCH_KEY,SUPERVISOR_KEY,CONTRACT_KEY)
    ,PAYROLL AS (
      SELECT
      P.EMPLOYEE_KEY,
      P.EMPLOYEE_ID,
      PAYROLL_DATE,
      SUM(ABS(PAY_HOURS)) AS PAY_HOURS,
      SUM(ABS(SERVICE_HOURS)) AS SERVICE_HOURS,
      SUM(OVERTIME_HOURS) AS OVERTIME_HOURS,
      SUM(OVERTIME_PAY_AMOUNT) AS OVERTIME_PAY_AMOUNT,
      BRANCH_KEY
      FROM INTEGRATION.FACT_PAYROLL_MERGED P
      WHERE P.original_SOURCE_SYSTEM_ID=6
      GROUP BY P.EMPLOYEE_KEY,P.EMPLOYEE_ID,PAYROLL_DATE,BRANCH_KEY
    )
    SELECT DISTINCT
    E.EMPLOYEE_KEY,
    E.EMPLOYEE_ID,
    E.PRIMARY_BRANCH_KEY,
    P.PAYROLL_DATE,
    CASE WHEN P.PAY_HOURS>0 AND V.HOURS_SERVED>0 THEN (P.PAY_HOURS * (V.HOURS_SERVED) / SUM(V.HOURS_SERVED)
        OVER (PARTITION BY V.EMPLOYEE_KEY,V.PAYROLL_DATE,V.BRANCH_KEY,V.SUPERVISOR_KEY,V.CONTRACT_KEY))
    ELSE NULL END AS PAYROLL_HOURS,
    CASE WHEN P.SERVICE_HOURS>0 AND V.HOURS_SERVED>0 THEN (P.SERVICE_HOURS * (V.HOURS_SERVED) / SUM(V.HOURS_SERVED)
        OVER (PARTITION BY V.EMPLOYEE_KEY,V.PAYROLL_DATE,V.BRANCH_KEY,V.SUPERVISOR_KEY,V.CONTRACT_KEY))
    ELSE NULL END AS PAYROLL_SERVICE_HOURS,
    NULL AS PAYROLL_OVERTIME_HOURS,
    NULL AS PAYROLL_NON_SERVICE_UNITS,
    NULL AS PAY_RATE,
    NULL AS PAY_PERIOD_START_DATE,
    NULL AS PAY_PERIOD_END_DATE,
    NULL AS CHECK_NUMBER,
    V.SUPERVISOR_KEY,
    V.CLIENT_KEY,
    V.CONTRACT_KEY,
    V.SERVICE_DATE AS SERVICE_MONTH,
    IFF(P.SERVICE_HOURS>0,V.HOURS_SERVED,0) AS HOURS_SERVED,
    NULL AS OVERTIME_RATIO,
    CASE WHEN P.SERVICE_HOURS>0 AND V.HOURS_SERVED>0 THEN (P.OVERTIME_HOURS * (V.HOURS_SERVED) / SUM(V.HOURS_SERVED)
        OVER (PARTITION BY V.EMPLOYEE_KEY,V.PAYROLL_DATE,V.BRANCH_KEY,V.SUPERVISOR_KEY,V.CONTRACT_KEY))
    ELSE NULL END AS OVERTIME_HOURS,
    CASE WHEN P.OVERTIME_PAY_AMOUNT>0 AND P.PAY_HOURS>0 THEN (P.OVERTIME_PAY_AMOUNT * (P.PAY_HOURS) / SUM(P.PAY_HOURS)
    OVER (PARTITION BY V.EMPLOYEE_KEY,V.PAYROLL_DATE,V.BRANCH_KEY,V.SUPERVISOR_KEY,V.CONTRACT_KEY))
    ELSE NULL END AS PAYROLL_OVERTIME_PAY_AMOUNT,
    NULL AS OVERTIME_PAY_AMOUNT,
    NULL AS OTR_EMPLOYEE_KEY,
    V.BRANCH_KEY AS BRANCH_KEY
    ,-1 AS ETL_TASK_KEY
    ,-1 AS ETL_INSERTED_TASK_KEY
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
    ,CURRENT_USER as ETL_INSERTED_BY
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE
    ,CURRENT_USER as ETL_LAST_UPDATED_BY
    ,0 as ETL_DELETED_FLAG
    FROM EMPLOYEE E
    JOIN PAYROLL P ON E.EMPLOYEE_KEY=P.EMPLOYEE_KEY
    LEFT JOIN VISITS V ON V.EMPLOYEE_KEY=P.EMPLOYEE_KEY
        AND V.PAYROLL_DATE=P.PAYROLL_DATE
)
UNION ALL
(
WITH EMPLOYEE AS (
	SELECT EMPLOYEE_KEY
			, EMPLOYEE_ID
			, PRIMARY_BRANCH_KEY
	FROM INTEGRATION.DIM_EMPLOYEE_MERGED 
	WHERE SOURCE_SYSTEM_ID = 17
			AND SYSTEM_CODE = ''PREFERRED''
), PREFERRED_OVERTIME AS
(
SELECT DISTINCT E.EMPLOYEE_KEY
				, E.EMPLOYEE_ID
				, E.PRIMARY_BRANCH_KEY
				, P.PAYROLL_DATE
				, P.PAY_HOURS AS PAYROLL_HOURS
				, SUM(V.HOURS_SERVED) OVER (PARTITION BY E.EMPLOYEE_KEY, P.CHECK_NUMBER, P.PAYROLL_DATE
											, P.PAY_PERIOD_START_DATE, P.PAY_PERIOD_END_DATE) AS HOURS_SERVED_BY_PAYROLL_DATE
				, SUM(V.HOURS_SERVED) OVER (PARTITION BY V.SUPERVISOR_KEY, V.CLIENT_KEY, V.BRANCH_KEY, V.CONTRACT_KEY
											, P.CHECK_NUMBER, DATE_TRUNC(''MONTH'', V.SERVICE_DATE)) AS HOURS_SERVED_BY_MONTH
				, CASE WHEN HOURS_SERVED_BY_MONTH > 0
							THEN (P.SERVICE_HOURS / HOURS_SERVED_BY_PAYROLL_DATE * HOURS_SERVED_BY_MONTH)
				  END AS PAYROLL_SERVICE_HOURS
				, P.OVERTIME_HOURS AS PAYROLL_OVERTIME_HOURS
				, P.NON_SERVICE_UNITS AS PAYROLL_NON_SERVICE_UNITS
				, P.PAY_RATE AS PAY_RATE
				, P.PAY_PERIOD_START_DATE AS PAY_PERIOD_START_DATE
				, P.PAY_PERIOD_END_DATE AS PAY_PERIOD_END_DATE
				, P.CHECK_NUMBER AS CHECK_NUMBER
				, V.SUPERVISOR_KEY
				, V.CLIENT_KEY
				, V.CONTRACT_KEY
				, DATE_TRUNC(''MONTH'', V.SERVICE_DATE) AS SERVICE_MONTH
				, HOURS_SERVED_BY_MONTH AS HOURS_SERVED
			  	, CASE WHEN P.SERVICE_HOURS > 0 
			  				THEN HOURS_SERVED_BY_MONTH / P.SERVICE_HOURS
			  	  END AS OVERTIME_RATIO
				, CASE WHEN P.SERVICE_HOURS > 0 
							THEN HOURS_SERVED_BY_MONTH / P.SERVICE_HOURS * P.OVERTIME_HOURS 
				  END AS OVERTIME_HOURS
			  	, P.OVERTIME_PAY_AMOUNT AS PAYROLL_OVERTIME_PAY_AMOUNT
			  	, CASE WHEN P.SERVICE_HOURS > 0
			  				THEN HOURS_SERVED_BY_MONTH / P.SERVICE_HOURS * P.OVERTIME_PAY_AMOUNT
			  	  END AS OVERTIME_PAY_AMOUNT
			  	, V.BRANCH_KEY AS BRANCH_KEY,
        		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
				:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
			  	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
			  	, CURRENT_USER AS ETL_INSERTED_BY
			  	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE
			  	, CURRENT_USER AS ETL_LAST_UPDATED_BY
			  	, 0 AS ETL_DELETED_FLAG
FROM EMPLOYEE E
INNER JOIN INTEGRATION.FACT_PAYROLL_MERGED P ON E.EMPLOYEE_KEY = P.EMPLOYEE_KEY
INNER JOIN INTEGRATION.FACT_VISIT_MERGED V ON E.EMPLOYEE_KEY = V.EMPLOYEE_KEY
    		AND V.SERVICE_DATE >= P.PAY_PERIOD_START_DATE
    		AND V.SERVICE_DATE <= P.PAY_PERIOD_END_DATE
INNER JOIN HAH.DIM_CONTRACT C ON C.CONTRACT_KEY = V.CONTRACT_KEY
)
SELECT EMPLOYEE_KEY 
		, EMPLOYEE_ID 
		, PRIMARY_BRANCH_KEY 
		, PAYROLL_DATE
		, PAYROLL_HOURS
		, PAYROLL_SERVICE_HOURS
		, PAYROLL_OVERTIME_HOURS
		, PAYROLL_NON_SERVICE_UNITS
		, PAY_RATE 
		, PAY_PERIOD_START_DATE
		, PAY_PERIOD_END_DATE
		, CHECK_NUMBER
		, SUPERVISOR_KEY
		, CLIENT_KEY
		, CONTRACT_KEY
		, SERVICE_MONTH
		, HOURS_SERVED
		, OVERTIME_RATIO
		, OVERTIME_HOURS
		, PAYROLL_OVERTIME_PAY_AMOUNT
		, OVERTIME_PAY_AMOUNT
		, EMPLOYEE_KEY AS OTR_EMPLOYEE_KEY
		, BRANCH_KEY
		, ETL_TASK_KEY 
		, ETL_INSERTED_TASK_KEY 
		, ETL_INSERTED_DATE
		, ETL_INSERTED_BY 
		, ETL_UPDATED_DATE
		, ETL_LAST_UPDATED_BY 
		, ETL_DELETED_FLAG 
FROM PREFERRED_OVERTIME
);

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

