resource "snowflake_schema" "REPORT_BKCP2401" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "REPORT_BKCP2401"
	comment = "Schema for pre-calculated tables used for reporting"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

