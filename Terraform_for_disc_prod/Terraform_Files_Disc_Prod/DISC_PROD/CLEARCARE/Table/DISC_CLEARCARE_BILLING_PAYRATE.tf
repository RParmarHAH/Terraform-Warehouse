resource "snowflake_table" "DISC_CLEARCARE_BILLING_PAYRATE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "BILLING_PAYRATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.BILLING_PAYRATE

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
	name = "NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARE_MANAGER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SCHEDULE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUSTOM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
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
	name = "HAS_CAREGIVERRATESCHEDULE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "META"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ENABLE_TIERED_RATES_BY_CLIENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIERED_CUSTOM"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ENABLE_TIERED_RATES"
	type = "BOOLEAN"
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

