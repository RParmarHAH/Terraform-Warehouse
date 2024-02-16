resource "snowflake_table" "DW_INTEGRATION_DIM_EMPLOYEE_MATCH" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "DIM_EMPLOYEE_MATCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.DIM_EMPLOYEE_MATCH

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
	name = "ORIGINAL_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MASTER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLUSTER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORD_ORDER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_PID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMPLOYEE_ADDRESS2"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMPLOYEE_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_ZIP"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

