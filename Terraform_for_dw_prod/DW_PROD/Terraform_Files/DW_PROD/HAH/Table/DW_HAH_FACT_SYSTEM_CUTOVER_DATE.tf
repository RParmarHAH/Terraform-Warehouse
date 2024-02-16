resource "snowflake_table" "DW_HAH_FACT_SYSTEM_CUTOVER_DATE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_SYSTEM_CUTOVER_DATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_SYSTEM_CUTOVER_DATE

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
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_DATE"
	type = "DATE"
	nullable = true
}

}

