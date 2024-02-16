create or replace view DW_PROD.REPORT.VW_SLT_DASHBOARD_SCHEDULED_HOURS_DAILY(
	VISIT_KEY,
	BRANCH_KEY,
	CLIENT_KEY,
	CONTRACT_KEY,
	EMPLOYEE_KEY,
	SUPERVISOR_KEY,
	REPORT_DATE,
	SYSTEM_CODE,
	BRANCH_NAME,
	SCHEDULED_HOURS_ALL
) as

  SELECT VISIT_KEY, BRANCH_KEY, CLIENT_KEY, CONTRACT_KEY, EMPLOYEE_KEY,SUPERVISOR_KEY, REPORT_DATE, SYSTEM_CODE, BRANCH_NAME,
  SUM(SCHEDULE_DURATION) AS SCHEDULED_HOURS_ALL
  FROM DW_PROD.HAH.FACT_EVV_VISIT
  WHERE REPORT_DATE >= '2020-01-01'
  AND STATUS_DESCRIPTION != 'Cancelled'
  GROUP BY 1,2,3,4,5,6,7,8,9;