resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CONFIGURATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CONFIGURATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CONFIGURATION

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CONFIG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "INSERTED_DATE"
	type = "DATE"
	nullable = true
}

}

