resource "snowflake_table" "DISC_ASR_HIST_ASR_BILLABLESERVICEVISITSREPORT_26_SEP_2023" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_BILLABLESERVICEVISITSREPORT_26_SEP_2023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_BILLABLESERVICEVISITSREPORT_26_SEP_2023

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
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKDAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLABLE_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLABLE_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMER_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_CHECK_IN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_CHECK_OUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_DURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_REQD_HRS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUAL_CHECK_IN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUAL_CHECK_OUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTUAL_DURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYER_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_CODE"
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

