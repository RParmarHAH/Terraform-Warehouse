resource "snowflake_table" "DW_HAH_DIM_STATE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "DIM_STATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.DIM_STATE

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "STATE_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATE_ISO_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "STATE_ANSI_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "STATE_FIPS"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "COUNTRY_ISO_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "COUNTRY_COMMON_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COUNTRY_OFFICIAL_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SANDATA_AGENCY_ID"
	type = "VARCHAR(25)"
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
	name = "BUDGET_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SYSTEMDESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_EFFECTIVE_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_EFFECTIVE_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLL_BUDGET_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLL_SYSTEMDESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_EFFECTIVE_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_EFFECTIVE_END_DATE"
	type = "DATE"
	nullable = true
}

}

