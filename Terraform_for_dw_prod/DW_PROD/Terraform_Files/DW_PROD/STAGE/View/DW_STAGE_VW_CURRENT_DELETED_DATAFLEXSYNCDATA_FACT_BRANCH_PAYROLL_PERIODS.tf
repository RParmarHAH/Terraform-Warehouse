resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_DATAFLEXSYNCDATA_FACT_BRANCH_PAYROLL_PERIODS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_DATAFLEXSYNCDATA_FACT_BRANCH_PAYROLL_PERIODS"
	statement = <<-SQL
	 SELECT MD5( CAST( br.Branch_Key AS VARCHAR)|| CAST( pp.CheckDate AS VARCHAR)||'AppBaseData'||'5'||'1900-01-01') AS Branch_Payroll_Periods_Key
FROM HAH.DIM_Branch AS br
JOIN DISC_${var.SF_ENVIRONMENT}.AppBaseData.PayrollPeriodGroups ppg ON br.Office_State_Code = ppg.StateCode
INNER JOIN DISC_${var.SF_ENVIRONMENT}.AppBaseData.PayrollPeriods pp ON ppg.GroupName = pp.GroupName
WHERE BR.PARENT_FLAG=1
  AND BR.SOURCE_SYSTEM_ID = 3
  AND (BR.ETL_LAST_UPDATED_DATE >= '1900-01-01'
    OR PPG.ETL_LAST_UPDATED_DATE >= '1900-01-01'
    OR PP.ETL_LAST_UPDATED_DATE >= '1900-01-01')
  AND 1 = 0 -- Do not delete any Pay Periods
;
SQL
	or_replace = true 
	is_secure = false 
}

