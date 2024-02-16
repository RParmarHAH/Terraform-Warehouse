resource "snowflake_table" "DISC_CLEARCARE_SCHEDULES_SHIFT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "SCHEDULES_SHIFT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.SCHEDULES_SHIFT

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SCHEDULE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CAREGIVER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED_OLD"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "PAY_RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_RATE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_RATE_CUSTOM_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_RATE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_RATE_CUSTOM_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PARENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UNIQUE_HASH"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SCHEDULED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILL_PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTHORIZATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REQUIRE_CAREGIVER_CONFIRMATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IN_FACILITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RATE_CATEGORY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "META"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BILL_TIERED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FCFS_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE_CATEGORY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_TIERED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SHIFT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
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

