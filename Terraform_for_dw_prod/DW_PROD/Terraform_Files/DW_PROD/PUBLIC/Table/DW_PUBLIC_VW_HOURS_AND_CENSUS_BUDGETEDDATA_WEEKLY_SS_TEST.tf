resource "snowflake_table" "DW_PUBLIC_VW_HOURS_AND_CENSUS_BUDGETEDDATA_WEEKLY_SS_TEST" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "VW_HOURS_AND_CENSUS_BUDGETEDDATA_WEEKLY_SS_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.VW_HOURS_AND_CENSUS_BUDGETEDDATA_WEEKLY_SS_TEST

    -- Purpose : 

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BUDGET_SERVICE_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
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
	name = "SERVICELINE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BUDGETEDHOURS_WEEKLY"
	type = "NUMBER(27,3)"
	nullable = true
}


column {
	name = "BUDGETEDCLIENTS_WEEKLY"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "BUDGETEDCAREGIVERS_WEEKLY"
	type = "NUMBER(38,12)"
	nullable = true
}

}

