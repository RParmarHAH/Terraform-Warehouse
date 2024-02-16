resource "snowflake_schema" "STAGE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "STAGE"
	comment = "None"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

