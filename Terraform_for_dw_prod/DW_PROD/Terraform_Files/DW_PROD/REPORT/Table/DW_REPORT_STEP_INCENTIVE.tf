resource "snowflake_table" "DW_REPORT_STEP_INCENTIVE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "STEP_INCENTIVE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.STEP_INCENTIVE

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
	name = "REGION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STEP"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HRS_GOAL_BIWEEKLY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FLAT_INCREASE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REGION_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_PERIOD_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAY_PERIOD_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAY_PERIOD_CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURS_SERVED_EXEC_OPS_HOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS_SERVED_EXEC_OPS_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS_SERVED_OPS_PERF_HOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS_SERVED_OPS_PERF_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERIOD_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIOD_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CHECK_DATE"
	type = "DATE"
	nullable = true
}

}

