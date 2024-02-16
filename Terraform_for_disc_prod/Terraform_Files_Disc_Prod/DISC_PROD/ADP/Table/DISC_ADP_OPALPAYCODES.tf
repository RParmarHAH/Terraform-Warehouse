resource "snowflake_table" "DISC_ADP_OPALPAYCODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ADP"
	name = "OPALPAYCODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ADP.OPALPAYCODES

    -- Purpose : Discovery Data Population

    -- Project : ADP

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PAY_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_CODE_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAY_CODE_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}

}

