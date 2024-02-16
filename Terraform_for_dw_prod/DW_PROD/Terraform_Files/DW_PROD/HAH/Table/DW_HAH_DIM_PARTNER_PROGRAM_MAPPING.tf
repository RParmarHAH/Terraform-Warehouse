resource "snowflake_table" "DW_HAH_DIM_PARTNER_PROGRAM_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_PARTNER_PROGRAM_MAPPING"
	change_tracking = false
	comment = "Facilitates a mapping between the Health Navigator Partner program and its associated partners, requiring manual maintenance."

column {
	name = "PARTNER_NAME"
	type = "VARCHAR(200)"
	nullable = false
}


column {
	name = "PARTNER_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "PROGRAM_NAME"
	type = "VARCHAR(200)"
	nullable = false
}


column {
	name = "PROGRAM_CODE"
	type = "VARCHAR(200)"
	nullable = false
}


column {
	name = "IS_ACTIVE"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}

}

