resource "snowflake_table" "DW_REPORT_NPS_CAREGIVER_SCORE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "NPS_CAREGIVER_SCORE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.NPS_CAREGIVER_SCORE

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
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


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
	name = "BRANCH_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NPS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IMPROVE_YOUR_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SENSE_OF_BELONGING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SENSE_OF_BELONGING_TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EASILY_CLOCKIN_CLOCKOUT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EASILY_CLOCKIN_CLOCKOUT_TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPPORT_FROM_OFFICE_TEAM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPPORT_FROM_OFFICE_TEAM_TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAID_ON_TIME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAID_ON_TIME_TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SATISFIED_WITH_SCHEDULE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SATISFIED_WITH_SCHEDULE_TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREPARED_FOR_NEW_CLIENT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PREPARED_FOR_NEW_CLIENT_TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

