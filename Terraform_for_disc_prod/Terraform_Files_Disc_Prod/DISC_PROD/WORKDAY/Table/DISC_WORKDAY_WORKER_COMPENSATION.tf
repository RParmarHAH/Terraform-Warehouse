resource "snowflake_table" "DISC_WORKDAY_WORKER_COMPENSATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "WORKER_COMPENSATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.WORKER_COMPENSATION

    -- Purpose : Discovery Data Population

    -- Project : WORKDAY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_ANNUAL_BASE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_BASE_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BASE_PAY_CURRENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BASE_PAY_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCESSED_TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
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


column {
	name = "FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

