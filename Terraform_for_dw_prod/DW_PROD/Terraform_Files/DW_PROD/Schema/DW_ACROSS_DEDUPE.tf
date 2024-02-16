resource "snowflake_schema" "ACROSS_DEDUPE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "ACROSS_DEDUPE"
	comment = "Created schema for testing across dedupe. will delete once testing is done -- jigar prajapati"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

