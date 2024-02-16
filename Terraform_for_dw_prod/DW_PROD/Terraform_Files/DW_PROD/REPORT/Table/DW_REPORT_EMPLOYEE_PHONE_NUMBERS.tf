resource "snowflake_table" "DW_REPORT_EMPLOYEE_PHONE_NUMBERS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "EMPLOYEE_PHONE_NUMBERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.EMPLOYEE_PHONE_NUMBERS

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SYSTEM_NAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "FULL_BRANCH_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(55)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(55)"
	nullable = true
}


column {
	name = "EMP_PHONE1"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMP_PHONE2"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMP_PHONE3"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LATEST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_CHECK_DATE"
	type = "DATE"
	nullable = true
}

}

