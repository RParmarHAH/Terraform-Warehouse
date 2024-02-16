resource "snowflake_table" "DW_PUBLIC_UTI_UPDATED_2" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "UTI_UPDATED_2"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.UTI_UPDATED_2

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
	name = "PERIOD_BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(20)"
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
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SUPERVISOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ABSOLUTE_FIRST_SERVICE_DATE"
	type = "DATE"
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
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PARTNER_CODE"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISITS_SCHEDULED"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "VISITS_COMPLETED"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "VISITS_CANCELLED"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "VISITS_IN_REVIEW"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "VISITS_MISSED"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "VISITS_RESCHEDULED"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "FUTURE_VISITS"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "FUTURE_CANCELLED_VISITS"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "FUTURE_HOLD_VISITS"
	type = "NUMBER(30,0)"
	nullable = true
}


column {
	name = "HOURS_SCHEDULED"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_CANCELLED"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "HOURS_IN_REVIEW"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "HOURS_MISSED"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "HOURS_RESCHEDULED"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "FUTURE_HOURS"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "FUTURE_HOURS_NO_CAREGIVER"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "FUTURE_CANCELLED_HOURS"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "FUTURE_HOLD_HOURS"
	type = "NUMBER(30,2)"
	nullable = true
}


column {
	name = "HOURS_BILLED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED_NON_ADJUSTED"
	type = "NUMBER(38,12)"
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
	nullable = true
}


column {
	name = "OVER_AUTHED_ADJUSTED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "OVER_AUTHED_HOURS"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "OVER_AUTHED_HOURS_ADJUSTED"
	type = "NUMBER(38,12)"
	nullable = true
}


column {
	name = "SERVED_WITHOUT_AUTH"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "VISITS_ALL"
	type = "NUMBER(30,0)"
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
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
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
	name = "ETL_UPDATED_DATE"
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
	name = "ABSOLUTE_LAST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "NPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}

}

