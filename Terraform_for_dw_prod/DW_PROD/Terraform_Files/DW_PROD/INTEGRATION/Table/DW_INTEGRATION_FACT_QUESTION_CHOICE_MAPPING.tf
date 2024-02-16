resource "snowflake_table" "DW_INTEGRATION_FACT_QUESTION_CHOICE_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "FACT_QUESTION_CHOICE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.FACT_QUESTION_CHOICE_MAPPING

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SURVEY_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_QUESTION_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "QUESTION_ID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CHOICE_LABLE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHOICE_TEXT"
	type = "VARCHAR(32)"
	nullable = true
}

}

