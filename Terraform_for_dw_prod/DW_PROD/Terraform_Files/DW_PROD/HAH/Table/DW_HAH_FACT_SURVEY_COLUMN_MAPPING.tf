resource "snowflake_table" "DW_HAH_FACT_SURVEY_COLUMN_MAPPING" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	name = "FACT_SURVEY_COLUMN_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.HAH.FACT_SURVEY_COLUMN_MAPPING

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
	name = "SURVEY_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "SOURCE_COLUMN_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DESTINATION_COLUMN_NAME"
	type = "VARCHAR(200)"
	nullable = true
}

}

