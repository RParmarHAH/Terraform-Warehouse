resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_GATOR_OLD_EXTERNAL_ID" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "GATOR_OLD_EXTERNAL_ID"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.GATOR_OLD_EXTERNAL_ID

    -- Purpose : Discovery Data Population

    -- Project : QUALTRICS_SURVEYS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "QUESTION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORD_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

