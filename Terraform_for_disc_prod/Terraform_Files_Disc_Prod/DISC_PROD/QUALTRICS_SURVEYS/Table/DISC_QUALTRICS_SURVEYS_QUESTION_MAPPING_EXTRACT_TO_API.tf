resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_QUESTION_MAPPING_EXTRACT_TO_API" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "QUESTION_MAPPING_EXTRACT_TO_API"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.QUESTION_MAPPING_EXTRACT_TO_API

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
	name = "OLD_SQID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OLD_QTEXT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NEW_QTEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(50)"
	nullable = true
}

}

