resource "snowflake_table" "DW_REPORT_TOP_OFFENDERS_EXCEPTION_DETAILS_BY_WEEK" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "TOP_OFFENDERS_EXCEPTION_DETAILS_BY_WEEK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.TOP_OFFENDERS_EXCEPTION_DETAILS_BY_WEEK

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
	name = "SERVICE_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXCEPTION_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXCEPTION_DESC"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TOTAL_VISITS_WITH_EXCEPTIONS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CATEGORY_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(200)"
	nullable = true
}

}

