resource "snowflake_table" "DW_INTEGRATION_DF_CCSI_VISIT_DEDUPE_MERGED" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "DF_CCSI_VISIT_DEDUPE_MERGED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.DF_CCSI_VISIT_DEDUPE_MERGED

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
	name = "DF_VISIT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DF_CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DF_CLIENT_PID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DF_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DF_SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CCSI_VISIT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CCSI_CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CCSI_CLIENT_PID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CCSI_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CCSI_SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

