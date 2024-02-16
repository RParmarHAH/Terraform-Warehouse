resource "snowflake_procedure" "DW_REPORT_GET_REPORT_CLIENTS_TERMED" {
	name ="GET_REPORT_CLIENTS_TERMED"
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

        INSERT OVERWRITE INTO REPORT.CLIENTS_TERMED 
	(PERIOD_BEGIN_DATE, CLIENT_KEY, ORIGINAL_CLIENT_KEY, CONTRACT_KEY, CURRENT_BRANCH_KEY, ORIGINAL_CURRENT_BRANCH_KEY, CURRENT_SUPERVISOR_KEY, LAST_SERVICE_DATE_INPERIOD, HOURS_SERVED_LAST_PERIOD,
		ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG)
WITH VISITS AS (
	SELECT DISTINCT DATE_TRUNC(MONTH, VISIT.REPORT_DATE) PERIOD_BEGIN_DATE, -- Using all visits (not DATES CTE) to get accurate Reactivation count 
		VISIT.CLIENT_KEY, 
		FIRST_VALUE(VISIT.ORIGINAL_CLIENT_KEY) OVER(PARTITION BY VISIT.CLIENT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 0 ELSE 1 END) AS ORIGINAL_CLIENT_KEY,
		VISIT.CONTRACT_KEY,
		MAX(MAX(VISIT.REPORT_DATE)) OVER(PARTITION BY VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY, DATE_TRUNC(MONTH, VISIT.REPORT_DATE)) LAST_SERVICE_DATE_INPERIOD,
		FIRST_VALUE(VISIT.BRANCH_KEY) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY ORDER BY MAX(VISIT.REPORT_DATE) DESC, SUM(VISIT.HOURS_SERVED) DESC) CURRENT_BRANCH_KEY,
		FIRST_VALUE(VISIT.ORIGINAL_BRANCH_KEY) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY ORDER BY CASE WHEN VISIT.CLIENT_KEY = VISIT.ORIGINAL_CLIENT_KEY THEN 0 ELSE 1 END, MAX(VISIT.REPORT_DATE) DESC, SUM(VISIT.HOURS_SERVED) DESC) ORIGINAL_CURRENT_BRANCH_KEY,
		FIRST_VALUE(VISIT.SUPERVISOR_KEY) OVER(PARTITION BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY ORDER BY MAX(VISIT.REPORT_DATE) DESC, SUM(VISIT.HOURS_SERVED) DESC) CURRENT_SUPERVISOR_KEY,
		SUM(SUM(VISIT.HOURS_SERVED)) OVER(PARTITION BY VISIT.CLIENT_KEY, VISIT.CONTRACT_KEY, DATE_TRUNC(MONTH, VISIT.REPORT_DATE)) HOURS_SERVED
	FROM INTEGRATION.FACT_VISIT_MERGED VISIT
	WHERE VISIT.CONFIRMED_FLAG = ''YES'' --VISIT.STATUS_CODE IN (''02'', ''03'', ''04'', ''05'') -- Only confirmed visits
	GROUP BY DATE_TRUNC(MONTH, VISIT.REPORT_DATE), 
		VISIT.CLIENT_KEY, 
		VISIT.ORIGINAL_CLIENT_KEY,
		VISIT.CONTRACT_KEY,
		VISIT.BRANCH_KEY,
		VISIT.ORIGINAL_BRANCH_KEY,
		VISIT.SUPERVISOR_KEY 
), CLIENTS_TERMED_BY_PERIOD AS (
	SELECT DATEADD(MONTH, 1, VISITS_CURRENT_PERIOD.PERIOD_BEGIN_DATE) AS PERIOD_BEGIN_DATE,
		VISITS_CURRENT_PERIOD.CLIENT_KEY,
		VISITS_CURRENT_PERIOD.ORIGINAL_CLIENT_KEY,
		VISITS_CURRENT_PERIOD.CONTRACT_KEY,
		VISITS_CURRENT_PERIOD.CURRENT_BRANCH_KEY,
		VISITS_CURRENT_PERIOD.ORIGINAL_CURRENT_BRANCH_KEY,
		VISITS_CURRENT_PERIOD.CURRENT_SUPERVISOR_KEY,
		VISITS_CURRENT_PERIOD.LAST_SERVICE_DATE_INPERIOD,
		VISITS_CURRENT_PERIOD.HOURS_SERVED AS HOURS_SERVED_LAST_PERIOD
	FROM VISITS VISITS_CURRENT_PERIOD
	LEFT JOIN VISITS VISITS_NEXT_PERIOD
		ON VISITS_NEXT_PERIOD.PERIOD_BEGIN_DATE = DATEADD(MONTH, 1, VISITS_CURRENT_PERIOD.PERIOD_BEGIN_DATE)	
			AND VISITS_NEXT_PERIOD.CLIENT_KEY = VISITS_CURRENT_PERIOD.CLIENT_KEY
			AND VISITS_NEXT_PERIOD.CONTRACT_KEY = VISITS_CURRENT_PERIOD.CONTRACT_KEY
	WHERE VISITS_NEXT_PERIOD.CLIENT_KEY IS NULL 
		AND VISITS_CURRENT_PERIOD.PERIOD_BEGIN_DATE < DATE_TRUNC(MONTH, CURRENT_DATE)
)
	SELECT RESULTS.PERIOD_BEGIN_DATE, 
		RESULTS.CLIENT_KEY, 
		RESULTS.ORIGINAL_CLIENT_KEY,
		RESULTS.CONTRACT_KEY, 
		RESULTS.CURRENT_BRANCH_KEY, 
		RESULTS.ORIGINAL_CURRENT_BRANCH_KEY,
		RESULTS.CURRENT_SUPERVISOR_KEY,
		RESULTS.LAST_SERVICE_DATE_INPERIOD, 
		RESULTS.HOURS_SERVED_LAST_PERIOD,
		--- ETL Fields
        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	FROM CLIENTS_TERMED_BY_PERIOD RESULTS;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

