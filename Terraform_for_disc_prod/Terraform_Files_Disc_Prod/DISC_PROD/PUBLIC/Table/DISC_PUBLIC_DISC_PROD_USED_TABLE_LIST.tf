resource "snowflake_table" "DISC_PUBLIC_DISC_PROD_USED_TABLE_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DISC_PROD_USED_TABLE_LIST"
	change_tracking = false
	comment = "02112023 - RSUTHAR/KDHOKAI WE CREATE THIS TABLE TO STORE ALL USED-UNUSED TABLE LIST"

column {
	name = "SOURCESYSTEM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "HIST_TABLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TABLE_NAME"
	type = "VARCHAR(3000)"
	nullable = true
}


column {
	name = "ISUSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISUSEDINDEV"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISUSEDINPROD"
	type = "BOOLEAN"
	nullable = true
}

}

