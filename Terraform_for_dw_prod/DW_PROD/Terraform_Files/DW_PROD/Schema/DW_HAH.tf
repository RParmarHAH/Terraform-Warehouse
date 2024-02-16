resource "snowflake_schema" "HAH" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "HAH"
	comment = "Primary schema for data warehouse tables"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

