resource "snowflake_table" "DW_INTEGRATION_DF_CCSI_VISIT_DEDUPE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "DF_CCSI_VISIT_DEDUPE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.DF_CCSI_VISIT_DEDUPE

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
	name = "VISIT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SERVICE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_PID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_HOME_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_CELL_PHONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLUSTER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

