resource "snowflake_table" "DW_INTEGRATION_EMPLOYEE_CROSS_WALK_CHANGE_LOG" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "EMPLOYEE_CROSS_WALK_CHANGE_LOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_CHANGE_LOG

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ENTERPRISE_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "CHANGE_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "KEY_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AMS / PAYROLL_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LATEST_DISC_LAYER_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LATEST_INTEGRATION_LAYER_KEY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PREVIOUSLY MAPPED PAYROLL / AMS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OLD_MAPPED_APPLICANT"
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

}

