resource "snowflake_table" "DW_REPORT_HOURS_AND_CENSUS_BILLED_HOURS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "HOURS_AND_CENSUS_BILLED_HOURS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.HOURS_AND_CENSUS_BILLED_HOURS

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
	name = "PERIOD_BEGIN_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "PERIOD_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SUPERVISOR_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_KEY_DATA"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(40)"
	nullable = false
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "HOURS_SERVED_WHERE_AUTH_EXISTS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_BILLED_WHERE_AUTH_EXISTS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_WHERE_AUTH_EXISTS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_SERVED_ALL"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_BILLED_ALL"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_ALL"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "INCLUDE_FOR_CLIENTS"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "INCLUDE_FOR_HOURS"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(10)"
	nullable = false
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

