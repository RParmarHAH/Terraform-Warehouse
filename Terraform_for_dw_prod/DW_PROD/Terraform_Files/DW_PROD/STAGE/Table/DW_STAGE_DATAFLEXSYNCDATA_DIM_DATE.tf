resource "snowflake_table" "DW_STAGE_DATAFLEXSYNCDATA_DIM_DATE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "DATAFLEXSYNCDATA_DIM_DATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.DATAFLEXSYNCDATA_DIM_DATE

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CALENDAR_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "DATE_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "YEAR"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "QUARTER"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "YEAR_QUARTER"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "MONTH"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "YEAR_MONTH"
	type = "VARCHAR(6)"
	nullable = false
}


column {
	name = "MONTH_NAME"
	type = "VARCHAR(3)"
	nullable = false
}


column {
	name = "DAY_OF_MONTH"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "DAY_OF_WEEK"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "DAY_NAME"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "WEEK_OF_YEAR"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "DAY_OF_YEAR"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "YEAR_DAY"
	type = "VARCHAR(7)"
	nullable = false
}


column {
	name = "WEEKEND_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

