resource "snowflake_table" "DISC_JAZZHR_APPLICANTS_DETAILS_JOBS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "JAZZHR"
	name = "APPLICANTS_DETAILS_JOBS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.JAZZHR.APPLICANTS_DETAILS_JOBS

    -- Purpose : Discovery Data Population

    -- Project : JAZZHR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "JOB_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICANT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRING_LEAD_RATING"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AVERAGE_RATING"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "WORKFLOW_STEP_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICANT_PROGRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLY_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

