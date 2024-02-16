resource "snowflake_table" "DW_STAGE_CLEARCARE_DIM_VISIT_STATUS_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "CLEARCARE_DIM_VISIT_STATUS_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.CLEARCARE_DIM_VISIT_STATUS_MAPPING

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "VISIT_STATUS_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(2,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DERIVED_DISC_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DISC_SCHEDULE_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DISC_VISIT_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DISC_INVOICE_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DISC_PAYROLL_STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCHEDULE_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "VISIT_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISIT_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISIT_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVOICE_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CONFIRMED_FLAG"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CONSISTENT_FLAG"
	type = "VARCHAR(10)"
	nullable = true
}

}

