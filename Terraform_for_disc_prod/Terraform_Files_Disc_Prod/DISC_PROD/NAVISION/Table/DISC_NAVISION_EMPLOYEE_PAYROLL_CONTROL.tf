resource "snowflake_table" "DISC_NAVISION_EMPLOYEE_PAYROLL_CONTROL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "NAVISION"
	name = "EMPLOYEE_PAYROLL_CONTROL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.NAVISION.EMPLOYEE_PAYROLL_CONTROL

    -- Purpose : Discovery Data Population

    -- Project : NAVISION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TIMESTAMP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_CONTROL_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MONTHLY_SCHEDULE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAYROLL_POSTING_GROUP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ORDER_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

