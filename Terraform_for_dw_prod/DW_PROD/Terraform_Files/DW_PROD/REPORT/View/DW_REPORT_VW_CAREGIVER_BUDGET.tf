resource "snowflake_view" "DW_REPORT_VW_CAREGIVER_BUDGET" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_CAREGIVER_BUDGET"
	statement = <<-SQL
	 SELECT CAST( REPLACE( t.$1, '0:00') AS DATE) AS Budget_Month,
       t.$2 AS State_Code,
       t.$4 AS Branch_Key,
       t.$3 AS Branch_Name,
       CAST( t.$5 AS DECIMAL(10,2)) AS Budgeted_Hours,
       CAST( t.$6 AS INTEGER) AS Budgeted_Clients,
       CAST( t.$7 AS DECIMAL(20,10)) AS Hours_Served_to_Caregiver_Ratio,
       CAST( t.$8 AS DECIMAL(20,10))  AS Client_to_Caregiver_Ratio,
       CAST( t.$9 AS INTEGER) AS Caregiver_Budget
FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/Files/Budget/Caregiver_Budget_20210830 (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT ) AS t;
SQL
	or_replace = true 
	is_secure = false 
}

