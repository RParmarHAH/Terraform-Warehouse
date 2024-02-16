resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_PULSE_SURVEY_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "PULSE_SURVEY_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.PULSE_SURVEY_MAPPING

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
	name = "OLD_SURVEY_RESPONSE_HEADER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OLD_RECORD_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "NEW_SURVEY_RESPONSE_HEADER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "NEW_RECORD_ID"
	type = "VARCHAR(32)"
	nullable = true
	comment = "This table is supporting Qualtrics Trueup process and providing mapping between Old and new responseId"
}

}

