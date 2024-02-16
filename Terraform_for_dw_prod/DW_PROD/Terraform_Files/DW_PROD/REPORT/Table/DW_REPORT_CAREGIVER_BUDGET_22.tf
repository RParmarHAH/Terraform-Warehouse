resource "snowflake_table" "DW_REPORT_CAREGIVER_BUDGET_22" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CAREGIVER_BUDGET_22"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CAREGIVER_BUDGET_22

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
	name = "STATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JAN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "FEB"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MAR"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "APR"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MAY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JUN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "JUL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AUG"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SEP"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "OCT"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "NOV"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DEC"
	type = "VARCHAR(255)"
	nullable = true
}

}

