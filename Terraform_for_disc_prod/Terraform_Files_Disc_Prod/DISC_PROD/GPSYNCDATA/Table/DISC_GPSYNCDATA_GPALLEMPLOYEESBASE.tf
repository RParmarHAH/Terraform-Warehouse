resource "snowflake_table" "DISC_GPSYNCDATA_GPALLEMPLOYEESBASE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "GPALLEMPLOYEESBASE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "WORK_STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "IS_ADMIN"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CONTRACT_TYPE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "LAST_CHECK_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ADDRESS_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "ADDRESS3"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(29)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SHORT_EMPLOYEE_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "GENDER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DOB"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BENEFIT_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TERMINATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GENDER_TEXT"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "ETHICS"
	type = "VARCHAR(35)"
	nullable = true
}


column {
	name = "SUTA_STATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "VACATION_AVAILABLE"
	type = "NUMBER(17,6)"
	nullable = true
}


column {
	name = "SICK_AVAILABLE"
	type = "NUMBER(17,6)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "JOB_DESCRIPTION"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "PHONE_NUMBER_2"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CLASS_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ETHICS_CODE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "WORKERS_COMP"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "REASON_TO_TERM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAST_DAY_WORKED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFICE_STATE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "OFFICE_NO"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REPLACEMENTS"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "MARITAL_STATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MARITAL_STATUS_TEXT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYMENT_TYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYMENT_TYPE_TEXT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FIRST_CHECK_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VACATION_ACCRUED"
	type = "NUMBER(17,6)"
	nullable = true
}


column {
	name = "SICK_ACCRUED"
	type = "NUMBER(17,6)"
	nullable = true
}


column {
	name = "DEPARTMENT_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PTO_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PERSONAL_EMAIL"
	type = "VARCHAR(250)"
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

}

