resource "snowflake_table" "DW_REPORT_CLIENTS_REACTIVATED" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENTS_REACTIVATED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENTS_REACTIVATED

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
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "FIRST_SERVICE_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "LAST_SERVICE_DATE_INPERIOD"
	type = "DATE"
	nullable = false
}


column {
	name = "CURRENT_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "ORIGINAL_CURRENT_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CURRENT_SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
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

