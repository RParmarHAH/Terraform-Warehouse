resource "snowflake_table" "DW_REPORT_COVID_19_ON_HOLD_CLIENTS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "COVID_19_ON_HOLD_CLIENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.COVID_19_ON_HOLD_CLIENTS

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
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "OFFICE_NUMBER"
	type = "VARCHAR(5)"
	nullable = false
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ON_HOLD_START_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "CLIENT_COUNT"
	type = "NUMBER(20,0)"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(38)"
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

