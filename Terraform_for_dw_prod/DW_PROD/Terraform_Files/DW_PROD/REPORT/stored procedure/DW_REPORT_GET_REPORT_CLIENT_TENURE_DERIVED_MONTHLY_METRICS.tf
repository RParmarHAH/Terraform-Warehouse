resource "snowflake_procedure" "DW_REPORT_GET_REPORT_CLIENT_TENURE_DERIVED_MONTHLY_METRICS" {
	name ="GET_REPORT_CLIENT_TENURE_DERIVED_MONTHLY_METRICS"
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

--*****************************************************************************************************************************
-- NAME:  CLIENT_TENURE_DERIVED_MONTHLY_METRICS
--
-- PURPOSE: Creates client tenure derived monthly metrics for each client based on visit/service data
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------         		    				         
-- 09/14/23    Divesh Aneja          Initial development
-- 10/19/23    Sandesh Gosavi        Add BRANCH_KEY field
-- 11/29/23    Sandesh Gosavi        Made the changes in initial logic (compatible for DW 1.0 and DW 2.0) 
--*******************************************************************************************************************************

INSERT OVERWRITE INTO REPORT.CLIENT_TENURE_DERIVED_MONTHLY_METRICS 

WITH CONTRACTS_CLIENTS AS (
			SELECT C.CONTRACT_KEY,
				C.CONTRACT_CODE, 
				C.CONTRACT_NAME, 
				C.REVENUE_CATEGORY,
				INCLUDE_FOR_EXEC_OPS_CLIENTS AS INCLUDE_FOR_CLIENTS,
				INCLUDE_FOR_OPS_PERF_HOURS
			FROM REPORT.VW_DASHBOARD_CONTRACTS C
			WHERE INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE 
	)

,UTILIZATION_DATA AS ( 
--FOR THE SOURCE SYSTEMS WHICH ARE NOT MIGRATED TO DW 2.0
select DISTINCT v.VISIT_KEY ,v.CLIENT_KEY ,v.ORIGINAL_CLIENT_KEY ,v.REPORT_DATE ,v.BRANCH_KEY ,v.ORIGINAL_BRANCH_KEY ,v.SOURCE_SYSTEM_ID ,
v.ORIGINAL_SOURCE_SYSTEM_ID ,v.SYSTEM_CODE ,v.ORIGINAL_SYSTEM_CODE ,v.HOURS_SERVED 
FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_VISIT_MERGED v 
INNER JOIN CONTRACTS_CLIENTS CC ON CC.CONTRACT_KEY = v.CONTRACT_KEY
WHERE V.ORIGINAL_SOURCE_SYSTEM_ID NOT IN (4,7,17,13,9,3,19,8,16,1,2)
AND v.CONFIRMED_FLAG =''YES'' AND V.HOURS_SERVED > 0


UNION ALL 
--FOR THE SYSTEMS WHICH ARE MIGRATED TO DW 2.0 
select DISTINCT   v.VISIT_KEY ,v.CLIENT_KEY ,v.ORIGINAL_CLIENT_KEY ,v.REPORT_DATE ,v.BRANCH_KEY ,v.ORIGINAL_BRANCH_KEY ,v.SOURCE_SYSTEM_ID ,
v.ORIGINAL_SOURCE_SYSTEM_ID ,v.SYSTEM_CODE ,v.ORIGINAL_SYSTEM_CODE ,v.HOURS_SERVED 
FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_VISIT_MERGED v 
LEFT JOIN HAH.FACT_PARTNER_CONTRACT_SERVICE PCS ON PCS.PARTNER_CONTRACT_SERVICE_KEY = V.PARTNER_CONTRACT_SERVICE_KEY
LEFT JOIN HAH.DIM_SERVICES S ON S.SERVICE_KEY = PCS.SERVICE_KEY 
WHERE V.ORIGINAL_SOURCE_SYSTEM_ID IN (4,7,17,13,9,3,19,8,16,1,2)   AND v.CONFIRMED_FLAG =''YES'' AND V.HOURS_SERVED > 0
AND S.REVENUE_CATEGORY NOT IN (''CLS'',''NA'',''CC'') AND PCS.BILLABLE_FLAG = TRUE
      ),

FINAL_DATA AS (     
select DISTINCT v.CLIENT_KEY as client_key
                ,dd.FIRST_DAY_OF_MONTH AS service_month
--               ,FIRST_VALUE(V.BRANCH_KEY) OVER (PARTITION BY V.CLIENT_KEY,service_month
--                ORDER BY V.SERVICE_DATE  DESC ,V.SCHEDULE_TIMEIN DESC) AS BRANCH_KEY
                ,FIRST_VALUE(V.BRANCH_KEY) OVER(PARTITION BY service_month, 
                 V.CLIENT_KEY ORDER BY MAX(V.REPORT_DATE) DESC,NVL(SUM(V.HOURS_SERVED), 0) DESC) AS BRANCH_KEY
               ,min(v.report_date) OVER(PARTITION BY v.CLIENT_KEY) AS first_service_date
               ,max(v.report_date) OVER(PARTITION BY v.CLIENT_KEY,service_month) AS latest_service_date
               ,CLIENT.CLIENT_DOB AS client_DOB
               ,DATEDIFF(''YEAR'',client_DOB,service_month)||'' Years'' AS client_age_as_of_service_month
                 ---- ETL FIELDS ---
               ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
               ,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
               ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
               ,CURRENT_USER as ETL_INSERTED_BY 
               ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
               ,CURRENT_USER as ETL_LAST_UPDATED_BY   
FROM UTILIZATION_DATA v
JOIN DW_${var.SF_ENVIRONMENT}.hah.DIM_DATE dd 
  ON   v.REPORT_DATE = dd.calendar_date
JOIN INTEGRATION.DIM_CLIENT_MERGED CLIENT
  ON CLIENT.ORIGINAL_CLIENT_KEY = V.CLIENT_KEY
JOIN INTEGRATION.DIM_BRANCH_MERGED BRANCH
  ON BRANCH.ORIGINAL_BRANCH_KEY = V.BRANCH_KEY 
WHERE DATE_TRUNC(''MONTH'',V.REPORT_DATE) <= DATEADD( ''MONTH'', 2, CURRENT_DATE)
GROUP BY service_month,V.CLIENT_KEY, v.BRANCH_KEY,V.REPORT_DATE,client_DOB

)

SELECT client_key
       ,service_month
       ,BRANCH_KEY
       ,first_service_date
       ,latest_service_date
       ,DATEDIFF(month,first_service_date,latest_service_date)+1 AS tenure_of_service_months
       ,client_DOB
       ,client_age_as_of_service_month
       ,ETL_TASK_KEY
       ,ETL_INSERTED_TASK_KEY
       ,ETL_INSERTED_DATE
       ,ETL_INSERTED_BY
       ,ETL_LAST_UPDATED_DATE
       ,ETL_LAST_UPDATED_BY
FROM FINAL_DATA ;  

SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

