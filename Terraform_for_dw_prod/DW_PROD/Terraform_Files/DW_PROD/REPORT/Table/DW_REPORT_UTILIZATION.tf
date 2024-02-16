resource "snowflake_table" "DW_REPORT_UTILIZATION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "UTILIZATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.UTILIZATION

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PERIOD_BEGIN_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "ORIGINAL_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SUPERVISOR_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "ORIGINAL_CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(40)"
	nullable = false
}


column {
	name = "VISITS_SCHEDULED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISITS_COMPLETED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISITS_CANCELLED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISITS_IN_REVIEW"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISITS_MISSED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISITS_RESCHEDULED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "FUTURE_VISITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "FUTURE_CANCELLED_VISITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "FUTURE_HOLD_VISITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HOURS_SCHEDULED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_CANCELLED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOURS_IN_REVIEW"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOURS_MISSED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOURS_RESCHEDULED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "FUTURE_HOURS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "FUTURE_HOURS_NO_CAREGIVER"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "FUTURE_CANCELLED_HOURS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "FUTURE_HOLD_HOURS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOURS_BILLED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_NON_ADJUSTED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "UTILIZATION"
	type = "NUMBER(38,9)"
	nullable = true
}


column {
	name = "OVER_AUTHED"
	type = "NUMBER(1,0)"
	nullable = false
}


column {
	name = "OVER_AUTHED_ADJUSTED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "OVER_AUTHED_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "OVER_AUTHED_HOURS_ADJUSTED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "SERVED_WITHOUT_AUTH"
	type = "NUMBER(1,0)"
	nullable = false
}


column {
	name = "VISITS_ALL"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "VISITS_CLEAN_SHIFTS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "VISITS_NEED_MAINTENANCE"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "CLIENT_SERVED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ABSOLUTE_FIRST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ABSOLUTE_LAST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "NPS"
	type = "NUMBER(38,0)"
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

}

