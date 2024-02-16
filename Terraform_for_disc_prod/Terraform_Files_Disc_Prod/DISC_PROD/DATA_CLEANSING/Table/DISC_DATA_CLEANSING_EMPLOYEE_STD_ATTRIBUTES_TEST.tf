resource "snowflake_table" "DISC_DATA_CLEANSING_EMPLOYEE_STD_ATTRIBUTES_TEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "EMPLOYEE_STD_ATTRIBUTES_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.EMPLOYEE_STD_ATTRIBUTES_TEST

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
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "SRC_EMPLOYEE_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_COUNTY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_STATE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_STATE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_STATE_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_ZIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_ZIP_PLUS_FOUR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_COUNTRY_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ADDRESS_NUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STREET"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LABEL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "POINTS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "RELEVANCE"
	type = "FLOAT"
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
	name = "STD_EMPLOYEE_SSN"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_SSN_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_DOB_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_HOME_PHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_HOME_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_CELL_PHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_CELL_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_WORK_PHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_WORK_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_PERSONAL_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_PERSONAL_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_EMPLOYEE_WORK_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STD_EMPLOYEE_WORK_EMAIL"
	type = "VARCHAR(200)"
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
	name = "METHD_UPD"
	type = "VARCHAR(500)"
	nullable = true
}

}

