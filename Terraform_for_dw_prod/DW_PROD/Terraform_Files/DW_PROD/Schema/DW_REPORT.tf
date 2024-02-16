resource "snowflake_schema" "REPORT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "REPORT"
	comment = "Schema for pre-calculated tables used for reporting"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

