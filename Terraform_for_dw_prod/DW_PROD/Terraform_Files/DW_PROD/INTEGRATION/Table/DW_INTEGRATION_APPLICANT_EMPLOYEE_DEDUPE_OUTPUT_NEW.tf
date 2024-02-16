resource "snowflake_table" "DW_INTEGRATION_APPLICANT_EMPLOYEE_DEDUPE_OUTPUT_NEW" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "APPLICANT_EMPLOYEE_DEDUPE_OUTPUT_NEW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.APPLICANT_EMPLOYEE_DEDUPE_OUTPUT_NEW

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SSN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLIED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRED_DATE_MONTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSTAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLUSTER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RULE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUPE_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

