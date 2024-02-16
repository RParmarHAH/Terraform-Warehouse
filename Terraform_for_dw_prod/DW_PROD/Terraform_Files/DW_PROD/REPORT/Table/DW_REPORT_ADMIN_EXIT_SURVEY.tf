resource "snowflake_table" "DW_REPORT_ADMIN_EXIT_SURVEY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "ADMIN_EXIT_SURVEY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.ADMIN_EXIT_SURVEY

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
	name = "SELF_IDENTITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RE_EMPLOYMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RE_EMPLOYMENT_REASON"
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
	name = "EMPLOYEE_EXPERIENCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LET_GO_BY_MANAGEMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASON_FOR_LEAVING_CHOICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REASON_FOR_LEAVING_RANK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COMPLETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

