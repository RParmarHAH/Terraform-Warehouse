resource "snowflake_table" "DISC_DATA_CLEANSING_EMPLOYEE_SRC_ATTRIBUTES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "EMPLOYEE_SRC_ATTRIBUTES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.EMPLOYEE_SRC_ATTRIBUTES

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
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_STATE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_ZIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_MIN_ACTIVITY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_MAX_ACTIVITY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_ADDRESS_PROCESSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_SSN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_HOME_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_CELL_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_WORK_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_PERSONAL_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_WORK_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_SSN_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_DOB_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG"
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

