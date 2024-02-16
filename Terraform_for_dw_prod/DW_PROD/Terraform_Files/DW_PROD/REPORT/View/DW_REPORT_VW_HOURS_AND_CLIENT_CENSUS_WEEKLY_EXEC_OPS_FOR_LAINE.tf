resource "snowflake_view" "DW_REPORT_VW_HOURS_AND_CLIENT_CENSUS_WEEKLY_EXEC_OPS_FOR_LAINE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_HOURS_AND_CLIENT_CENSUS_WEEKLY_EXEC_OPS_FOR_LAINE"
	statement = <<-SQL
	 
(WITH DATA_1_0 AS (
    SELECT 
      DISTINCT 
        A.*,
        CM.DERIVED_FIRST_SERVICE_DATE DERIVED_FIRST_SERVICE_DATE,
        CM.DERIVED_LAST_SERVICE_DATE DERIVED_LAST_SERVICE_DATE      
    FROM REPORT.HOURS_AND_CENSUS_BY_PAYROLL_DATE_WEEKLY_1_0  A
    LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED CM ON 
        A.CLIENT_KEY_DATA = CM.CLIENT_KEY
WHERE A.SERVICE_WEEK BETWEEN '2021-12-26' AND DATEADD( 'WEEK', 4, CURRENT_DATE)
)        
, DATA_2_0 AS (
    SELECT 
      DISTINCT --B.BRANCH_PAYROLL_PERIODS_KEY,
        A.*,
        CM.DERIVED_FIRST_SERVICE_DATE DERIVED_FIRST_SERVICE_DATE,
        CM.DERIVED_LAST_SERVICE_DATE DERIVED_LAST_SERVICE_DATE      
    FROM REPORT.HOURS_AND_CENSUS_BY_PAYROLL_DATE_WEEKLY_2_0  A
    LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED CM ON 
        A.CLIENT_KEY_DATA = CM.CLIENT_KEY
WHERE A.SERVICE_WEEK BETWEEN '2021-12-26' AND DATEADD( 'WEEK', 4, CURRENT_DATE)
),DATE_DATA AS (
 SELECT DISTINCT A.CALENDAR_DATE AS CALENDAR_DATE,B.BRANCH_KEY AS BRANCH_KEY FROM HAH.DIM_DATE A
 LEFT JOIN INTEGRATION.FACT_BRANCH_PAYROLL_PERIODS_MERGED B ON A.CALENDAR_DATE BETWEEN B.PERIOD_START_DATE AND B.PERIOD_END_DATE
 WHERE A.CALENDAR_DATE BETWEEN '2021-12-26' AND DATEADD( 'WEEK', 4, CURRENT_DATE)
)
SELECT 
    A.SERVICE_WEEK,
    NULL AS BILL_UNIT,
    A.SERVICE_END_OF_WEEK,	
    A.BRANCH_KEY, 
    A.CONTRACT_KEY ,
    A.SUPERVISOR_KEY,
    A.CLIENT_KEY_DATA,
    NULL AS PARTNER_CONTRACT_SERVICE_KEY,
    A.ORIGINAL_SOURCE_SYSTEM_ID,
    A.SOURCE_SYSTEM_ID,
    A.CLIENT_KEY,
	A.HOURS_SCHEDULED,
	A.HOURS_SERVED_ALL,
	A.HOURS_CANCELLED,
	A.HOURS_IN_REVIEW,
	A.HOURS_MISSED,
	A.HOURS_RESCHEDULED,
	A.FUTURE_HOURS,
	A.FUTURE_CANCELLED_HOURS,
	A.FUTURE_HOLD_HOURS,
	A.VISITS_SCHEDULED,
	A.VISITS_COMPLETED,
	A.VISITS_CANCELLED,
	A.VISITS_IN_REVIEW,
	A.VISITS_MISSED,
	A.VISITS_RESCHEDULED,
	A.FUTURE_VISITS,
	A.FUTURE_CANCELLED_VISITS,
	A.FUTURE_HOLD_VISITS,
	A.VISITS_CLEAN_SHIFTS,
	A.VISITS_NEED_MAINTENANCE,
	A.CLIENT_ACQUIRED_FLAG,
	A.CLIENT_ACQUISITION_NAME, 
	A.CLIENT_SERVED_FLAG,	
    A.ETL_TASK_KEY,
    A.ETL_INSERTED_TASK_KEY,
    A.ETL_INSERTED_DATE,
    A.ETL_INSERTED_BY,
    A.ETL_LAST_UPDATED_DATE,
    A.ETL_LAST_UPDATED_BY,
    A.ETL_DELETED_FLAG,
    A.ETL_INFERRED_MEMBER_FLAG,
    A.DERIVED_FIRST_SERVICE_DATE DERIVED_FIRST_SERVICE_DATE,
    A.DERIVED_LAST_SERVICE_DATE DERIVED_LAST_SERVICE_DATE
FROM DATA_1_0 A 
LEFT JOIN DATE_DATA B ON B.CALENDAR_DATE=DATEADD('DAY',-7,A.SERVICE_WEEK) AND A.BRANCH_KEY=B.BRANCH_KEY
WHERE B.CALENDAR_DATE IS NOT NULL
UNION ALL	   
SELECT 
    A.SERVICE_WEEK,
    A.BILL_UNIT,
    A.SERVICE_END_OF_WEEK, 
    A.BRANCH_KEY, 
    A.CONTRACT_KEY,
    A.SUPERVISOR_KEY,
    A.CLIENT_KEY_DATA,
    A.PARTNER_CONTRACT_SERVICE_KEY,	 
    A.ORIGINAL_SOURCE_SYSTEM_ID,
    A.SOURCE_SYSTEM_ID,
    A.CLIENT_KEY,
	A.HOURS_SCHEDULED,
	A.HOURS_SERVED_ALL,
	A.HOURS_CANCELLED,
	A.HOURS_IN_REVIEW,
	A.HOURS_MISSED,
	A.HOURS_RESCHEDULED,
	A.FUTURE_HOURS,
	A.FUTURE_CANCELLED_HOURS,
	A.FUTURE_HOLD_HOURS,
	A.VISITS_SCHEDULED,
	A.VISITS_COMPLETED,
	A.VISITS_CANCELLED,
	A.VISITS_IN_REVIEW,
	A.VISITS_MISSED,
	A.VISITS_RESCHEDULED,
	A.FUTURE_VISITS,
	A.FUTURE_CANCELLED_VISITS,
	A.FUTURE_HOLD_VISITS,
	A.VISITS_CLEAN_SHIFTS,
	A.VISITS_NEED_MAINTENANCE,
	A.CLIENT_ACQUIRED_FLAG,
	A.CLIENT_ACQUISITION_NAME,
	A.CLIENT_SERVED_FLAG,  
    A.ETL_TASK_KEY,
    A.ETL_INSERTED_TASK_KEY,
    A.ETL_INSERTED_DATE,
    A.ETL_INSERTED_BY,
    A.ETL_LAST_UPDATED_DATE,
    A.ETL_LAST_UPDATED_BY,
    A.ETL_DELETED_FLAG,
    A.ETL_INFERRED_MEMBER_FLAG,
    A.DERIVED_FIRST_SERVICE_DATE DERIVED_FIRST_SERVICE_DATE,
    A.DERIVED_LAST_SERVICE_DATE DERIVED_LAST_SERVICE_DATE
FROM DATA_2_0 A 
LEFT JOIN DATE_DATA B ON B.CALENDAR_DATE=DATEADD('DAY',-7,A.SERVICE_WEEK) AND A.BRANCH_KEY=B.BRANCH_KEY
WHERE B.CALENDAR_DATE IS NOT NULL);
SQL
	or_replace = true 
	is_secure = false 
}

