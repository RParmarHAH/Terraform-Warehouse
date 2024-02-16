resource "snowflake_table" "DISC_CLEARCARE_HIST_AUTH_USER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_AUTH_USER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_AUTH_USER

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
	name = "USERNAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "IS_STAFF"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_SUPERUSER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LAST_LOGIN"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DATE_JOINED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ADDITIONAL_DETAILS"
	type = "VARCHAR(16383)"
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

