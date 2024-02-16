resource "snowflake_table" "DISC_QUALTRICS_SURVEYS_QUALTRICS_SURVEY_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	name = "QUALTRICS_SURVEY_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_LIST

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
	name = "LOAD_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SURVEY_LIST_JSON"
	type = "VARIANT"
	nullable = true
}

}

