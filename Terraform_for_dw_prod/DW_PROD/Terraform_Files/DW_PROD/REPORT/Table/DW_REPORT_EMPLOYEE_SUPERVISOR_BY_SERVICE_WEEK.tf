resource "snowflake_table" "DW_REPORT_EMPLOYEE_SUPERVISOR_BY_SERVICE_WEEK" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "EMPLOYEE_SUPERVISOR_BY_SERVICE_WEEK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.EMPLOYEE_SUPERVISOR_BY_SERVICE_WEEK

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
	name = "SERVICE_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SUPERVISOR_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SUPERVISOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
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

