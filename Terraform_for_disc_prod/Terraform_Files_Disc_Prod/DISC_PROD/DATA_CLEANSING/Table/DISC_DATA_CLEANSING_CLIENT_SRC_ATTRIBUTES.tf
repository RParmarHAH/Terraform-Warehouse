resource "snowflake_table" "DISC_DATA_CLEANSING_CLIENT_SRC_ATTRIBUTES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "CLIENT_SRC_ATTRIBUTES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES

    -- Purpose : Discovery Data Population

    -- Project : DATA_CLEANSING

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_CLIENT_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SRC_CLIENT_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_CLIENT_STATE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_CLIENT_ZIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_CLIENT_MIN_ACTIVITY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_CLIENT_MAX_ACTIVITY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_CLIENT_ADDRESS_PROCESSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_SSN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_CLIENT_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_CLIENT_HOME_PHONE"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "SRC_CLIENT_CELL_PHONE"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "SRC_CLIENT_WORK_PHONE"
	type = "VARCHAR(110)"
	nullable = true
}


column {
	name = "SRC_CLIENT_PERSONAL_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_CLIENT_WORK_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_CLIENT_SSN_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_DOB_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG"
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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}

}

