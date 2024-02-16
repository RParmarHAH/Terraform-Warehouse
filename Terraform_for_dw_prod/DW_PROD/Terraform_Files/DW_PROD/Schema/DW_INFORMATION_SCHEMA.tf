resource "snowflake_schema" "INFORMATION_SCHEMA" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "INFORMATION_SCHEMA"
	comment = "Views describing the contents of schemas in this database"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

