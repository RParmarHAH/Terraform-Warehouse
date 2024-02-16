resource "snowflake_table" "DW_REPORT_HOURS_AND_CENSUS_BY_PAYROLL_DATE_WEEKLY_1_0" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "HOURS_AND_CENSUS_BY_PAYROLL_DATE_WEEKLY_1_0"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.HOURS_AND_CENSUS_BY_PAYROLL_DATE_WEEKLY_1_0

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
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_KEY_DATA"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
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

}

