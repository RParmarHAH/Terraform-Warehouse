create or replace view DW_PROD.REPORT.VW_EMPLOYEE_DERIVED_WEEKLY_VISIT_METRICS(
	SERVICE_WEEK,
	SERVICE_WEEK_END_DATE,
	EMPLOYEE_KEY,
	SOURCE_SYSTEM_ID,
	ORIGINAL_SOURCE_SYSTEM_ID,
	EMPLOYEE_ID,
	SYSTEM_CODE,
	EMPLOYEE_PID,
	EMPLOYEE_NUMBER,
	PAYROLL_ID,
	EMPLOYEE_CATEGORY,
	DERIVED_EMPLOYEE_CATEGORY,
	FIRST_NAME,
	LAST_NAME,
	BRANCH_KEY,
	BRANCH_NAME,
	BRANCH_STATE_CODE,
	FIRST_SERVICE_WEEK,
	FIRST_SERVICE_WEEK_END_DATE,
	LAST_SERVICE_WEEK,
	LAST_SERVICE_WEEK_END_DATE,
	TENURE_IN_WEEKS,
	NUMBER_WEEKS_WITH_SERVICE,
	NUMBER_WEEKS_WO_SERVICE,
	NUMBER_OF_GAPS_IN_SERVICE,
	SMALLEST_GAP_IN_SERVICE,
	LARGEST_GAP_IN_SERVICE,
	NEW_HIRE_FLAG,
	FIRST_WEEK_INACTIVE_FLAG,
	ACTIVE_FLAG,
	REACTIVATED_FLAG,
	NUMBER_OF_SERVICE_LINES_PROVIDED,
	HC_SERVICE_LINE_PROVIDED,
	HH_SERVICE_LINE_PROVIDED,
	CLS_SERVICE_LINE_PROVIDED,
	NA_SERVICE_LINE_PROVIDED,
	IS_SERVICE_LINE_PROVIDED,
	NS_SERVICE_LINE_PROVIDED,
	OTHER_CONTRACT_SERVICES_PROVIDED,
	NUMBER_OF_VISITS,
	PREVIOUS_WEEK_NUMBER_OF_VISITS,
	PREVIOUS_2_WEEK_NUMBER_OF_VISITS,
	NEXT_WEEK_NUMBER_OF_VISITS,
	NEXT_2_WEEK_NUMBER_OF_VISITS,
	NUMBER_OF_DISTINCT_CLIENTS,
	PREVIOUS_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
	PREVIOUS_2_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
	NEXT_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
	NEXT_2_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
	SUM_OF_HOURS_SERVED,
	PREVIOUS_WEEK_SUM_OF_HOURS_SERVED,
	PREVIOUS_2_WEEK_SUM_OF_HOURS_SERVED,
	NEXT_WEEK_SUM_OF_HOURS_SERVED,
	NEXT_2_WEEK_SUM_OF_HOURS_SERVED,
	NUMBER_OF_HC_VISITS,
	NUMBER_OF_DISTINCT_HC_CLIENTS,
	SUM_OF_HC_HOURS_SERVED,
	NUMBER_OF_HH_VISITS,
	NUMBER_OF_DISTINCT_HH_CLIENTS,
	SUM_OF_HH_HOURS_SERVED,
	NUMBER_OF_CLS_VISITS,
	NUMBER_OF_DISTINCT_CLS_CLIENTS,
	SUM_OF_CLS_HOURS_SERVED,
	NUMBER_OF_NA_VISITS,
	NUMBER_OF_DISTINCT_NA_CLIENTS,
	SUM_OF_NA_HOURS_SERVED,
	NUMBER_OF_IS_VISITS,
	NUMBER_OF_DISTINCT_IS_CLIENTS,
	SUM_OF_IS_HOURS_SERVED,
	NUMBER_OF_NS_VISITS,
	NUMBER_OF_DISTINCT_NS_CLIENTS,
	SUM_OF_NS_HOURS_SERVED,
	NUMBER_OF_OTHER_VISITS,
	NUMBER_OF_DISTINCT_OTHER_CLIENTS,
	SUM_OF_OTHER_HOURS_SERVED,
	SUM_OF_FUTURE_HOURS,
	SUM_OF_HOURS_MISSED,
	NUMBER_OF_FUTURE_VISITS,
	NUMBER_OF_VISITS_MISSED,
	NEXT_SCHEDULED_SERVICE_DATE
) as
SELECT SERVICE_WEEK,
SERVICE_WEEK_END_DATE,
EMPLOYEE_KEY,
SOURCE_SYSTEM_ID,
ORIGINAL_SOURCE_SYSTEM_ID,
EMPLOYEE_ID,
SYSTEM_CODE,
EMPLOYEE_PID,
EMPLOYEE_NUMBER,
PAYROLL_ID,
EMPLOYEE_CATEGORY,
DERIVED_EMPLOYEE_CATEGORY,
FIRST_NAME,
LAST_NAME,
BRANCH_KEY,
BRANCH_NAME,
BRANCH_STATE_CODE,
FIRST_SERVICE_WEEK,
FIRST_SERVICE_WEEK_END_DATE,
LAST_SERVICE_WEEK,
LAST_SERVICE_WEEK_END_DATE,
TENURE_IN_WEEKS,
NUMBER_WEEKS_WITH_SERVICE,
NUMBER_WEEKS_WO_SERVICE,
NUMBER_OF_GAPS_IN_SERVICE,
SMALLEST_GAP_IN_SERVICE,
LARGEST_GAP_IN_SERVICE,
NEW_HIRE_FLAG,
FIRST_WEEK_INACTIVE_FLAG,
ACTIVE_FLAG,
REACTIVATED_FLAG,
NUMBER_OF_SERVICE_LINES_PROVIDED,
HC_SERVICE_LINE_PROVIDED,
HH_SERVICE_LINE_PROVIDED,
CLS_SERVICE_LINE_PROVIDED,
NA_SERVICE_LINE_PROVIDED,
IS_SERVICE_LINE_PROVIDED,
NS_SERVICE_LINE_PROVIDED,
OTHER_Contract_Services_Provided,
NUMBER_OF_VISITS,
PREVIOUS_WEEK_NUMBER_OF_VISITS,
PREVIOUS_2_WEEK_NUMBER_OF_VISITS,
NEXT_WEEK_NUMBER_OF_VISITS,
NEXT_2_WEEK_NUMBER_OF_VISITS,
NUMBER_OF_DISTINCT_CLIENTS,
PREVIOUS_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
PREVIOUS_2_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
NEXT_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
NEXT_2_WEEK_NUMBER_OF_DISTINCT_CLIENTS,
SUM_OF_HOURS_SERVED,
PREVIOUS_WEEK_SUM_OF_HOURS_SERVED,
PREVIOUS_2_WEEK_SUM_OF_HOURS_SERVED,
NEXT_WEEK_SUM_OF_HOURS_SERVED,
NEXT_2_WEEK_SUM_OF_HOURS_SERVED,
NUMBER_OF_HC_VISITS,
NUMBER_OF_DISTINCT_HC_CLIENTS,
SUM_OF_HC_HOURS_SERVED,
NUMBER_OF_HH_VISITS,
NUMBER_OF_DISTINCT_HH_CLIENTS,
SUM_OF_HH_HOURS_SERVED,
NUMBER_OF_CLS_VISITS,
NUMBER_OF_DISTINCT_CLS_CLIENTS,
SUM_OF_CLS_HOURS_SERVED,
NUMBER_OF_NA_VISITS,
NUMBER_OF_DISTINCT_NA_CLIENTS,
SUM_OF_NA_HOURS_SERVED,
NUMBER_OF_IS_VISITS,
NUMBER_OF_DISTINCT_IS_CLIENTS,
SUM_OF_IS_HOURS_SERVED,
NUMBER_OF_NS_VISITS,
NUMBER_OF_DISTINCT_NS_CLIENTS,
SUM_OF_NS_HOURS_SERVED,
Number_of_OTHER_Visits,
Number_of_Distinct_OTHER_Clients,
Sum_of_OTHER_Hours_Served,
FUTURE_HOURS AS SUM_OF_FUTURE_HOURS,
HOURS_MISSED AS SUM_OF_HOURS_MISSED,
FUTURE_VISITS AS NUMBER_OF_FUTURE_VISITS,
VISITS_MISSED AS NUMBER_OF_VISITS_MISSED,
NEXT_SCHEDULED_SERVICE_DATE
FROM REPORT.EMPLOYEE_DERIVED_WEEKLY_VISIT_METRICS 
WHERE SERVICE_WEEK >= DATE_TRUNC('YEAR',DATEADD('YEAR',-2,CURRENT_DATE)) --AND CURRENT_DATE
;