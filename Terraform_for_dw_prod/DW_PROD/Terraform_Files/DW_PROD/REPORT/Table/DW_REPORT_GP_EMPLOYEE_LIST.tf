resource "snowflake_table" "DW_REPORT_GP_EMPLOYEE_LIST" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "GP_EMPLOYEE_LIST"
	change_tracking = false
	comment = "TABLE CREATED FOR ITXEE-1459"

column {
	name = "CURRENT_PAYROLL_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_PAYROLL_SOURCE_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_AMS_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CURRENT_AMS_SOURCE_SYSTEM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "WORKDAY_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MARKET"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(8388608)"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_PAY_CHECK_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_MIGRATED"
	type = "BOOLEAN"
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
	name = "LEGACY_BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}

}

