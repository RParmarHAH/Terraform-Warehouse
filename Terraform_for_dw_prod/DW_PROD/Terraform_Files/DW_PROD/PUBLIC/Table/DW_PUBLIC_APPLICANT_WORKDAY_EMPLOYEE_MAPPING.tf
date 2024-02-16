resource "snowflake_table" "DW_PUBLIC_APPLICANT_WORKDAY_EMPLOYEE_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "APPLICANT_WORKDAY_EMPLOYEE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.PUBLIC.APPLICANT_WORKDAY_EMPLOYEE_MAPPING

    -- Purpose : 

    -- Project : PUBLIC

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICANT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICANT_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKDAY_ID"
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
	name = "EMPLOYEE_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

