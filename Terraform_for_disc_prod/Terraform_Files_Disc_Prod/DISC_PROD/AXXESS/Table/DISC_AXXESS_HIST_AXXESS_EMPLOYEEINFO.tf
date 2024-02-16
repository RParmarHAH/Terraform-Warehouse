resource "snowflake_table" "DISC_AXXESS_HIST_AXXESS_EMPLOYEEINFO" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "HIST_AXXESS_EMPLOYEEINFO"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.HIST_AXXESS_EMPLOYEEINFO

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TITLE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVE_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_LINE_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_ZIPCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_STATECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKING_LOCATION_STATECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_CASE_MANAGER"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

