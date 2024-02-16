resource "snowflake_table" "DW_STAGE_PREFERRED_FACT_BRANCH_PAYROLL_PERIODS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "PREFERRED_FACT_BRANCH_PAYROLL_PERIODS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.PREFERRED_FACT_BRANCH_PAYROLL_PERIODS

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
	name = "BRANCH_PAYROLL_PERIODS_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "DETAILED_OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = false
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


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

