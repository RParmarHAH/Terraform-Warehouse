resource "snowflake_table" "DW_REPORT_MATRIXCARE_GP_EMPLOYEE_WITH_PAYCODE_DETAILS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "MATRIXCARE_GP_EMPLOYEE_WITH_PAYCODE_DETAILS"
	change_tracking = false
	comment = "TABLE CREATED FOR ITXEE-1461"

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
	name = "CURRENT_BRANCH_NAME"
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
	name = "MATRIXCARE_SKILL_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MATRIXCARE_RATE_BRANCH"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MATRIXCARE_PAY_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "MATRIXCARE_PAY_RATE"
	type = "NUMBER(18,2)"
	nullable = true
}

}

