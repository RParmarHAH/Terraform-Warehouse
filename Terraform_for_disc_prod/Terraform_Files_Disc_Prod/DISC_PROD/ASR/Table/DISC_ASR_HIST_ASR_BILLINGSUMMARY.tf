resource "snowflake_table" "DISC_ASR_HIST_ASR_BILLINGSUMMARY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_BILLINGSUMMARY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_BILLINGSUMMARY

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PROGRAM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMERNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUAL_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEVISITACTUALID"
	type = "VARCHAR(16777216)"
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
	name = "ETL_INSERTED_DATE"
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

}

