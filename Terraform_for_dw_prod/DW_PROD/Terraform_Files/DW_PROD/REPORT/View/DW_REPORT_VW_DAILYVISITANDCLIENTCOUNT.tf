resource "snowflake_view" "DW_REPORT_VW_DAILYVISITANDCLIENTCOUNT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_DAILYVISITANDCLIENTCOUNT"
	statement = <<-SQL
	 select service_date,
WEEKOFYEAR(service_date) as WeekOfYear,
'Week ' || WEEKOFYEAR(service_date) || ' (' || DATEADD(day,-6,LAST_DAY(service_Date,'Week'))
|| ' - ' || LAST_DAY(service_Date,'Week') || ' )' AS Week,count(1) as TotalVisit,count(distinct client_key) as ClientCount,
DAYNAME(service_date) as WeekDay,
CASE WHEN DAYOFWEEK(service_date) = 0 THEN 7 ELSE DAYOFWEEK(service_date) END as dayofweek
from "HAH"."FACT_VISIT" visit
inner join "HAH"."DIM_BRANCH" branch
on visit.branch_key = branch.branch_key
where service_date > '2020-02-16'
group by service_date;
SQL
	or_replace = true 
	is_secure = false 
}

