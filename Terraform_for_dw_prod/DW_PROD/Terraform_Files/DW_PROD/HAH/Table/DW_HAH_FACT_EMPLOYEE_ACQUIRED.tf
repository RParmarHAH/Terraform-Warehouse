resource "snowflake_table" "DW_HAH_FACT_EMPLOYEE_ACQUIRED" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_EMPLOYEE_ACQUIRED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_EMPLOYEE_ACQUIRED

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
	name = "EMPLOYEE_ACQUIRED_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "AQUISITION_NAME"
	type = "VARCHAR(50)"
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

}

