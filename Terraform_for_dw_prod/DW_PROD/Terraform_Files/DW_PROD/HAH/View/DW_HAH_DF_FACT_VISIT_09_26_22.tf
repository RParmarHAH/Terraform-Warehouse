resource "snowflake_view" "DW_HAH_DF_FACT_VISIT_09_26_22" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DF_FACT_VISIT_09_26_22"
	statement = <<-SQL
	 
SELECT V.* FROM (DW_Prod.HAH.FACT_Visit AT (OFFSET => -60*60*12)) V
INNER JOIN DW_Prod.HAH.DIM_Branch AS b ON V.Branch_key = b.Branch_Key
WHERE b.Office_State_Code = 'IL'
AND v.Service_Date >= CAST( '2022-08-28' AS DATE)
--GROUP BY 1
ORDER BY 1, 2;
SQL
	or_replace = true 
	is_secure = false 
}

