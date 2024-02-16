resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_QUALTRICS_CLIENT_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "QUALTRICS_CLIENT_MAPPING"
	change_tracking = false
	comment = "This structure used to map DW_PROD.HAH.DIM_SURVEY_RESPONSE_HEADER Client Key having length < 32 with \r\nDW_PROD.INTEGRATION.DIM_CLIENT_MERGED  Client_key using Original Client Number"

column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

