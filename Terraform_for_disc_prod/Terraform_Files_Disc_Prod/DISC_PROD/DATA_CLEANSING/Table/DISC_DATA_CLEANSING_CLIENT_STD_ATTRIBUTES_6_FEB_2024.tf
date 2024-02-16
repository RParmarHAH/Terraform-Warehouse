resource "snowflake_table" "DISC_DATA_CLEANSING_CLIENT_STD_ATTRIBUTES_6_FEB_2024" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "CLIENT_STD_ATTRIBUTES_6_FEB_2024"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.CLIENT_STD_ATTRIBUTES_6_FEB_2024

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
	name = "CLIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "SRC_CLIENT_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "STD_CLIENT_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SRC_CLIENT_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_CLIENT_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_CLIENT_COUNTY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_CLIENT_STATE_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_CLIENT_STATE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STD_CLIENT_STATE_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SRC_CLIENT_ZIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STD_CLIENT_ZIP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STD_CLIENT_ZIP_PLUS_FOUR"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STD_CLIENT_COUNTRY_CODE"
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
	name = "STD_CLIENT_SSN"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_CLIENT_SSN_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "STD_CLIENT_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "SRC_CLIENT_DOB_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_HOME_PHONE"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "STD_CLIENT_HOME_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_CLIENT_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_CELL_PHONE"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "STD_CLIENT_CELL_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_CLIENT_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_WORK_PHONE"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "STD_CLIENT_WORK_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SRC_CLIENT_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_PERSONAL_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STD_CLIENT_PERSONAL_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SRC_CLIENT_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_CLIENT_WORK_EMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STD_CLIENT_WORK_EMAIL"
	type = "VARCHAR(200)"
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

