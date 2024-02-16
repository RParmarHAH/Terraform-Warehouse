resource "snowflake_table" "DW_REPORT_GP_CROSSWALK_LIST" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "GP_CROSSWALK_LIST"
	change_tracking = false
	comment = "TABLE CREATED FOR ITXEE-1463"

column {
	name = "WORKDAY_INTERNAL_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CURRENT_PAYROLL_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CURRENT_PAYROLL_SOURCE_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME_FROM_CROSSWALK"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAST_NAME_FROM_CROSSWALK"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN_FROM_CROSSWALK"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "LEGACY_PAYROLL_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LEGACY_PAYROLL_SOURCE_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_MIGRATED"
	type = "BOOLEAN"
	nullable = true
}

}

