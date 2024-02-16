resource "snowflake_table" "DW_INTEGRATION_ZENDESK_WH_PAYROLL_MAPPING_TBL" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "ZENDESK_WH_PAYROLL_MAPPING_TBL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.ZENDESK_WH_PAYROLL_MAPPING_TBL

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
	name = "WAREHOUSE_EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZENDESK_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAREHOUSE_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZENDESK_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAREHOUSE_SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WAREHOUSE_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ZENDESK_EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

