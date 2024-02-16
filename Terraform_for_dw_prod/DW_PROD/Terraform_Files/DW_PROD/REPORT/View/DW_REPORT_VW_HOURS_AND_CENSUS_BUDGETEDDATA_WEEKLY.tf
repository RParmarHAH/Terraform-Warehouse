resource "snowflake_view" "DW_REPORT_VW_HOURS_AND_CENSUS_BUDGETEDDATA_WEEKLY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_HOURS_AND_CENSUS_BUDGETEDDATA_WEEKLY"
	statement = <<-SQL
	 WITH DATES AS(
SELECT DISTINCT DATEADD('month', -1, D.HAH_CURRENT_WEEK_LAST_DAY) AS BEGIN_DATE, D.HAH_CURRENT_WEEK_LAST_DAY AS END_DATE, D.CALENDAR_DATE AS CALENDAR_DATE
FROM HAH.DIM_DATE D
WHERE D.HAH_CURRENT_WEEK_LAST_DAY <= CURRENT_DATE
ORDER BY 2 DESC
),
CLIENTS_COUNT AS(
SELECT D.END_DATE AS BUDGET_SERVICE_WEEK, B.BRANCH_KEY, DC.REVENUE_CATEGORY AS SERVICE_LINE, COUNT(DISTINCT C.CLIENT_KEY) AS CLIENT_COUNT
FROM REPORT.VW_EXECUTIVE_OPERATIONS_EXCELLENCE_HOURS_AND_CENSUS_BY_SERVICE_PAYROLL_PERIOD_DAILY C
JOIN DATES D
ON C.SERVICE_DATE >= D.BEGIN_DATE AND C.SERVICE_DATE <= D.END_DATE
JOIN REPORT.VW_DASHBOARD_CONTRACTS DC
ON DC.CONTRACT_KEY = C.CONTRACT_KEY
JOIN INTEGRATION.DIM_BRANCH_MERGED B
ON B.BRANCH_KEY = C.BRANCH_KEY
GROUP BY 1,2,3
),
CLIENTS_AVG AS(
WITH WEEKLY_CLIENTS AS(
SELECT D.HAH_CURRENT_WEEK_LAST_DAY AS BUDGET_SERVICE_WEEK, B.BRANCH_KEY, DC.REVENUE_CATEGORY AS SERVICE_LINE, COUNT(DISTINCT C.CLIENT_KEY) AS CLIENTS_WEEKLY
FROM REPORT.VW_EXECUTIVE_OPERATIONS_EXCELLENCE_HOURS_AND_CENSUS_BY_SERVICE_PAYROLL_PERIOD_DAILY C
JOIN REPORT.VW_DASHBOARD_CONTRACTS DC
ON DC.CONTRACT_KEY = C.CONTRACT_KEY
JOIN INTEGRATION.DIM_BRANCH_MERGED B
ON B.BRANCH_KEY = C.BRANCH_KEY
JOIN HAH.DIM_DATE D
ON D.CALENDAR_DATE = C.SERVICE_DATE
WHERE C.SERVICE_DATE >= '2021-01-01'
GROUP BY 1,2,3)
SELECT W.BUDGET_SERVICE_WEEK, W.BRANCH_KEY, W.SERVICE_LINE, 
AVG(W.CLIENTS_WEEKLY) over (PARTITION BY W.BRANCH_KEY, W.SERVICE_LINE ORDER BY W.BUDGET_SERVICE_WEEK rows BETWEEN 3 preceding AND CURRENT ROW) AS AVG_CLIENTS
FROM WEEKLY_CLIENTS W
ORDER BY 1 DESC
),
TARGET_CLIENTS AS(
SELECT MONTH, BRANCH_KEY, SERVICELINE AS SERVICE_LINE, SUM(BUDGETEDCLIENTS) AS BUDGETED_CLIENTS
FROM REPORT.VW_HOURS_AND_CENCUS_BUDGETEDDATA
GROUP BY 1,2,3
),
CAREGIVERS_COUNT AS(
SELECT D.END_DATE AS BUDGET_SERVICE_WEEK, B.BRANCH_KEY, COUNT(DISTINCT C.EMPLOYEE_KEY) AS CAREGIVER_COUNT
FROM DW_${var.SF_ENVIRONMENT}.REPORT.EMPLOYEE_DERIVED_WEEKLY_VISIT_METRICS C
JOIN DATES D 
ON C.SERVICE_WEEK_END_DATE >= D.BEGIN_DATE AND C.SERVICE_WEEK_END_DATE <= D.END_DATE
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH B
ON B.BRANCH_KEY = C.BRANCH_KEY
AND C.ACTIVE_FLAG = TRUE
GROUP BY 1,2
),
CAREGIVERS_AVG AS(
WITH WEEKLY_CAREGIVERS AS(
SELECT D.HAH_CURRENT_WEEK_LAST_DAY AS BUDGET_SERVICE_WEEK, C.BRANCH_KEY, COUNT(DISTINCT C.EMPLOYEE_KEY) AS CAREGIVERS_WEEKLY
FROM DW_${var.SF_ENVIRONMENT}.REPORT.EMPLOYEE_DERIVED_WEEKLY_VISIT_METRICS C
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH B
ON B.BRANCH_KEY = C.BRANCH_KEY
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D
ON D.CALENDAR_DATE = C.SERVICE_WEEK_END_DATE
WHERE C.SERVICE_WEEK_END_DATE >= '2021-01-01'
AND C.ACTIVE_FLAG = TRUE
GROUP BY 1,2)
SELECT W.BUDGET_SERVICE_WEEK, W.BRANCH_KEY, 
AVG(W.CAREGIVERS_WEEKLY) over (PARTITION BY W.BRANCH_KEY ORDER BY W.BUDGET_SERVICE_WEEK rows BETWEEN 3 preceding AND CURRENT ROW) AS AVG_CAREGIVERS
FROM WEEKLY_CAREGIVERS W
ORDER BY 1 DESC
),
TARGET_CAREGIVERS AS(
SELECT BUDGET_MONTH, BRANCH_KEY, SUM(CAREGIVER_BUDGET) AS BUDGETED_CAREGIVERS
FROM DW_${var.SF_ENVIRONMENT}.REPORT.VW_CAREGIVER_BUDGET
GROUP BY 1,2
)
SELECT
 DT.END_DATE AS BUDGET_SERVICE_WEEK,
 FBM.STATE_CODE AS OFFICE_STATE_CODE,
 FBM.OFFICE_NUMBER,
 FBM.BRANCH_KEY,
 FBM.BRANCH_NAME,
 FBM.SERVICE_LINE_CODE AS SERVICELINE,
 SUM(FBM.HOURS_BUDGETED_DAILY) AS BUDGETEDHOURS_WEEKLY,
 (CA.AVG_CLIENTS/CC.CLIENT_COUNT)*AVG(TC.BUDGETED_CLIENTS) AS BUDGETEDCLIENTS_WEEKLY,
 (CGA.AVG_CAREGIVERS/CGC.CAREGIVER_COUNT)*AVG(TCG.BUDGETED_CAREGIVERS) AS BUDGETEDCAREGIVERS_WEEKLY
 FROM INTEGRATION.FACT_BUDGET_MERGED AS FBM
 INNER JOIN DATES DT
 ON DT.CALENDAR_DATE = FBM.CALENDAR_DATE
 LEFT JOIN CLIENTS_COUNT CC
 ON CC.BRANCH_KEY = FBM.BRANCH_KEY AND CC.SERVICE_LINE = FBM.SERVICE_LINE_CODE AND CC.BUDGET_SERVICE_WEEK = DT.END_DATE
 LEFT JOIN CLIENTS_AVG CA
 ON CA.BUDGET_SERVICE_WEEK = CC.BUDGET_SERVICE_WEEK AND CA.BRANCH_KEY = CC.BRANCH_KEY AND CA.SERVICE_LINE = CC.SERVICE_LINE
 LEFT JOIN TARGET_CLIENTS TC
 ON DATE_PART(MONTH, TC.MONTH) = DATE_PART(MONTH, CC.BUDGET_SERVICE_WEEK) AND DATE_PART(YEAR, TC.MONTH) = DATE_PART(YEAR, CC.BUDGET_SERVICE_WEEK)
 AND TC.BRANCH_KEY = CC.BRANCH_KEY AND TC.SERVICE_LINE = CC.SERVICE_LINE
 LEFT JOIN CAREGIVERS_COUNT CGC
 ON CGC.BRANCH_KEY = FBM.BRANCH_KEY AND CGC.BUDGET_SERVICE_WEEK = DT.END_DATE
 LEFT JOIN CAREGIVERS_AVG CGA
 ON CGA.BUDGET_SERVICE_WEEK = CGC.BUDGET_SERVICE_WEEK AND CGA.BRANCH_KEY = CGC.BRANCH_KEY
 LEFT JOIN TARGET_CAREGIVERS TCG
 ON DATE_PART(MONTH, TCG.BUDGET_MONTH) = DATE_PART(MONTH, CGC.BUDGET_SERVICE_WEEK) AND DATE_PART(YEAR, TCG.BUDGET_MONTH) = DATE_PART(YEAR, CGC.BUDGET_SERVICE_WEEK)
 AND TCG.BRANCH_KEY = CGC.BRANCH_KEY
 WHERE DT.CALENDAR_DATE >= '2018-01-01'
 GROUP BY DT.END_DATE, FBM.STATE_CODE, FBM.OFFICE_NUMBER, FBM.BRANCH_KEY, FBM.BRANCH_NAME, FBM.SERVICE_LINE_CODE, CC.CLIENT_COUNT, CA.AVG_CLIENTS, CGC.CAREGIVER_COUNT, CGA.AVG_CAREGIVERS
 HAVING CC.CLIENT_COUNT != 0 AND CGC.CAREGIVER_COUNT != 0
 ORDER BY 1;
SQL
	or_replace = true 
	is_secure = false 
}

