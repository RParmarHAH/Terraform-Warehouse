resource "snowflake_procedure" "DW_REPORT_GET_REPORT_SCHEDULE_METRICS_WEEKLY_BKCP_0525" {
	name ="GET_REPORT_SCHEDULE_METRICS_WEEKLY_BKCP_0525"
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
-- NAME:  SCHEDULE_METRICS_WEEKLY
--
-- PURPOSE: Creates derived weekly metrics for each Employee, Client, Branch, Contract and Week based on visit/service data
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 11/15/22    Rajat Sapkal          Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO REPORT.SCHEDULE_METRICS_WEEKLY_BKCP_0525
	(PAYROLL_DATE, PAY_PERIOD_START_DATE, PAY_PERIOD_END_DATE, SERVICE_WEEK, CLIENT_KEY, CONTRACT_KEY, ORIGINAL_SOURCE_SYSTEM_ID, SOURCE_SYSTEM_ID, BRANCH_KEY, SUPERVISOR_KEY, EMPLOYEE_KEY, HOURS_SERVED, 
	 HOURS_IN_REVIEW, FUTURE_HOURS, FUTURE_CANCELLED_HOURS, FUTURE_HOLD_HOURS, HOURS_MISSED, HOURS_CANCELLED, HOURS_RESCHEDULED, HOURS_SCHEDULED, VISITS_IN_REVIEW, 
	 FUTURE_VISITS, FUTURE_CANCELLED_VISITS, FUTURE_HOLD_VISITS, VISITS_MISSED, VISITS_COMPLETED, VISITS_CANCELLED, VISITS_RESCHEDULED, VISITS_SCHEDULED, 
	CLIENT_SERVED_FLAG, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG)
	--
	WITH METRICS AS (
	SELECT
		COALESCE(P.CHECK_DATE,PAYROLL_NEXTCHECKDATE.CHECK_DATE) AS PAYROLL_DATE,
		COALESCE(P.PERIOD_START_DATE,PAYROLL_NEXTCHECKDATE.PERIOD_START_DATE) AS PAY_PERIOD_START_DATE,
        COALESCE(P.PERIOD_END_DATE,PAYROLL_NEXTCHECKDATE.PERIOD_END_DATE) AS PAY_PERIOD_END_DATE,
		DD.HAH_CURRENT_WEEK_FIRST_DAY AS SERVICE_WEEK,
        VISIT.CLIENT_KEY,
        VISIT.CONTRACT_KEY,
        VISIT.ORIGINAL_SOURCE_SYSTEM_ID,
        VISIT.SOURCE_SYSTEM_ID,
		VISIT.BRANCH_KEY,
		VISIT.SUPERVISOR_KEY,
		VISIT.EMPLOYEE_KEY ,
		NVL(SUM(iff(VISIT.CONFIRMED_FLAG = ''YES'',VISIT.HOURS_SERVED,0)),0) 
			AS HOURS_SERVED,
		NVL(SUM(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
						AND (VISIT.SERVICE_DATE <= CURRENT_DATE() AND VISIT.VISIT_STATUS_NAME = ''In Review'')
						,VISIT.SCHEDULE_DURATION,0)),0)   
			AS HOURS_IN_REVIEW,		
		NVL(SUM(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'')
                        AND (VISIT.VISIT_STATUS_NAME = ''Future'' OR
                                        (VISIT.SERVICE_DATE > CURRENT_DATE() AND NVL(VISIT.SCHEDULE_STATUS_NAME,''0'') NOT IN (''Hold'',''Cancelled'') AND NVL(VISIT.VISIT_STATUS_NAME,''0'') <> ''Did not happen''))
										,VISIT.SCHEDULE_DURATION,0)),0)
			AS FUTURE_HOURS,
		NVL(SUM(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') AND VISIT.SERVICE_DATE > CURRENT_DATE()
                    	AND (VISIT.VISIT_STATUS_NAME = ''Did not happen'' OR VISIT.SCHEDULE_STATUS_NAME in (''Cancelled''))
						,VISIT.SCHEDULE_DURATION,0)),0)    
			AS FUTURE_CANCELLED_HOURS,
		NVL(SUM(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') AND VISIT.SERVICE_DATE > CURRENT_DATE() AND VISIT.SCHEDULE_STATUS_NAME in (''Hold'')
						,VISIT.SCHEDULE_DURATION,0)),0)    
			AS FUTURE_HOLD_HOURS,
		NVL(SUM(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
						AND (VISIT.SERVICE_DATE <= CURRENT_DATE() AND NVL(VISIT.SCHEDULE_STATUS_NAME,''0'') <> ''Hold'' AND VISIT.VISIT_STATUS_NAME IS NULL)
						,VISIT.SCHEDULE_DURATION,0)),0)   
			AS HOURS_MISSED,
		NVL(SUM(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
        			AND VISIT.SERVICE_DATE <= CURRENT_DATE() AND (VISIT.VISIT_STATUS_NAME = ''Did not happen'' OR VISIT.SCHEDULE_STATUS_NAME in (''Hold'',''Cancelled''))
						,VISIT.SCHEDULE_DURATION,0)),0)   
			AS HOURS_CANCELLED,
        NVL(SUM(iff(VISIT.SCHEDULE_STATUS_NAME = ''Rescheduled'',VISIT.SCHEDULE_DURATION,0)),0)   
        	AS HOURS_RESCHEDULED,
      	NVL(SUM(VISIT.SCHEDULE_DURATION), 0)   
      		AS HOURS_SCHEDULED,
		COUNT(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
						AND (VISIT.SERVICE_DATE <= CURRENT_DATE() AND VISIT.VISIT_STATUS_NAME = ''In Review'')
						,VISIT.VISIT_KEY, NULL))   
			AS VISITS_IN_REVIEW,
        COUNT(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'')
                        AND (VISIT.VISIT_STATUS_NAME = ''Future'' OR
                                        (VISIT.SERVICE_DATE > CURRENT_DATE() AND NVL(VISIT.SCHEDULE_STATUS_NAME,''0'') NOT IN (''Hold'',''Cancelled'') AND NVL(VISIT.VISIT_STATUS_NAME,''0'') <> ''Did not happen''))
                                        ,VISIT.VISIT_KEY, NULL))  
            AS FUTURE_VISITS,
        COUNT(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') AND VISIT.SERVICE_DATE > CURRENT_DATE()
                    AND (VISIT.VISIT_STATUS_NAME = ''Did not happen'' OR VISIT.SCHEDULE_STATUS_NAME in (''Cancelled''))
                    ,VISIT.VISIT_KEY, NULL))  
            AS FUTURE_CANCELLED_VISITS,
        COUNT(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') AND VISIT.SERVICE_DATE > CURRENT_DATE() AND VISIT.SCHEDULE_STATUS_NAME in (''Hold'')
                    ,VISIT.VISIT_KEY, NULL))  
            AS FUTURE_HOLD_VISITS,
        COUNT(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
        			AND (VISIT.SERVICE_DATE <= CURRENT_DATE() AND NVL(VISIT.SCHEDULE_STATUS_NAME,''0'') <> ''Hold'' AND VISIT.VISIT_STATUS_NAME IS NULL)
        			, VISIT.VISIT_KEY, NULL))   
        	AS VISITS_MISSED,
        COUNT(iff(VISIT.CONFIRMED_FLAG = ''YES'', VISIT.VISIT_KEY, NULL))   
        	AS VISITS_COMPLETED,
        COUNT(iff(VISIT.CONFIRMED_FLAG IN (''NO'',''UNKNOWN'') 
        			AND VISIT.SERVICE_DATE <= CURRENT_DATE() AND (VISIT.VISIT_STATUS_NAME = ''Did not happen'' OR VISIT.SCHEDULE_STATUS_NAME in (''Hold'',''Cancelled''))
        			,VISIT.VISIT_KEY, NULL))   
        	AS VISITS_CANCELLED,
        COUNT(iff(VISIT.SCHEDULE_STATUS_NAME = ''Rescheduled'', VISIT.VISIT_KEY, NULL))   
        	AS VISITS_RESCHEDULED,
        COUNT(VISIT.VISIT_KEY)   
        	AS VISITS_SCHEDULED,
		IFF(VISITS_COMPLETED = 0, FALSE, TRUE) AS CLIENT_SERVED_FLAG
	FROM INTEGRATION.FACT_VISIT_MERGED VISIT
	JOIN HAH.DIM_DATE DD ON DD.CALENDAR_DATE = VISIT.SERVICE_DATE
	Left JOIN INTEGRATION.FACT_BRANCH_PAYROLL_PERIODS_MERGED  P ON VISIT.PAYROLL_DATE = P.CHECK_DATE
        AND P.ORIGINAL_BRANCH_KEY =VISIT.ORIGINAL_BRANCH_KEY 
	LEFT JOIN (SELECT BRANCH_KEY,PERIOD_START_DATE,PERIOD_END_DATE,CHECK_DATE,ORIGINAL_BRANCH_KEY,
        lag(check_date) over (partition by BRANCH_KEY ORDER BY CHECK_DATE ASC) AS PreviousCheckDate
        FROM INTEGRATION.FACT_BRANCH_PAYROLL_PERIODS_MERGED) PAYROLL_NEXTCHECKDATE ON VISIT.PAYROLL_DATE < PAYROLL_NEXTCHECKDATE.CHECK_DATE
        AND VISIT.PAYROLL_DATE >= PAYROLL_NEXTCHECKDATE.PreviousCheckDate AND PAYROLL_NEXTCHECKDATE.ORIGINAL_BRANCH_KEY =VISIT.ORIGINAL_BRANCH_KEY
   GROUP BY
        DD.HAH_CURRENT_WEEK_FIRST_DAY,
		VISIT.CLIENT_KEY,
		VISIT.CONTRACT_KEY,
		VISIT.ORIGINAL_SOURCE_SYSTEM_ID,
		VISIT.SOURCE_SYSTEM_ID,
		VISIT.BRANCH_KEY,
		VISIT.SUPERVISOR_KEY,
		COALESCE(P.CHECK_DATE,PAYROLL_NEXTCHECKDATE.CHECK_DATE),
		COALESCE(P.PERIOD_START_DATE,PAYROLL_NEXTCHECKDATE.PERIOD_START_DATE),
        COALESCE(P.PERIOD_END_DATE,PAYROLL_NEXTCHECKDATE.PERIOD_END_DATE),
        VISIT.EMPLOYEE_KEY
		)
	SELECT PAYROLL_DATE, PAY_PERIOD_START_DATE, PAY_PERIOD_END_DATE, SERVICE_WEEK, CLIENT_KEY, CONTRACT_KEY, ORIGINAL_SOURCE_SYSTEM_ID, SOURCE_SYSTEM_ID, BRANCH_KEY, SUPERVISOR_KEY, EMPLOYEE_KEY, HOURS_SERVED, 
	HOURS_IN_REVIEW, FUTURE_HOURS, FUTURE_CANCELLED_HOURS, FUTURE_HOLD_HOURS, HOURS_MISSED, HOURS_CANCELLED, HOURS_RESCHEDULED, HOURS_SCHEDULED, VISITS_IN_REVIEW, 
	FUTURE_VISITS, FUTURE_CANCELLED_VISITS, FUTURE_HOLD_VISITS, VISITS_MISSED, VISITS_COMPLETED, VISITS_CANCELLED, VISITS_RESCHEDULED, VISITS_SCHEDULED, 
	CLIENT_SERVED_FLAG, --ETL Fields
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG
	FROM METRICS;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

 EOT
}

