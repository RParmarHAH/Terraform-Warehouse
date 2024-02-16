resource "snowflake_table" "DW_STAGE_TRUSTPOINTDATA_DIM_PAYCODE_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "TRUSTPOINTDATA_DIM_PAYCODE_MAPPING"
	change_tracking = false
	comment = "Map pay codes to categories for use in data extracts"

column {
	name = "PAYCODE_MAPPING_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
	comment = "Abbreviation for the state the code applies to"
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "PAY_CODE_DESCRIPTION"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "PAY_CODE_TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_CODE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
	comment = "Benefits, Bereavement, Bonus, Holiday, On-Call, Overtime, Regular Pay, Reimbursement, Tax, Travel Time, Training, Union Dues, Vacation"
}


column {
	name = "FINANCE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRST_USED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MOST_RECENT_USED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "NUMBER_EMPLOYEES_USED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "BOOLEAN"
	default = "TRUE"
	nullable = false
	comment = "Active or Inactive"
}


column {
	name = "ADMIN_PAY_RATE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FIELD_PAY_RATE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDE_SALARY_PAYRATE_CALC_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDE_FULL_TIME_HOURS_CALC_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

