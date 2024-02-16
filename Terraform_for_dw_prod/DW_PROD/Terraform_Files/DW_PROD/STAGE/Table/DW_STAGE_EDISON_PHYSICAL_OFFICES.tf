resource "snowflake_table" "DW_STAGE_EDISON_PHYSICAL_OFFICES" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "EDISON_PHYSICAL_OFFICES"
	change_tracking = false
	comment = "SOURCE: https://edisonhhc.com/contact-us/"

column {
	name = "OFFICENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

