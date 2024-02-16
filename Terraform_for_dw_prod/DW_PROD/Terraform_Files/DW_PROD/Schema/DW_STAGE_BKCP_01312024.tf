resource "snowflake_schema" "STAGE_BKCP_01312024" {
	database = "DW_${var.SF_ENVIRONMENT}"
	name = "STAGE_BKCP_01312024"
	comment = "None"
	is_transient = false
	is_managed = false
	data_retention_days  = 1
}

