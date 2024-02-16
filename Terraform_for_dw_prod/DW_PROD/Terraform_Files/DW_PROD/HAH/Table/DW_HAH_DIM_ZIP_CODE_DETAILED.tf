resource "snowflake_table" "DW_HAH_DIM_ZIP_CODE_DETAILED" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_ZIP_CODE_DETAILED"
	change_tracking = false
	comment = "SOURCE : https://simplemaps.com/data/us-zips"

column {
	name = "ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LNG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZCTA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_ZCTA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POPULATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DENSITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY_FIPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY_WEIGHTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY_NAMES_ALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COUNTY_FIPS_ALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPRECISE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MILITARY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

