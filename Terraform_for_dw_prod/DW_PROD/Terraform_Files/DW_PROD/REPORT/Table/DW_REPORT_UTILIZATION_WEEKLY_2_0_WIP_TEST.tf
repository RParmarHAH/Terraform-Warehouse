resource "snowflake_table" "DW_REPORT_UTILIZATION_WEEKLY_2_0_WIP_TEST" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "UTILIZATION_WEEKLY_2_0_WIP_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.UTILIZATION_WEEKLY_2_0_WIP_TEST

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
	name = "SERVICE_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "BILL_UNIT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SERVICE_END_OF_WEEK"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
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
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARTNER_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NON_STANDARD_UNITS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITS_ALL"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_SCHEDULED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOURS_SERVED_ALL"
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
	name = "HOURS_RESCHEDULED"
	type = "NUMBER(18,2)"
	nullable = true
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
	name = "VISITS_RESCHEDULED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_NON_ADJUSTED"
	type = "NUMBER(18,0)"
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
	name = "VISITS_CLEAN_SHIFTS"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "VISITS_NEED_MAINTENANCE"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "HOURS_SERVED_WHERE_AUTH_EXISTS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLIENT_SERVED_FLAG"
	type = "BOOLEAN"
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
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "CLIENT_ACQUIRED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_ACQUISITION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITS_COMPLETED_VISIT_BASED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISITS_COMPLETED_TIME_BASED"
	type = "NUMBER(18,3)"
	nullable = true
}


column {
	name = "HOURS_SERVED_VISIT"
	type = "NUMBER(18,3)"
	nullable = true
}


column {
	name = "HOURS_SERVED_TIME_BASED"
	type = "NUMBER(18,3)"
	nullable = true
}


column {
	name = "AUTH_UNIT_TYPE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PARTNER_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "AUTH_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AUTH_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "NUMBER_OF_DAYS"
	type = "NUMBER(18,0)"
	nullable = true
}

}

