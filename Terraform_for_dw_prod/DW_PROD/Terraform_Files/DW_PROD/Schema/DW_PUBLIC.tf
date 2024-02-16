resource "snowflake_schema" "PUBLIC" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "PUBLIC"
	comment = "None"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

