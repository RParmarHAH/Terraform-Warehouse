resource "snowflake_table" "DW_REPORT_COVID_19_DAILYVISITHOURSCOUNT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "COVID_19_DAILYVISITHOURSCOUNT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.COVID_19_DAILYVISITHOURSCOUNT

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
	name = "WEEKDAY"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DAYOFWEEK"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_DATE"
	type = "DATE"
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
	name = "PREVIOUSWEEKHOURS"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "CURRENTWEEKTOTALVISIT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREVIOUSWEEKTOTALVISIT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

