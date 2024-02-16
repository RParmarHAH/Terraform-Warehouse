resource "snowflake_table" "DW_HAH_CLIENT_SATISFACTION_SURVEY_Q3_CLIENTS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "CLIENT_SATISFACTION_SURVEY_Q3_CLIENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.CLIENT_SATISFACTION_SURVEY_Q3_CLIENTS

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

