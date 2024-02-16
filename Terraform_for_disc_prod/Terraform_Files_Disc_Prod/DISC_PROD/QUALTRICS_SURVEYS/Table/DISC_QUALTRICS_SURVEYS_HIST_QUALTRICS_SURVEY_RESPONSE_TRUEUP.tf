resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_HIST_QUALTRICS_SURVEY_RESPONSE_TRUEUP" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "HIST_QUALTRICS_SURVEY_RESPONSE_TRUEUP"
	change_tracking = false
	comment = "This table is intended to be used for true up process of qualtrics"

column {
	name = "SURVEY_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SURVEY_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LOAD_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SURVEY_JSON"
	type = "VARIANT"
	nullable = true
}

}

