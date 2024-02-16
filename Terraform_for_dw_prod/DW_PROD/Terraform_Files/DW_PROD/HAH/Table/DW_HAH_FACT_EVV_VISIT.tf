resource "snowflake_table" "DW_HAH_FACT_EVV_VISIT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_EVV_VISIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_EVV_VISIT

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
	name = "VISIT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SCHEDULE_VISIT_INDICATOR"
	type = "VARCHAR(15)"
	nullable = true
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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
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
	name = "CLEAN_SHIFT_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "STATUS_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "STATUS_DESCRIPTION"
	type = "VARCHAR(100)"
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
	name = "EXCEPTION_REASON_FLAG"
	type = "BOOLEAN"
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
	name = "OVERHEAD_RATE"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "SCHEDULE_TIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULE_TIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULE_DURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "ACTUAL_TIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTUAL_TIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACTUAL_DURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "ADJUSTED_TIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJUSTED_TIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADJUSTED_DURATION"
	type = "NUMBER(4,2)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "IS_EVV_FLAG"
	type = "BOOLEAN"
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

}

