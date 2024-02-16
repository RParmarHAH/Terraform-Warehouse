resource "snowflake_table" "DW_REPORT_COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.COVID_19_DAILYVISITHOURSCOUNTRECENT4WEEKS

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
	name = "WEEK_OF_YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "WEEK"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(38)"
	nullable = true
}


column {
	name = "EVENTSTATUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CURRENTWEEKHOURS"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "PREVIOUS4THWEEKHOURS"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "ROLLING4WEEKSHOURS"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "PREVIOUSROLLING4WEEKSHOURS"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "PREVIOUSTOPREVIOUSROLLING4WEEKS"
	type = "NUMBER(10,2)"
	nullable = true
}

}

