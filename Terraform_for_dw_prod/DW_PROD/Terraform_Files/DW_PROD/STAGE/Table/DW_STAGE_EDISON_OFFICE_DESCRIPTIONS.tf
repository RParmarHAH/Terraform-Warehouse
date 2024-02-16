resource "snowflake_table" "DW_STAGE_EDISON_OFFICE_DESCRIPTIONS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "EDISON_OFFICE_DESCRIPTIONS"
	change_tracking = false
	comment = "SOURCE: YOSSI (EDISON CTO) EMAIL"

column {
	name = "OFFICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

