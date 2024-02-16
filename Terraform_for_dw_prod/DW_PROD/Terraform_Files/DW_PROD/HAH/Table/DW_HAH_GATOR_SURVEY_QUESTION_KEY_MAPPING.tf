resource "snowflake_table" "DW_HAH_GATOR_SURVEY_QUESTION_KEY_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "GATOR_SURVEY_QUESTION_KEY_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.GATOR_SURVEY_QUESTION_KEY_MAPPING

    -- Purpose : Business Data Population

    -- Project : HAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SURVEY_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "QUESTION_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "QID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "QUESTION_TEXT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "GATOR_QUESTION_KEY"
	type = "VARCHAR(32)"
	nullable = true
}

}

