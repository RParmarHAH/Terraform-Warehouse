resource "snowflake_table" "DISC_APTITIVE_DEV_RL_OUTPUT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "APTITIVE_DEV"
	name = "RL_OUTPUT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.APTITIVE_DEV.RL_OUTPUT

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
	name = "RECORD_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLUSTER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCORE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "FILENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

