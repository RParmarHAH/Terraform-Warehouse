resource "snowflake_table" "DISC_CLEARCARE_WORKERS_COMPENSATION_SAFETYTASK" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "WORKERS_COMPENSATION_SAFETYTASK"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.WORKERS_COMPENSATION_SAFETYTASK

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
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TASK_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CARELOG_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SEND_REMINDER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DATE_DUE"
	type = "DATE"
	nullable = true
}


column {
	name = "DATETIME_REPORTED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "RESOLUTION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SAFETY_RECORD_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RECORDING_URL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "RECORDING_PROCESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUDIO"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ACTIVITY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATETIME_OF_EVENT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16383)"
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

