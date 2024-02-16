resource "snowflake_table" "DW_REPORT_NPS_CLIENT_SCORE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "NPS_CLIENT_SCORE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.NPS_CLIENT_SCORE

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "SURVEY_RESPONSE_HEADER_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SURVEY_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "BATCH_NUMBER"
	type = "DATE"
	nullable = true
}


column {
	name = "SOURCE_BATCH_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NPS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "INCLUDE_FOR_EXEC_OPS_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDE_FOR_EXEC_OPS_CLIENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INFORMED_OF_VISIT_CHANGES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TREATING_WITH_RESPECT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHOW_COMPASSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SAFE_IN_HOME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RIGHT_SKILLS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ATTENTIVE_TO_NEEDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_HELPFULLNESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STAYING_ENTIRE_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRUSTWORTHY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ON_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECOGNIZE_CAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPROVE_EXPERIANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERALL_CAREGIVER_EXPERIANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_EMAIL_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SURVAY_COMPLETED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAM_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CARE_CORDINATION"
	type = "VARCHAR(5)"
	nullable = true
}

}

