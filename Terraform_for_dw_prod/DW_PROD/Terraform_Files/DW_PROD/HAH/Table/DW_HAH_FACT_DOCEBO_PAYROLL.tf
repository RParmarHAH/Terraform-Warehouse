resource "snowflake_table" "DW_HAH_FACT_DOCEBO_PAYROLL" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_DOCEBO_PAYROLL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_DOCEBO_PAYROLL

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
	name = "PAYROLL_BATCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLL_GROUP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_PAYROLL_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "USER_UNIQUE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COURSE_UNIQUE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREDIT_HOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAY_PERIOD_BEGIN_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAY_PERIOD_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPPLEMENT_DATA"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
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

