resource "snowflake_table" "DW_PUBLIC_DATAFLEXSYNCDATA_FACT_VISIT_BCKP_08092023" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DATAFLEXSYNCDATA_FACT_VISIT_BCKP_08092023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.DATAFLEXSYNCDATA_FACT_VISIT_BCKP_08092023

    -- Purpose : 

    -- Project : PUBLIC

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
	nullable = false
}


column {
	name = "REPORT_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SCHEDULED_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = false
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
	name = "SERVICE_DATE"
	type = "DATE"
	nullable = false
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
	name = "CLIENT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
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
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
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
	nullable = false
}


column {
	name = "SCHEDULE_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_DESCRIPTION"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "VISIT_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISIT_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISIT_STATUS_DESCRIPTION"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_DESCRIPTION"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_DESCRIPTION"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "CANCEL_REASON_CODE"
	type = "VARCHAR(20)"
	nullable = true
	comment = "Reason code for schedule cancellation"
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
	type = "VARCHAR(10)"
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
	comment = "R = Regular, U = Make up, M = ?"
}


column {
	name = "TRACKING_ID"
	type = "NUMBER(38,0)"
	nullable = true
	comment = "This an ID used by Chen"
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
	name = "CONFIRMED_FLAG"
	type = "VARCHAR(10)"
	nullable = true
}

}

