resource "snowflake_table" "DW_REPORT_CAREGIVER_EXIT_SURVEY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CAREGIVER_EXIT_SURVEY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CAREGIVER_EXIT_SURVEY

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
	name = "SURVEY_RESPONSE_HEADER_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_SENT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYMENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASON_FOR_LEAVING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASON_FOR_LEAVING_CHOICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_PAY_ACCURACY_AND_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_CLIENT_MATCHES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_WORK_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_CLIENT_DISTANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_HOLD_OF_CARE_SUPERVISOR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_USE_OF_SYSTEM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_RECOGNIZATION_FOR_WORK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_CAREER_PATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_EXP_HAH_SUPPORT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYMENT_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORK_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CITY_BRANCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RACE_ETHNICITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_EMPLOYED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAN_CONTACT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BEST_CONTACT_INFORMATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDE_YOUR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTACT_INFORMATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

