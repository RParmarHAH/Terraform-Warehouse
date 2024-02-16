resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_BITWISE_EXCEPTIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "BITWISE_EXCEPTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.BITWISE_EXCEPTIONS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "BIT_CODE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "DESC"
	type = "VARCHAR(41)"
	nullable = true
}

}

