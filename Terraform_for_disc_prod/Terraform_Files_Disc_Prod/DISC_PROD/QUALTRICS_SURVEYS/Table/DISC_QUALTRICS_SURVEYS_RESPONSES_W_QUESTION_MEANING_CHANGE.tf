resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_RESPONSES_W_QUESTION_MEANING_CHANGE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "RESPONSES_W_QUESTION_MEANING_CHANGE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.RESPONSES_W_QUESTION_MEANING_CHANGE

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
	name = "QUESTION_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(71)"
	nullable = true
}

}

