resource "snowflake_schema" "INTEGRATION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "INTEGRATION"
	comment = "None"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

