resource "snowflake_table" "DISC_AXXESS_AXXESS_HC_EMPLOYEEINFO_20231110" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_HC_EMPLOYEEINFO_20231110"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_HC_EMPLOYEEINFO_20231110

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
	name = "WORKER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKER_FIRSTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKER_LASTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_LINE1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_LINE2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREDENTIALS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEMENT_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
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

