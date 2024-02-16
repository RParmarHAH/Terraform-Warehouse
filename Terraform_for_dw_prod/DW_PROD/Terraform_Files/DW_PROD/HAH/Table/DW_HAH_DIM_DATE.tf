resource "snowflake_table" "DW_HAH_DIM_DATE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_DATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_DATE

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DATE_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CALENDAR_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FIRST_DAY_OF_YEAR"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_DAY_OF_YEAR"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_YEAR_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_YEAR_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "QUARTER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QUARTER_NAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "YEAR_QUARTER"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "FIRST_DAY_OF_QUARTER"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_DAY_OF_QUARTER"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_QUARTER_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_QUARTER_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "MONTH"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "YEAR_MONTH"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "YEAR_MONTH_DESC"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MONTH_NAME"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FIRST_DAY_OF_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_DAY_OF_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_MONTH_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_MONTH_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "MOST_RECENT_4_WEEKS_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "MOST_RECENT_4_WEEKS_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_4_WEEKS_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_4_WEEKS_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_4TH_WEEK_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_4TH_WEEK_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_ROLLING_4_WEEKS_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREVIOUS_ROLLING_4_WEEKS_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "WEEK_OF_YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HAH_CURRENT_WEEK_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "HAH_CURRENT_WEEK_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "HAH_PREVIOUS_WEEK_FIRST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "HAH_PREVIOUS_WEEK_LAST_DAY"
	type = "DATE"
	nullable = true
}


column {
	name = "DAY_OF_YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DAY_OF_MONTH"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DAY_OF_WEEK"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DAY_NAME"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "YEAR_DAY"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "WEEKEND_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOLIDAY_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HAH_HOLIDAY_OBSERVED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISO_YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ISO_WEEK"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ISO_DAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_CURRENT_YEAR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_CURRENT_MONTH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_CURRENT_WEEK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_TODAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALL_STATE_PAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUMULATIVE_WEEK"
	type = "NUMBER(38,0)"
	nullable = true
}

}

