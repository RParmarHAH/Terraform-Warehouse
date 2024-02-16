resource "snowflake_table" "DW_HAH_SALIMAH_Q1_CLIENTS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "SALIMAH_Q1_CLIENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.SALIMAH_Q1_CLIENTS

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
	name = "CLIENT_KEY"
	type = "VARCHAR(50)"
	nullable = true
}

}

