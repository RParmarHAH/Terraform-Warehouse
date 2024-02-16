resource "snowflake_table" "DW_HAH_FACT_SURVEY_RESPONSE_SCALE_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_SURVEY_RESPONSE_SCALE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_SURVEY_RESPONSE_SCALE_MAPPING

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
	name = "SURVEY_QUESTION_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "QUESTION_TEXT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "QUESTION_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ANSWER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ANSWER_SCALE"
	type = "NUMBER(38,0)"
	nullable = true
}

}

