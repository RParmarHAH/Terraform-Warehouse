resource "snowflake_table" "DISC_CLEARCARE_OPEN_SHIFTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "OPEN_SHIFTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.OPEN_SHIFTS

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
	name = "ISINSTANCE"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SCHEDULE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SHIFT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LOCATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
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

