resource "snowflake_table" "DW_STAGE_WORKDAY_DIM_APPLICANT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "WORKDAY_DIM_APPLICANT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.WORKDAY_DIM_APPLICANT

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "APPLICANT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "APPLICANT_ID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "MOBILE_PHONE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HOME_PHONE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ADDRESS_LINE_2"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "POSTAL"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "REFERRER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CATEGORIES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "REFERENCES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LINKEDIN"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "WEBSITE_BLOG_PORTFOLIO"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "TWITTER"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EARLIEST_START_DATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AVAILABLE_WEEKENDS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AVAILABLE_EVENINGS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AVAILABLE_OVERTIME"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LANGUAGES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DRIVERS_LICENSE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COMMERCIAL_DRIVERS_LICENSE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CAN_RELOCATE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CITIZEN_EMPLOYMENT_STATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "HIGHEST_EDUCATION"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "COLLEGE_UNIVERSITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "GRADE_POINT_AVG"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "AGE_18"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PILOT_FLIGHT_HOURS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "PILOT_GRADE_RATINGS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "FELONY_CONVICTION"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "FELONY_EXPLANATION"
	type = "VARCHAR(1500)"
	nullable = true
}


column {
	name = "EEO_CATEGORY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EEO_SEX"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EEO_RACE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EEO_ETHNICITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EEO_DISABILITY"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EEOC_VETERAN_STATUS"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "EEOC_DISABILITY_STATUS"
	type = "VARCHAR(255)"
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


column {
	name = "LINKED_ID"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LOCATION_HIERARCHY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(255)"
	nullable = true
}

}

