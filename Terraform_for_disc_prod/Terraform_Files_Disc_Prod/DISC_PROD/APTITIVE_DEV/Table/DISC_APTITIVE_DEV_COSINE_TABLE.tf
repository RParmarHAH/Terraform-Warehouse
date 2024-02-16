resource "snowflake_table" "DISC_APTITIVE_DEV_COSINE_TABLE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "APTITIVE_DEV"
	name = "COSINE_TABLE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.APTITIVE_DEV.COSINE_TABLE

    -- Purpose : Discovery Data Population

    -- Project : APTITIVE_DEV

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_ID_1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORD_ID_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONFIDENCE_SCORE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

