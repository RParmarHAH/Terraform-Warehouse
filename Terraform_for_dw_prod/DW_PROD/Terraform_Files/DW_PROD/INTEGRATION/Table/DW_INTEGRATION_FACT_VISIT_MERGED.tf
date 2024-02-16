resource "snowflake_table" "DW_INTEGRATION_FACT_VISIT_MERGED" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "FACT_VISIT_MERGED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.FACT_VISIT_MERGED CLUSTER BY

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
	name = "VISIT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SCHEDULED_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "INVOICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PAYROLL_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BILLING_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYROLL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULED_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINAL_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ORIGINAL_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SUPERVISOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CHEQUE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLEAN_SHIFT_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "VISIT_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISIT_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISIT_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CANCEL_REASON_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CANCEL_REASON_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CANCEL_REASON_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXCEPTION_REASON_INDICATOR"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "RESOLUTION_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RESOLUTION_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REJECTION_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "REJECTION_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "BILL_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILL_RATE"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "BILL_UNITS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "BILL_UNIT_TYPE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "OVERHEAD_RATE"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "SCHEDULE_TIMEIN"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "SCHEDULE_TIMEOUT"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "SCHEDULE_DURATION"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "ACTUAL_TIMEIN"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "ACTUAL_TIMEOUT"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "ACTUAL_DURATION"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "ADJUSTED_TIMEIN"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "ADJUSTED_TIMEOUT"
	type = "TIME(9)"
	nullable = true
}


column {
	name = "ADJUSTED_DURATION"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "IS_EVV_FLAG"
	type = "VARCHAR(1)"
	nullable = true
	comment = "Record came from EVV feed"
}


column {
	name = "TIMESHEET_TYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TRACKING_ID"
	type = "NUMBER(38,0)"
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
	type = "VARCHAR(100)"
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


column {
	name = "CONFIRMED_FLAG"
	type = "VARCHAR(10)"
	nullable = true
}

}

