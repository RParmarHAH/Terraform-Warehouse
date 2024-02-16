resource "snowflake_view" "DW_REPORT_VW_CLIENT_CAREGIVER_MONTHLY_RELATIONSHIP" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_CLIENT_CAREGIVER_MONTHLY_RELATIONSHIP"
	statement = <<-SQL
	 WITH GEN_REL AS (
SELECT DISTINCT DATE_TRUNC('MONTH',V.SERVICE_DATE) SERVICE_MONTH, 
	V.CLIENT_KEY, 
	V.ORIGINAL_CLIENT_KEY, 
	CL.CLIENT_NUMBER ,
	V.EMPLOYEE_KEY, 
	V.ORIGINAL_EMPLOYEE_KEY,
	E.EMPLOYEE_NUMBER, 
	V.SYSTEM_CODE,
MIN(iff(MAX(CONFIRMED_FLAG) = 'YES',SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
	RELATIONSHIP_FIRST_SERVICE_DATE, 
MAX(iff(MAX(CONFIRMED_FLAG) = 'YES',SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
	RELATIONSHIP_LATEST_SERVICE_DATE,
	V.BRANCH_KEY,
(	MAX(iff(MAX(CONFIRMED_FLAG) = 'YES',SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
	- MIN(iff(MAX(CONFIRMED_FLAG) = 'YES',SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY)
) 	RELATIONSHIP_TENURE, 
MIN(iff(MAX(CONFIRMED_FLAG) = 'YES',V.SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY) 
	CLIENT_FIRST_SERVICE_DATE,
MAX(iff(MAX(CONFIRMED_FLAG) = 'YES',V.SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY) 
	CLIENT_LATEST_SERVICE_DATE,
(	MAX(iff(MAX(CONFIRMED_FLAG) = 'YES',V.SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY) 
	- MIN(iff(MAX(CONFIRMED_FLAG) = 'YES',V.SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY)
) 	CLIENT_TENURE, 
MIN(iff(MAX(CONFIRMED_FLAG) = 'YES',V.SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY) 
	EMPLOYEE_FIRST_SERVICE_DATE,
MAX(iff(MAX(CONFIRMED_FLAG) = 'YES',V.SERVICE_DATE,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY) 
	EMPLOYEE_LATEST_SERVICE_DATE,
	CL.CLIENT_DOB,
	E.EMPLOYEE_DOB,
CASE WHEN E.CASE_MANAGER_FLAG = TRUE THEN 'ADMIN' ELSE E.EMPLOYEE_CATEGORY END 
	AS DERIVED_EMPLOYEE_CATEGORY,
	CL.CLIENT_ZIP, 
CONCAT(CG.LATITUDE,',',CG.LONGITUDE) 
	CLIENT_LAT_LONG,
	E.EMPLOYEE_ZIP,
CONCAT(EG.LATITUDE,',',EG.LONGITUDE) 
	EMPLOYEE_LAT_LONG,
HAVERSINE(CG.LATITUDE,CG.LONGITUDE,EG.LATITUDE,EG.LONGITUDE) 
	EMPLOYEE_CLIENT_DISTANCE,
SUM(HAVERSINE(CG.LATITUDE,CG.LONGITUDE,EG.LATITUDE,EG.LONGITUDE))/COUNT(HAVERSINE(CG.LATITUDE,CG.LONGITUDE,EG.LATITUDE,EG.LONGITUDE)) 
	AVG_EMPLOYEE_CLIENT_DISTANCE,
SUM(iff(MAX(CONFIRMED_FLAG) = 'YES',V.HOURS_SERVED,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH) 
	TOTAL_HOURS_SERVED,
COUNT(iff(MAX(CONFIRMED_FLAG) = 'YES',V.VISIT_KEY,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH) 
	TOTAL_NUMBER_OF_VISITS,
(SUM(iff(MAX(CONFIRMED_FLAG) = 'YES',V.HOURS_SERVED,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH)/COUNT(iff(MAX(CONFIRMED_FLAG) = 'YES',V.VISIT_KEY,NULL)) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH)) 
	AVG_HOURS_PER_VISIT,
	E.EMPLOYEE_FIRST_NAME,
	E.EMPLOYEE_LAST_NAME
FROM INTEGRATION.FACT_VISIT_MERGED V 
LEFT JOIN HAH.DIM_CONTRACT C ON C. CONTRACT_KEY = V.CONTRACT_KEY
LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED E ON E.ORIGINAL_EMPLOYEE_KEY = V.ORIGINAL_EMPLOYEE_KEY 
LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED CL ON CL.ORIGINAL_CLIENT_KEY = V.ORIGINAL_CLIENT_KEY  
LEFT JOIN HAH.DIM_GEOGRAPHY CG ON CG.ZIP_CODE = CL.CLIENT_ZIP
LEFT JOIN HAH.DIM_GEOGRAPHY EG ON EG.ZIP_CODE = E.EMPLOYEE_ZIP 
JOIN REPORT.VW_DASHBOARD_CONTRACTS DC ON V.CONTRACT_KEY = DC.CONTRACT_KEY
WHERE DATE_TRUNC('MONTH',V.SERVICE_DATE) <= DATEADD( 'MONTH', 2, CURRENT_DATE)
-- V.CONFIRMED_FLAG = 'YES' --AND NVL(V.BILL_UNIT_TYPE,'Hourly')='Hourly' --V.STATUS_CODE IN ('02','03','04','05') 
AND 
(DC.INCLUDE_FOR_EXEC_OPS_HOURS = TRUE OR DC.INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE)
GROUP BY V.VISIT_KEY, V.SERVICE_DATE, V.HOURS_SERVED, V.CLIENT_KEY, CL.CLIENT_NUMBER, V.EMPLOYEE_KEY, E.EMPLOYEE_NUMBER, V.BRANCH_KEY, CL.CLIENT_DOB, E.EMPLOYEE_DOB, CL.CLIENT_ZIP, E.EMPLOYEE_ZIP, E.CASE_MANAGER_FLAG, E.EMPLOYEE_CATEGORY, 
CG.LATITUDE, CG.LONGITUDE, EG.LATITUDE, EG.LONGITUDE, V.SYSTEM_CODE, V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_KEY, E.EMPLOYEE_FIRST_NAME, E.EMPLOYEE_LAST_NAME 
),
HH_REL AS (
SELECT DISTINCT DATE_TRUNC('MONTH',V.SERVICE_DATE) SERVICE_MONTH,
	V.CLIENT_KEY, 
	V.ORIGINAL_CLIENT_KEY, 
	V.EMPLOYEE_KEY, 
	V.ORIGINAL_EMPLOYEE_KEY,
MIN(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
	HH_RELATIONSHIP_FIRST_SERVICE_DATE, 
MAX(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
	HH_RELATIONSHIP_LATEST_SERVICE_DATE,
(MAX(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
- MIN(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY)
)	HH_RELATIONSHIP_TENURE, 
MIN(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY) 
	CLIENT_HH_FIRST_SERVICE_DATE,
MAX(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY) 
	CLIENT_HH_LATEST_SERVICE_DATE,
MIN(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY) 
	EMPLOYEE_HH_FIRST_SERVICE_DATE,
MAX(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY) 
	EMPLOYEE_HH_LATEST_SERVICE_DATE,
SUM(V.HOURS_SERVED) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH) 
	TOTAL_HH_HOURS_SERVED,
COUNT(V.VISIT_KEY) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH) 
	TOTAL_NUMBER_HH_OF_VISITS,
(SUM(V.HOURS_SERVED) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH)/COUNT(V.VISIT_KEY) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH)) 
	HH_AVG_HOURS_PER_VISIT
FROM INTEGRATION.FACT_VISIT_MERGED V 
JOIN HAH.DIM_CONTRACT C ON C.CONTRACT_KEY = V.CONTRACT_KEY AND C.REVENUE_CATEGORY = 'HH' 
LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED E ON E.ORIGINAL_EMPLOYEE_KEY = V.ORIGINAL_EMPLOYEE_KEY 
LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED CL ON CL.ORIGINAL_CLIENT_KEY = V.ORIGINAL_CLIENT_KEY  
LEFT JOIN HAH.DIM_GEOGRAPHY CG ON CG.ZIP_CODE = CL.CLIENT_ZIP
LEFT JOIN HAH.DIM_GEOGRAPHY EG ON EG.ZIP_CODE = E.EMPLOYEE_ZIP 
WHERE  V.CONFIRMED_FLAG = 'YES' --V.STATUS_CODE IN ('02','03','04','05')
GROUP BY V.VISIT_KEY, V.SERVICE_DATE, V.HOURS_SERVED, V.CLIENT_KEY, CL.CLIENT_NUMBER, V.EMPLOYEE_KEY, E.EMPLOYEE_NUMBER, V.BRANCH_KEY, CL.CLIENT_DOB, E.EMPLOYEE_DOB, CL.CLIENT_ZIP, E.EMPLOYEE_ZIP, E.CASE_MANAGER_FLAG, E.EMPLOYEE_CATEGORY, 
CG.LATITUDE, CG.LONGITUDE, EG.LATITUDE, EG.LONGITUDE, V.ORIGINAL_CLIENT_KEY, V.ORIGINAL_EMPLOYEE_KEY 
),
HC_REL AS (
SELECT DISTINCT DATE_TRUNC('MONTH',V.SERVICE_DATE) SERVICE_MONTH,
	V.CLIENT_KEY, 
	V.ORIGINAL_CLIENT_KEY, 
	V.EMPLOYEE_KEY, 
	V.ORIGINAL_EMPLOYEE_KEY,
MIN(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
	HC_RELATIONSHIP_FIRST_SERVICE_DATE, 
MAX(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
	HC_RELATIONSHIP_LATEST_SERVICE_DATE,
(MAX(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY) 
- MIN(SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY, V.ORIGINAL_CLIENT_kEY)
) 	HC_RELATIONSHIP_TENURE, 
MIN(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY) 
	CLIENT_HC_FIRST_SERVICE_DATE,
MAX(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_CLIENT_kEY) 
	CLIENT_HC_LATEST_SERVICE_DATE,
MIN(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY) 
	EMPLOYEE_HC_FIRST_SERVICE_DATE,
MAX(V.SERVICE_DATE) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY) 
	EMPLOYEE_HC_LATEST_SERVICE_DATE,
SUM(V.HOURS_SERVED) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH) 
	TOTAL_HC_HOURS_SERVED,
COUNT(V.VISIT_KEY) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH) 
	TOTAL_NUMBER_HC_OF_VISITS,
(SUM(V.HOURS_SERVED) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH)/COUNT(V.VISIT_KEY) OVER (PARTITION BY V.ORIGINAL_EMPLOYEE_KEY,V.ORIGINAL_CLIENT_kEY,SERVICE_MONTH)) 
	HC_AVG_HOURS_PER_VISIT
FROM INTEGRATION.FACT_VISIT_MERGED V 
JOIN HAH.DIM_CONTRACT C ON C.CONTRACT_KEY = V.CONTRACT_KEY AND C.REVENUE_CATEGORY = 'HC' 
LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED E ON E.ORIGINAL_EMPLOYEE_KEY = V.ORIGINAL_EMPLOYEE_KEY 
LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED CL ON CL.ORIGINAL_CLIENT_KEY = V.ORIGINAL_CLIENT_KEY  
LEFT JOIN HAH.DIM_GEOGRAPHY CG ON CG.ZIP_CODE = CL.CLIENT_ZIP
LEFT JOIN HAH.DIM_GEOGRAPHY EG ON EG.ZIP_CODE = E.EMPLOYEE_ZIP 
WHERE  V.CONFIRMED_FLAG = 'YES' --V.STATUS_CODE IN ('02','03','04','05')
GROUP BY V.VISIT_KEY, V.SERVICE_DATE, V.HOURS_SERVED, V.CLIENT_KEY, CL.CLIENT_NUMBER, V.EMPLOYEE_KEY, E.EMPLOYEE_NUMBER, V.BRANCH_KEY, CL.CLIENT_DOB, E.EMPLOYEE_DOB, CL.CLIENT_ZIP, E.EMPLOYEE_ZIP, E.CASE_MANAGER_FLAG, E.EMPLOYEE_CATEGORY, 
CG.LATITUDE, CG.LONGITUDE, EG.LATITUDE, EG.LONGITUDE, V.ORIGINAL_CLIENT_KEY, V.ORIGINAL_EMPLOYEE_KEY 
),
NEW_METRICS AS
	(	
		SELECT
			REPORT_DATE, 
			CLIENT_KEY,
			BRANCH_KEY,
			EMPLOYEE_KEY,
			ORIGINAL_EMPLOYEE_KEY,
			ORIGINAL_CLIENT_KEY, 
			sum(HOURS_IN_REVIEW) AS HOURS_IN_REVIEW,
			sum(FUTURE_HOURS) AS FUTURE_HOURS,
			sum(FUTURE_CANCELLED_HOURS) AS FUTURE_CANCELLED_HOURS,
			sum(FUTURE_HOLD_HOURS) AS FUTURE_HOLD_HOURS,
			sum(HOURS_MISSED) AS HOURS_MISSED,
			sum(HOURS_CANCELLED) AS HOURS_CANCELLED,
			sum(HOURS_RESCHEDULED) AS HOURS_RESCHEDULED,
			sum(HOURS_SCHEDULED) AS HOURS_SCHEDULED,
			sum(VISITS_IN_REVIEW) AS VISITS_IN_REVIEW,
			sum(FUTURE_VISITS) AS FUTURE_VISITS,
			sum(FUTURE_CANCELLED_VISITS) AS FUTURE_CANCELLED_VISITS,
			sum(FUTURE_HOLD_VISITS) AS FUTURE_HOLD_VISITS,
			sum(VISITS_MISSED) AS VISITS_MISSED,
			sum(VISITS_COMPLETED) AS VISITS_COMPLETED,
			sum(VISITS_CANCELLED) AS VISITS_CANCELLED,
			sum(VISITS_RESCHEDULED) AS VISITS_RESCHEDULED,
			sum(VISITS_SCHEDULED) AS VISITS_SCHEDULED,
			max(client_served_flag) AS CLIENT_SERVED_FLAG
		FROM REPORT.SCHEDULE_METRICS_MONTHLY V
		JOIN REPORT.VW_DASHBOARD_CONTRACTS DC ON V.CONTRACT_KEY = DC.CONTRACT_KEY
		WHERE DC.INCLUDE_FOR_EXEC_OPS_HOURS = TRUE OR DC.INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE
		GROUP BY 
			REPORT_DATE, 
			CLIENT_KEY,
			BRANCH_KEY,
			EMPLOYEE_KEY,
			ORIGINAL_EMPLOYEE_KEY,
			ORIGINAL_CLIENT_KEY			
	)
SELECT G.*,HH_RELATIONSHIP_FIRST_SERVICE_DATE, HH_RELATIONSHIP_LATEST_SERVICE_DATE, HH_RELATIONSHIP_TENURE, CLIENT_HH_FIRST_SERVICE_DATE, CLIENT_HH_LATEST_SERVICE_DATE,
EMPLOYEE_HH_FIRST_SERVICE_DATE, EMPLOYEE_HH_LATEST_SERVICE_DATE, TOTAL_HH_HOURS_SERVED, TOTAL_NUMBER_HH_OF_VISITS, HH_AVG_HOURS_PER_VISIT,
HC_RELATIONSHIP_LATEST_SERVICE_DATE, HC_RELATIONSHIP_TENURE, CLIENT_HC_FIRST_SERVICE_DATE, CLIENT_HC_LATEST_SERVICE_DATE,
EMPLOYEE_HC_FIRST_SERVICE_DATE, EMPLOYEE_HC_LATEST_SERVICE_DATE, TOTAL_HC_HOURS_SERVED, TOTAL_NUMBER_HC_OF_VISITS, HC_AVG_HOURS_PER_VISIT,
NM.HOURS_IN_REVIEW,
	NM.FUTURE_HOURS,
	NM.FUTURE_CANCELLED_HOURS,
	NM.FUTURE_HOLD_HOURS,
	NM.HOURS_MISSED,
	NM.HOURS_CANCELLED,
	NM.HOURS_RESCHEDULED,
	NM.HOURS_SCHEDULED,
	NM.VISITS_IN_REVIEW,
	NM.FUTURE_VISITS,
	NM.FUTURE_CANCELLED_VISITS,
	NM.FUTURE_HOLD_VISITS,
	NM.VISITS_MISSED,
	NM.VISITS_COMPLETED,
	NM.VISITS_CANCELLED,
	NM.VISITS_RESCHEDULED,
	NM.VISITS_SCHEDULED,
	NM.CLIENT_SERVED_FLAG
FROM GEN_REL G
LEFT JOIN HC_REL HC ON HC.ORIGINAL_CLIENT_KEY=G.ORIGINAL_CLIENT_KEY AND HC.ORIGINAL_EMPLOYEE_KEY=G.ORIGINAL_EMPLOYEE_KEY AND HC.SERVICE_MONTH=G.SERVICE_MONTH
LEFT JOIN HH_REL HH ON HH.ORIGINAL_CLIENT_KEY=G.ORIGINAL_CLIENT_KEY AND HH.ORIGINAL_EMPLOYEE_KEY=G.ORIGINAL_EMPLOYEE_KEY AND HH.SERVICE_MONTH=G.SERVICE_MONTH
LEFT JOIN NEW_METRICS NM ON NM.REPORT_DATE = G.SERVICE_MONTH 
	AND NM.EMPLOYEE_KEY = G.EMPLOYEE_KEY AND NM.CLIENT_KEY = G.CLIENT_KEY AND NM.BRANCH_KEY = G.BRANCH_KEY
	AND NM.ORIGINAL_CLIENT_KEY = G.ORIGINAL_CLIENT_KEY AND NM.ORIGINAL_EMPLOYEE_KEY = G.ORIGINAL_EMPLOYEE_KEY;
SQL
	or_replace = true 
	is_secure = false 
}

