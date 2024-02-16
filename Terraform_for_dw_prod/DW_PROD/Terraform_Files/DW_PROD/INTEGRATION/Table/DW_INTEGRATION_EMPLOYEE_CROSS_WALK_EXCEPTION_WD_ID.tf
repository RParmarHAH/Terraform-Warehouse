resource "snowflake_table" "DW_INTEGRATION_EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.EMPLOYEE_CROSS_WALK_EXCEPTION_WD_ID

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
	name = "EMPLOYEE_ENTERPRISE_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORKDAY_INTERNAL_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WORKDAY_ID_OF_MAPPING"
	type = "VARCHAR(50)"
	nullable = true
}

}

