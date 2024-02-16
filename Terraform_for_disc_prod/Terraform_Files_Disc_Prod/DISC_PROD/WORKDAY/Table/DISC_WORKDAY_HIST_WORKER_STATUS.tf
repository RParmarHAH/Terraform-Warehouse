resource "snowflake_table" "DISC_WORKDAY_HIST_WORKER_STATUS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "HIST_WORKER_STATUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.HIST_WORKER_STATUS

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
	name = "STAFFING_EVENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STAFFING_EVENT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ORIGINAL_HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HIRE_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PRIMARY_TERMINATION_REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOT_ELIGIBLE_FOR_HIRE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REHIRE"
	type = "BOOLEAN"
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

