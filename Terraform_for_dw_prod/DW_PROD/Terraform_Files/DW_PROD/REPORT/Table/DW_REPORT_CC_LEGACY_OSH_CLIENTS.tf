resource "snowflake_table" "DW_REPORT_CC_LEGACY_OSH_CLIENTS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CC_LEGACY_OSH_CLIENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CC_LEGACY_OSH_CLIENTS

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PARTNER_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DATE_ARCHIVED"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMPLOYEE_CONCAT_NAME"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "EMPLOYEE_EMAILADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMPLOYEE_PERSONAL_EMAIL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMPLOYEE_PRIMARYPHONENUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_HOME_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_CELL_PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIENT_EMAIL_ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_PRIMARY_PHONE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_GENDER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS1"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS2"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CLIENT_ZIP"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "PARTNER_PATIENT_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RELATIONSHIP_KEY"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "PAYROLL_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DAYS_OF_SERVICE_IN_PERIOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TOTAL_HOURS_SERVED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HC_HOURS_SERVED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HH_HOURS_SERVED"
	type = "NUMBER(38,0)"
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


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARENT_BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NEWLY_CREATED_OR_UPDATED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LAST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ISO_YEAR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ISO_WEEK"
	type = "NUMBER(38,0)"
	nullable = true
}

}

